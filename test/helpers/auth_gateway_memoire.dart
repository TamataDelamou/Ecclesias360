import 'dart:async';

import 'package:ecclesias_360/core/error/app_error.dart';
import 'package:ecclesias_360/features/auth/data/auth_gateway.dart';
import 'package:ecclesias_360/features/auth/domain/models/identifiant_connexion.dart';
import 'package:ecclesias_360/features/auth/domain/models/methode_otp.dart';

/// Implémentation en mémoire de `AuthGateway` pour les tests : un seul code
/// valide (`codeValide`), aucun réseau. Ne sert jamais en production.
class AuthGatewayMemoire implements AuthGateway {
  AuthGatewayMemoire({UtilisateurAuthentifie? connecte, this.codeValide = '123456'}) : _courant = connecte;

  /// Session déjà restaurée au démarrage : sur une base vide, ce compte
  /// devient l'administrateur d'amorçage — c'est le point de départ de tous
  /// les tests de flux existants.
  factory AuthGatewayMemoire.connecte() => AuthGatewayMemoire(
        connecte: const UtilisateurAuthentifie(
          id: 'compte-test-administrateur',
          identifiant: IdentifiantEmail('admin@ecclesias.test'),
        ),
      );

  final String codeValide;
  final List<(IdentifiantConnexion, MethodeOtp)> codesEnvoyes = [];
  final StreamController<UtilisateurAuthentifie?> _changements = StreamController.broadcast();
  UtilisateurAuthentifie? _courant;

  @override
  UtilisateurAuthentifie? get utilisateurCourant => _courant;

  @override
  Stream<UtilisateurAuthentifie?> get changements => _changements.stream;

  @override
  Future<void> envoyerCode(IdentifiantConnexion identifiant, MethodeOtp methode) async {
    codesEnvoyes.add((identifiant, methode));
  }

  @override
  Future<UtilisateurAuthentifie> verifierCode(IdentifiantConnexion identifiant, String code) async {
    if (code.trim() != codeValide) throw AppError.codeOtpInvalide();
    final utilisateur = UtilisateurAuthentifie(id: 'compte-${identifiant.valeur}', identifiant: identifiant);
    _courant = utilisateur;
    _changements.add(utilisateur);
    return utilisateur;
  }

  @override
  Future<void> deconnecter() async {
    _courant = null;
    _changements.add(null);
  }
}
