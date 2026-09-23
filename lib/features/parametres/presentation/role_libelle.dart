import '../../../l10n/app_localizations.dart';
import '../domain/models/role.dart';

/// Libellé traduit d'un rôle (RG-XXIII-02), partagé par tous les écrans.
String libelleRole(AppLocalizations l10n, Role role) => switch (role) {
      Role.utilisateurSimple => l10n.roleUtilisateurSimple,
      Role.membre => l10n.roleMembre,
      Role.responsable => l10n.roleResponsable,
      Role.pasteur => l10n.rolePasteur,
      Role.administrateur => l10n.roleAdministrateur,
    };
