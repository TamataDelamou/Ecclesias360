import 'package:ecclesias_360/features/parametres/domain/models/role.dart';
import 'package:ecclesias_360/features/patrimoine/domain/models/etat_bien.dart';
import 'package:ecclesias_360/features/patrimoine/domain/rules/patrimoine_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('raisonBlocageSortieBien (RG-XX-02)', () {
    test('un pasteur peut sortir un bien non encore sorti', () {
      expect(PatrimoineRules.raisonBlocageSortieBien(roleActeur: Role.pasteur, dejaSorti: false), isNull);
    });

    test('un administrateur (rang supérieur) peut sortir un bien', () {
      expect(PatrimoineRules.raisonBlocageSortieBien(roleActeur: Role.administrateur, dejaSorti: false), isNull);
    });

    test('un responsable (rang inférieur au pasteur) ne peut pas sortir un bien', () {
      final erreur = PatrimoineRules.raisonBlocageSortieBien(roleActeur: Role.responsable, dejaSorti: false);
      expect(erreur?.code, 'role_insuffisant_pour_sortie_bien');
    });

    test('un bien déjà sorti ne peut pas être sorti à nouveau, même par un rôle habilité', () {
      final erreur = PatrimoineRules.raisonBlocageSortieBien(roleActeur: Role.administrateur, dejaSorti: true);
      expect(erreur?.code, 'bien_deja_sorti');
    });
  });

  group('seChevauchent (RG-XX-03)', () {
    test('deux plages disjointes ne se chevauchent pas', () {
      final result = PatrimoineRules.seChevauchent(
        debutA: DateTime(2026, 1, 1),
        finA: DateTime(2026, 1, 2),
        debutB: DateTime(2026, 1, 3),
        finB: DateTime(2026, 1, 4),
      );
      expect(result, isFalse);
    });

    test('deux plages qui se recouvrent partiellement se chevauchent', () {
      final result = PatrimoineRules.seChevauchent(
        debutA: DateTime(2026, 1, 1),
        finA: DateTime(2026, 1, 3),
        debutB: DateTime(2026, 1, 2),
        finB: DateTime(2026, 1, 4),
      );
      expect(result, isTrue);
    });

    test('une plage incluse dans une autre se chevauche', () {
      final result = PatrimoineRules.seChevauchent(
        debutA: DateTime(2026, 1, 1),
        finA: DateTime(2026, 1, 10),
        debutB: DateTime(2026, 1, 3),
        finB: DateTime(2026, 1, 4),
      );
      expect(result, isTrue);
    });
  });

  group('raisonBlocageReservation (RG-XX-03)', () {
    test('aucune réservation existante : la nouvelle réservation est autorisée', () {
      final erreur = PatrimoineRules.raisonBlocageReservation(
        dateDebut: DateTime(2026, 3, 1),
        dateFin: DateTime(2026, 3, 2),
        reservationsExistantes: const [],
      );
      expect(erreur, isNull);
    });

    test('une réservation existante qui chevauche la nouvelle plage bloque la réservation', () {
      final erreur = PatrimoineRules.raisonBlocageReservation(
        dateDebut: DateTime(2026, 3, 1, 10),
        dateFin: DateTime(2026, 3, 1, 14),
        reservationsExistantes: [(DateTime(2026, 3, 1, 12), DateTime(2026, 3, 1, 18))],
      );
      expect(erreur?.code, 'reservation_conflit_detecte');
    });

    test('une réservation existante sur une autre plage n\'empêche pas la nouvelle réservation', () {
      final erreur = PatrimoineRules.raisonBlocageReservation(
        dateDebut: DateTime(2026, 3, 1, 10),
        dateFin: DateTime(2026, 3, 1, 12),
        reservationsExistantes: [(DateTime(2026, 3, 1, 14), DateTime(2026, 3, 1, 18))],
      );
      expect(erreur, isNull);
    });
  });

  group('calculerQuantiteStock / estSousSeuilAlerte (RG-XX-05)', () {
    test('la quantité en stock est le total des entrées moins les sorties', () {
      expect(PatrimoineRules.calculerQuantiteStock(totalEntrees: 50, totalSorties: 20), 30);
    });

    test('sans seuil configuré, un bien n\'est jamais sous alerte', () {
      expect(PatrimoineRules.estSousSeuilAlerte(quantiteActuelle: 0, seuilAlerte: null), isFalse);
    });

    test('une quantité strictement inférieure au seuil déclenche l\'alerte', () {
      expect(PatrimoineRules.estSousSeuilAlerte(quantiteActuelle: 4, seuilAlerte: 5), isTrue);
    });

    test('une quantité égale au seuil ne déclenche pas l\'alerte', () {
      expect(PatrimoineRules.estSousSeuilAlerte(quantiteActuelle: 5, seuilAlerte: 5), isFalse);
    });
  });

  group('detecterEcart (RG-XX-04)', () {
    test('aucun écart quand état et quantité déclarés correspondent au constat', () {
      final ecart = PatrimoineRules.detecterEcart(
        etatDeclare: EtatBien.bon,
        etatConstate: EtatBien.bon,
        quantiteDeclaree: 10,
        quantiteConstatee: 10,
      );
      expect(ecart, isFalse);
    });

    test('un état constaté différent de l\'état déclaré est un écart', () {
      final ecart = PatrimoineRules.detecterEcart(etatDeclare: EtatBien.bon, etatConstate: EtatBien.horsService);
      expect(ecart, isTrue);
    });

    test('une quantité constatée différente de la quantité déclarée est un écart', () {
      final ecart = PatrimoineRules.detecterEcart(
        etatDeclare: EtatBien.bon,
        etatConstate: EtatBien.bon,
        quantiteDeclaree: 10,
        quantiteConstatee: 8,
      );
      expect(ecart, isTrue);
    });

    test('sans donnée de quantité (bien hors stock), seul l\'état est comparé', () {
      final ecart = PatrimoineRules.detecterEcart(etatDeclare: EtatBien.neuf, etatConstate: EtatBien.neuf);
      expect(ecart, isFalse);
    });
  });
}
