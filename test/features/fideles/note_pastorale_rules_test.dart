import 'package:ecclesias_360/features/fideles/domain/rules/note_pastorale_rules.dart';
import 'package:ecclesias_360/features/parametres/domain/models/role.dart';
import 'package:flutter_test/flutter_test.dart';

/// RG-II-11 — confidentialité des notes pastorales privées, miroir local des
/// policies de 0026.
void main() {
  const auteur = 'pasteur-auteur';
  const concerne = 'fidele-concerne';

  bool peutConsulter(Role role, String? acteur) => NotePastoraleRules.peutConsulter(
        role: role,
        acteurFideleId: acteur,
        auteurFideleId: auteur,
        fideleConcerneId: concerne,
      );

  group('peutConsulter', () {
    test('l\'auteur lit sa note, même sans le rang de pasteur', () {
      expect(peutConsulter(Role.membre, auteur), isTrue);
    });

    test('un autre pasteur et l\'administrateur lisent par leur rang', () {
      expect(peutConsulter(Role.pasteur, 'autre-pasteur'), isTrue);
      expect(peutConsulter(Role.administrateur, null), isTrue);
    });

    test('ni un responsable ni un membre ne lisent la note d\'autrui', () {
      expect(peutConsulter(Role.responsable, 'responsable'), isFalse);
      expect(peutConsulter(Role.membre, 'membre'), isFalse);
      expect(peutConsulter(Role.utilisateurSimple, null), isFalse);
    });

    test('le fidèle concerné ne lit jamais la note écrite sur lui, même pasteur ou administrateur', () {
      expect(peutConsulter(Role.membre, concerne), isFalse);
      expect(peutConsulter(Role.pasteur, concerne), isFalse);
      expect(peutConsulter(Role.administrateur, concerne), isFalse);
    });
  });

  group('peutOuvrirNotesDuFidele', () {
    test('pasteur (ou plus), jamais sur sa propre fiche', () {
      expect(
        NotePastoraleRules.peutOuvrirNotesDuFidele(role: Role.pasteur, acteurFideleId: 'p', fideleConcerneId: concerne),
        isTrue,
      );
      expect(
        NotePastoraleRules.peutOuvrirNotesDuFidele(role: Role.pasteur, acteurFideleId: concerne, fideleConcerneId: concerne),
        isFalse,
      );
      expect(
        NotePastoraleRules.peutOuvrirNotesDuFidele(role: Role.responsable, acteurFideleId: 'r', fideleConcerneId: concerne),
        isFalse,
      );
    });
  });

  group('raisonBlocageRedaction', () {
    String? code(Role role, String? acteur, {String contenu = 'Suivi'}) => NotePastoraleRules.raisonBlocageRedaction(
          role: role,
          acteurFideleId: acteur,
          fideleConcerneId: concerne,
          contenu: contenu,
        )?.code;

    test('un pasteur lié à sa fiche rédige', () => expect(code(Role.pasteur, auteur), isNull));

    test('refusée à un responsable, à un compte sans fiche et sur sa propre fiche', () {
      expect(code(Role.responsable, 'r'), 'note_pastorale_redaction_reservee');
      expect(code(Role.administrateur, null), 'note_pastorale_redaction_reservee');
      expect(code(Role.pasteur, concerne), 'note_pastorale_redaction_reservee');
    });

    test('refusée si le contenu est vide', () {
      expect(code(Role.pasteur, auteur, contenu: '   '), 'note_pastorale_contenu_vide');
    });
  });

  group('raisonBlocageModification', () {
    test('par l\'auteur seul', () {
      expect(
        NotePastoraleRules.raisonBlocageModification(
          acteurFideleId: auteur,
          auteurFideleId: auteur,
          fideleConcerneId: concerne,
          contenu: 'Complément',
        ),
        isNull,
      );
      expect(
        NotePastoraleRules.raisonBlocageModification(
          acteurFideleId: 'autre-pasteur',
          auteurFideleId: auteur,
          fideleConcerneId: concerne,
          contenu: 'Complément',
        )?.code,
        'note_pastorale_modification_reservee',
      );
    });
  });
}
