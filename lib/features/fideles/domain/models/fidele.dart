import 'sexe.dart';
import 'statut_civil.dart';
import 'statut_fidele.dart';
import 'statut_spirituel.dart';

/// Entité pure Fidèle (Module II, RG-II-*). `id` sert de matricule
/// (RG-II-01) — UUID v4 local, définitif dès la création (RG-OFF-03),
/// jamais renuméroté, y compris en cas de mutation entre nœuds (Module IX).
class Fidele {
  const Fidele({
    required this.id,
    required this.noeudId,
    required this.nom,
    required this.prenoms,
    required this.dateNaissance,
    required this.sexe,
    required this.statutCivil,
    required this.statutSpirituel,
    required this.statut,
    required this.createdAt,
    required this.updatedAt,
    this.dateConversion,
    this.dateBapteme,
    this.egliseProvenance,
    this.photoUrl,
    this.telephone,
    this.email,
    this.adresse,
  });

  final String id;
  final String noeudId;
  final String nom;
  final String prenoms;
  final DateTime dateNaissance;
  final Sexe sexe;
  final StatutCivil statutCivil;
  final StatutSpirituel statutSpirituel;
  final StatutFidele statut;
  final DateTime? dateConversion;
  final DateTime? dateBapteme;
  final String? egliseProvenance;
  final String? photoUrl;
  final String? telephone;
  final String? email;
  final String? adresse;
  final DateTime createdAt;
  final DateTime updatedAt;

  String get nomComplet => '$prenoms $nom';
}
