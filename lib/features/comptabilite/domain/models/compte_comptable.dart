import 'type_compte.dart';

/// Compte du plan comptable paramétrable (Module XXI, RG-XXI-01). Référentiel
/// fermé et extensible : neuf comptes seedés pour amorcer (mêmes précédent
/// que `CategorieBien`/`TypeOffrande`/`NatureFaute`), désactivable mais
/// jamais supprimable une fois utilisé (RG-XXIII-03).
class CompteComptable {
  const CompteComptable({
    required this.id,
    required this.codeCompte,
    required this.libelle,
    required this.type,
    required this.statut,
  });

  final String id;
  final String codeCompte;
  final String libelle;
  final TypeCompte type;
  final String statut;
}
