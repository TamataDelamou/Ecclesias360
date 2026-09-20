# AGENTS.md — Feuille de route de développement

> Fichier de référence pour **tout agent de codage** (humain ou IA) travaillant sur Ecclésias360.
> À lire **en premier** avant toute tâche, et à **mettre à jour** à chaque module livré.
> Source de vérité métier : `Cahier_de_Conception_Ecclesias360_v2.1.md` (règles `RG-*`).
>
> **Note de reconstruction (2026-09)** : ce dépôt repart de zéro après perte totale du disque de
> développement précédent. `RECONSTRUCTION_ecclesias360.md` contient la spécification technique
> intégrale de tout ce qui avait été construit au-delà du Cahier (CV Ecclésiastique, i18n, Bible
> Paliers 1-2 + multi-versions, Cantiques, Église Sœur) — ce sont des décisions déjà tranchées,
> à réappliquer telles quelles dès que leurs modules prérequis existent, pas à redébattre.

---

## 1. Identité du projet

- **Nom** : Ecclésias360 — plateforme intégrée de gestion ecclésiastique.
- **Client** : Global Service Groupe.
- **Package Dart** : `ecclesias_360`.
- **Dart SDK** : `^3.12.2` · **Flutter** avec `flutter_lints ^6.0.0`.
- **Langue du code et des commits** : français.

---

## 2. Stack technique

| Domaine | Choix | Remarque |
|---|---|---|
| UI / état | Flutter, Material 3, `provider` (ChangeNotifier) | Un `Controller` par module |
| Routage | `go_router` | Routes centralisées dans `core/router/app_router.dart` |
| Persistance locale | `drift` + `sqlite3_flutter_libs` | Base **offline-first** unique |
| Backend | Supabase (`supabase_flutter ^2.17.2`) | Clé via `publishableKey` (et non `anonKey`, dépréciée) |
| Config / secrets | `flutter_dotenv` + `.env` | `.env` **jamais commité** |
| Stockage sensible | `flutter_secure_storage` | Jetons, secrets |
| Codegen | `build_runner` + `drift_dev` | Génère les classes `*Row` et `*Companion` |
| Analyse | `flutter analyze` (flutter_lints) | **Zéro issue** exigé avant commit |
| Tests | `flutter test` | Règles métier = tests unitaires purs |

---

## 3. Architecture (feature-first / clean)

```
domain/        → logique pure, SANS dépendance Flutter/Drift/Supabase (testable)
  models/      → entités, enums, DTO
  rules/       → règles métier RG-* (fonctions/classes pures)
data/
  local/       → tables Drift + requêtes
  remote/      → sources de données Supabase
  referential/ → chargeurs JSON de assets/config/
  <module>_repository.dart → écriture locale + outbox + sync
application/
  <module>_controller.dart → ChangeNotifier exposé aux écrans
presentation/
  *.dart        → écrans (un fichier par écran)
```

**Règle de dépendance** : `presentation → application → data → domain`, jamais l'inverse.
Les règles de `domain/rules` ne doivent référencer ni `BuildContext`, ni Drift, ni Supabase.

---

## 4. Structure des répertoires

```
lib/
  main.dart
  app.dart
  l10n/
    app_fr.arb   app_en.arb   app_es.arb   app_pt.arb
  core/
    config/app_config.dart
    constants/app_routes.dart
    theme/
    router/app_router.dart
    utils/id_generator.dart
    ai/
    widgets/icon_catalog.dart
  features/
    auth/ onboarding/ home/
    organization/ fideles/ ministries/ dons_spirituels/ professions/
    groupes_eglise/ comite/ archivage/ deplacements/ discipline/
    finances/ presences/ evenements/ patrimoine/ mediatheque/
assets/
  config/   fonts/
supabase/migrations/
test/
```

Tables Drift centralisées dans `lib/features/organization/data/local/`
(`tables.dart` + `app_database.dart` + `app_database.g.dart`), partagées par tous les modules.

Il n'existe **aucun fichier `core/constants/app_strings.dart`** : les chaînes UI passent par le
système ARB / `l10n.*` dès l'origine (voir §5) — ne pas recréer ce fichier.

---

## 5. Conventions de code

- Nommage : PascalCase classes/widgets, camelCase méthodes/variables, snake_case fichiers.
- Chaînes UI : jamais en dur → système ARB / `l10n.*`, aucun fichier de constantes intermédiaire
  (pas de `app_strings.dart` — supprimé dans la session précédente pour cette raison, ne pas le
  réintroduire, même temporairement).
- Routes : jamais en dur → `core/constants/app_routes.dart`.
- Valeurs IA : zéro valeur en dur → `assets/config/ai_roles.json`.
- Typage : éviter `dynamic`.
- Async : `context.mounted` après tout `await` avant usage de `context`.
- Thème — chaque sorte d'expression a un seul foyer, jamais de deuxième
  fichier de constantes qui ferait doublon :

  | Sorte d'expression | Foyer |
  |---|---|
  | Couleurs | `core/theme/app_palettes.dart` |
  | Espacements, rayons, tailles, durées | `core/theme/app_dimensions.dart` |
  | Valeurs par défaut des règles (non imposées par le Cahier) | `core/theme/app_defaults.dart` |
  | Pays, devise, langue | référentiel du Kernel (voir §11) |
  | Assemblage `ThemeData` (Material) | `core/theme/design_tokens.dart` |

  Deux tests (`test/core/theme/`) interdisent les couleurs en dur dans tout
  `lib/`, et les nombres de mise en page en dur dans les écrans déjà migrés
  vers `AppDimensions` (liste dans le test lui-même, à étendre à chaque
  écran migré). Un test de contraste (`app_palettes_contrast_test.dart`)
  vérifie chaque palette actuelle et future contre le Cahier §8.3
  (lisibilité en plein soleil) : WCAG AA texte normal (4.5:1) pour le texte
  courant, WCAG AA texte large (3:1) pour un libellé sur fond coloré
  (bouton, badge).
- Offline-first (RG-OFF) : écriture Drift d'abord, puis outbox, sync Supabase secondaire et jamais bloquante.
- `flutter analyze` → **No issues found!** exigé.

---

## 6. Agents IA (pool fermé de noms bibliques/angéliques)

| Nom | Rôle | Statut |
|---|---|---|
| Ezra | Greffier des fidèles (RG-II-06) | actif |
| Nathan | Assistant pastoral (RG-II-02) | actif |
| Dina | Dédoublonnage / import (RG-II-09) | actif |
| Uriel | Veilleur RGPD (RG-II-05/10) | actif |
| Lailah | Conseiller d'affectation ministères (RG-IV-03) | actif |
| Logos | Réservé (Module XVI) | réservé |
| Charmeine | Réservé (Module XVI) | réservé |

Garde-fous : les IA ne modifient jamais les données directement — suggestions uniquement,
confirmation utilisateur, exécution par le service métier normal, traçée. Chaque rôle déclare
`permission` (`suggest`/`propose`), `scope`, `forbiddenFields` dans `assets/config/ai_roles.json`.

---

## 7. État d'avancement des modules

> Repli à zéro (2026-09) : ce tableau reflète l'état réel du dépôt reconstruit, pas l'état
> atteint avant le sinistre. Ordre canonique = Annexe D du Cahier (voir §8 « Phases » ci-dessous).
> Pour les modules/extensions déjà spécifiés en détail dans `RECONSTRUCTION_ecclesias360.md`
> (CV, Bible multi-versions, Cantiques, Église Sœur, sécurité RG-SEC-05), la spécification est
> **déjà tranchée** — seule l'implémentation reste à faire, dès que les prérequis existent.

| Module (n° Cahier) | Statut |
|---|---|
| Socle transversal (Phase 1) | ⚠️ partiel — `AppDatabase` (Drift), `IdGenerator`, `SyncCoordinator` (outbox RG-OFF-02) livrés. Sécurité de base (RG-SEC-05) : helpers `security definer` `fidele_courant_id()`/`role_courant()`/`noeuds_du_perimetre()` (search_path durci sur `pg_catalog, pg_temp`) livrés et vérifiés par exécution réelle (PGlite + stub du schéma `auth`), miroir Dart `PerimetreRules` testé en isolation. `create policy` intentionnellement absentes (activation groupée au déploiement de l'auth, RG-SEC-01, non construit) ; 5 palettes de thème (Cahier §8.3, maquette visuelle) livrées dans `app_palettes.dart` avec correction de contraste documentée par palette, jetons d'espacement (`app_dimensions.dart`) et de valeurs par défaut (`app_defaults.dart`) — voir §5 ; écrans Organisation et accueil migrés vers ces jetons ; pas de sélecteur de thème (décision produit non tranchée par le Cahier, non construite) ; 88 chaînes des écrans Fidèles et Comité migrées vers `l10n/app_*.arb` (fr/en/es/pt), 2 jetons supplémentaires (`labelColumnWidthNarrow`, `dividerHairline`) ajoutés à `app_dimensions.dart` pour ces écrans; reprise du design visuel de la maquette Rocket (`ecclesias360_Nouveau`, référence graphique uniquement — données fictives, aucune logique métier) amorcée : typographie DM Sans (`google_fonts`) et élévation/ombre différenciée clair/sombre ajoutées à `design_tokens.dart`, coquille de navigation à 4 onglets (`core/widgets/app_shell.dart`, `NavigationBar`) branchée en `ShellRoute` sur les 4 écrans racines sans paramètre (Accueil, Organisation, Fidèles, Paramètres — nouvel écran `parametres_screen.dart`), écran d'accueil reconstruit en tableau de bord (grille de tuiles de modules) façon `dashboard_screen.dart` de la maquette. Portée volontairement limitée aux écrans déjà livrés : les ~20 écrans de la maquette sans module métier construit (Cultes, Finances, Comptabilité, Bible, CV Ecclésiastique, Église Sœur, Messagerie...) ne sont pas repris avant que leur module existe (logique avant design) |
| I — Organisation | ⚠️ partiel — Lot 1+2 (Domaine, Données, Contrôleur, écrans) + Lot 3 (`ResponsableNoeud`/`node_responsables`, RG-I-05) livrés : 9/9 points d'écran mobile du Cahier couverts (7 écrans réels — arbre avec recherche intégrée, fiche avec statistiques rapides intégrées, création/édition, historique des rattachements, annuaire des Églises, liste des responsables + affectation). Éditions Windows dédiées (layout multi-colonnes) : **non bloquées par un module** — choix délibéré de différer (mêmes écrans que mobile pour l'instant), reprise possible dès que priorisé |
| II — Fidèles | ⚠️ partiel — Lot 1 (Domaine & Données) + Lot 2 (Contrôleur & écrans) livrés : `fideles`/`liens_familiaux`/`historique_fideles`/`tuteurs`, RG-II-01/02/03/04/05/06/08 câblés. 6 écrans sur 14 livrés (liste+recherche, fiche+cheminement+liens+tuteur, création, historique). Écrans/règles différés, chacun avec sa dépendance exacte : **écran 8 scan/capture photo** — infra caméra/galerie (ex. `image_picker`), aucun module bloquant ; **écran 9 import rapide contact** — infra carnet d'adresses (ex. `flutter_contacts`), aucun module bloquant ; **écran 10 fiche synthèse imprimable** — infra génération PDF (ex. `printing`/`pdf`), version de base non bloquée, version enrichie RG-II-07 bloquée par III/IV/V/VI/VII/IX/X/XI/XII/XVIII/XIX ; **écran 11 / RG-II-09 fusion de doublons, import de masse** — dans le périmètre propre du Module II, aucun module bloquant ; **écran 12 statuts spirituels (vue par catégorie)** — dans le périmètre propre du Module II (agrégation de `Fidele.statutSpirituel` déjà en base), aucun module bloquant ; **écran 13 notes pastorales privées** — bloqué par RG-SEC-01 (authentification/session réelle, restriction de rôle à l'exécution au-delà du moteur `CapacityRules` déjà livré) ; **écran 14 / RG-II-10 consentement RGPD (écran « Profil et préférences utilisateur », vit dans le Module XXIII)** — bloqué par RG-SEC-01 (traçage de l'auteur du consentement) et par RG-SEC-10/Module XVII pour la gestion par canal ; **RG-II-07 agrégation en lecture seule** — bloquée par les modules qu'elle agrège (III, IV, V, VI, VII, IX, X, XI, XII, XVIII, XIX), aucun construit |
| XXIII — Paramètres de l'application | ⚠️ partiel — RG-XXIII-02 (moteur de capacités `Role`/`CapacityRules`/`roles.json`) et RG-XXIII-03 (référentiel `ZoneGeographique`, désactivation non destructive, **conservé tel quel — décision Kernel tranchée, voir §11 point 1** : zone pastorale interne, distincte de l'adresse Kernel) livrés, avec écrans de consultation (rôles) et de gestion (zones géographiques). Éléments différés, chacun avec sa dépendance exacte : **capacités non câblées dans l'UI des Modules I/II** — bloqué par RG-SEC-01 (pas de session/rôle courant réel à l'exécution) ; **RG-XXIII-01 versionnage propagé des référentiels partagés** — bloqué par l'absence de mécanisme de versionnage dans `SyncCoordinator` (à construire) et par les référentiels don spirituel (Module IV) et type d'offrande (Module XI), non construits — le référentiel zones géographiques existe déjà mais sans versionnage ; **RG-XXIII-04 sauvegardes automatiques** — infra prévue en Phase 6 Durcissement et déploiement (cf. RG-SEC-13), aucun module métier bloquant ; **RG-XXIII-05 multilingue par nœud : non bloqué** — Module I (nœuds) et le socle i18n (ARB) existent déjà, à construire dès que priorisé, indépendamment de la Phase 2 ; **RG-XXIII-06 accès réservé + historisation auteur** — bloqué par RG-SEC-01 ; **référentiels dons/offrandes/professions** — dons spirituel bloqué par Module IV, type d'offrande par Module XI, professions par Module V ; **écran « Profil et préférences utilisateur » (RG-II-10)** — bloqué par RG-SEC-01, même raison |
| III — Ministères et départements | ⚠️ partiel — `Ministere`/`AffectationMinistere`/`MandatResponsable`/`ActiviteMinistere` + catalogue `TypeMinistere` (RG-III-04, 24 types standards seedés, protégés) livrés. RG-III-01 (un seul responsable actif par ministère), RG-III-02 (mandats, échéances), RG-III-05 (historique via mandats clos + journal d'activités) câblés. 7 écrans sur 9 livrés (liste, fiche, création, membres + affectation, historique des responsables, journal d'activités, mandats arrivant à échéance) ; **écran 8 suggestions d'affectation basées sur les dons** — bloqué par le Module IV (Dons spirituels), non construit ; **RG-III-03 suspension disciplinaire** — structure de données prête (`suspendreAffectationsActives`/`reintegrerAffectations`), bloquée par le Module X (Discipline), non construit, non appelée depuis l'UI actuelle. Synchronisation distante limitée à `Ministere` pour cette itération (même limitation documentée que ZonesGeographiques) |
| IV — Dons spirituels | ⚠️ partiel — `DonSpirituel` (référentiel fixe des 9 dons, 1 Corinthiens 12, RG-IV-04, seedé, non modifiable dans cette itération) + `DonFidele` (évaluations append-only, RG-IV-01/02 : l'historique n'est jamais écrasé) + `DonMinistereCompatible` (table de correspondance RG-IV-03, vide par défaut — jugement pastoral/organisationnel hors périmètre technique, alimente la suggestion sans jamais affecter automatiquement) livrés. 6 écrans sur 6 livrés (liste des dons d'un fidèle, évaluation, référentiel, historique d'évolution, suggestions de ministères compatibles, statistiques de répartition par nœud). Synchronisation distante différée pour ce module (même précédent documenté que ZonesGeographiques/Ministere) |
| V — Groupes professionnels | ⚠️ partiel — `Profession` (référentiel hiérarchisé catégorie/métier, RG-V-02, paramétrable, 12 métiers de départ, sans protection « standard » contrairement aux Modules III/IV) + `ProfessionFidele` (déclaration vérifiable, RG-V-01 : `declare` → `verifie`, jamais l'inverse) + `Sollicitation` (RG-V-03, sollicitation nommée tracée avec réponse, une ligne par fidèle sollicité, seules les déclarations vérifiées sont ciblées) livrés. 5 écrans sur 5 livrés (liste des groupes + recherche par métier combinées, fiche compétence d'un fidèle + déclaration combinées, fiche groupe + sollicitation combinées). Synchronisation distante différée pour ce module (même précédent documenté que ZonesGeographiques/Ministere/DonSpirituel) |
| VI — Groupes de l'Église | ⚠️ partiel — `GroupeEglise` (segment démographique/fonctionnel, `typeRegle` auto/manuel) + `AppartenanceGroupe` (non exclusive, RG-VI-02) + `CriteresGroupe` livrés. RG-VI-01 : `GroupeRules.correspond()` évalue un fidèle, `recalculerAppartenancesAuto()` synchronise les lignes auto sans jamais toucher aux lignes manuelles, `affecterManuellement()` applique la priorité à la règle automatique sauf dérogation tracée (motif obligatoire en cas de conflit). 11 groupes de départ (7 auto calculables + 4 manuels sans critère). 4 écrans (liste, membres + affectation manuelle + statistiques combinés, règles automatiques, vue depuis la fiche fidèle). **Recalcul automatique déclenché manuellement** (bouton dédié) — bloqué par l'absence de hook sur la création/modification d'un fidèle (nécessiterait un couplage inter-modules non construit) ; en pratique, un administrateur doit relancer le recalcul après toute modification pertinente de la fiche fidèle. Synchronisation distante différée pour ce module (même précédent documenté que ZonesGeographiques/Ministere/DonSpirituel/Profession) |
| VII — Comité local | ⚠️ partiel — `MembreComite` (RG-VII-01, sous-ensemble qualifié des fidèles) + `QuorumComite` (RG-VII-05, paramétrable par nœud) + `SeanceComite`/présents + `Decision` (RG-VII-04/05) + `ProcesVerbal`/`ErratumPv` (RG-VII-02, immuabilité après validation) + `TacheSuivi` (RG-VII-03) livrés. Le quorum est calculé par le système (jamais déclaré), une décision ne peut être adoptée que si le quorum de sa séance est explicitement atteint. 7 écrans du Cahier couverts par 4 écrans réels (membres+fiche combinés, séances/historique des PV, création de séance combinant convocation+saisie, détail de séance combinant décisions+PV+tâches). **RG-VII-03 archivage automatique (Module VIII)** — ✅ livré : `documentArchiveId` est renseigné automatiquement à la validation du PV quand `ComiteRepository` reçoit un `ArchivageRepository` (voir Module VIII ci-dessus). **RG-VII-04 propagation au Module X** — `porteeDisciplinaire` est un simple drapeau informatif, bloqué par le Module X, non construit. Synchronisation distante différée pour ce module (même précédent documenté que les modules précédents) |
| XII — Cultes | ⚠️ partiel — `Culte`/`SequenceLiturgique`/`PresenceCulte`/`PublicationCulte`/`PropositionTheme`/`VoteProposition` (RG-XII-01/02/03/05/06) livrés : domaine, données Drift, migration. RG-XII-02 (modes de présence nominal/global mutuellement exclusifs) et RG-XII-05 (séries récurrentes hebdomadaires) câblés dans `CulteRepository`. RG-XII-06 : décompte des votes toujours recalculé depuis `votes_proposition`, jamais un compteur mutable. 9 écrans du Cahier couverts par 4 écrans réels (liste des cultes + création avec option série récurrente, fiche détaillée combinant statut/liturgie/présences/publication post-culte, propositions de thème avec soumission et vote) ; **`propositionsVoterEnTantQue`** — sélecteur de fidèle actif en l'absence de session réelle (RG-SEC-01 non construit), même convention que les autres modules ; **RG-XII-03 archivage automatique dans la médiathèque (Module XIII)** — non construit, la publication reste locale au Module XII pour cette itération ; **RG-XII-04 rapprochement des offrandes de culte** — bloqué par le Module XI (Finances), non construit ; **classement automatique des propositions par l'assistant IA (Module XVI, RG-XII-06)** — non construit, `categorie` reste `null`. Synchronisation distante différée pour ce module (même précédent documenté que les modules précédents) |
| VIII — Archivage documentaire | ⚠️ partiel — Lot 1 (domaine, données, migration) livré : `DocumentArchive`/`VersionDocument`/`NomenclatureArchivage` (RG-VIII-01/02/03/04/05). `ArchivageRepository.archiver` attribue un numéro immuable dès l'appel (nomenclature paramétrable, jetons `{type}`/`{noeud}`/`{annee}`/`{sequence}`), crée systématiquement la version 1 ; `nouvelleVersion`/`mettreEnCorbeille`/`restaurerDeCorbeille`/`purgerDefinitivement` couvrent RG-VIII-02/05 (aucune méthode de modification ou de suppression directe n'est exposée — absence d'API délibérée) ; `documentsDe` couvre la navigation croisée RG-VIII-04. Branché en producteur réel : `ComiteRepository` reçoit un `ArchivageRepository?` optionnel et archive automatiquement le PV à sa validation (RG-VII-03), même pattern d'injection optionnelle que CV/Déplacements documenté dans `RECONSTRUCTION_ecclesias360.md` §2. Éléments différés, chacun avec sa dépendance exacte : **RG-VIII-06 (garantie de séquence unique inter-appareils à la synchronisation)** — bloqué par l'absence de synchronisation distante active, même précédent documenté que tous les autres modules ; numérotation locale déterministe pour cette itération ; **écrans (Lot 2)** — bibliothèque documentaire, consultation/historique des versions, corbeille, file d'attente hors ligne, non construits ; **écran « génération depuis un modèle » / éditeur de modèles de documents** — le modèle de données du Cahier ne définit aucune entité `ModeleDocument` (seulement `NomenclatureArchivage`, qui numérote, ne génère pas de contenu), différé faute d'entité porteuse ; **écran « signature/validation »** — reste dans le module producteur (ex. `ComiteRepository.validerProcesVerbal`, déjà existant), Module VIII n'est appelé qu'une fois le contenu définitivement validé ; **restriction d'accès par niveau de confidentialité (RG-VIII-03)** — le niveau est calculé et stocké, mais son application (masquage réel à la consultation) reste bloquée par RG-SEC-01, même précédent que les capacités des Modules I/II/XXIII. Synchronisation distante différée pour ce module (même précédent documenté que les modules précédents) |
| IX — Déplacements | ⬜ à faire |
| X — Discipline | ⬜ à faire |
| XI — Finances | ⬜ à faire |
| XX — Biens (patrimoine) | ⬜ à faire |
| XXI — Comptabilité | ⬜ à faire |
| XIII — Médiathèque chrétienne | ⬜ à faire |
| XIV — Centre de formation en ligne | ⬜ à faire |
| XVI — Intelligence artificielle | ⬜ à faire |
| XVII — Communication | ⬜ à faire |
| XIX — École biblique | ⬜ à faire |
| XXIV — Bible numérique et vie de l'Église | ⬜ à faire |
| XV — Espace de soutien à GSG | ⬜ à faire |
| XVIII — Événements | ⬜ à faire |
| XXII — Tableau de bord | ⬜ à faire |
| Durcissement et déploiement (Phase 6) | ⬜ à faire |
| **Extension** CV Ecclésiastique (RG-CV-*, sans n° Cahier) | ⬜ à faire — après II et IX |
| **Extension** Cantiques (RG-CANT-*, sans n° Cahier) | ⬜ à faire — après XXIV Palier 1-2 |
| **Extension** Église Sœur (RG-ES-*, sans n° Cahier) | ⬜ à faire — après I et IX |
| i18n (socle ARB, sans `app_strings.dart`) | en continu, dès le premier module |
| Sécurité RG-SEC-05 (helpers `noeuds_du_perimetre()` etc.) | ✅ livré (voir Socle transversal ci-dessus) |

---

## 8. Phases de reconstruction (Annexe D du Cahier)

1. **Fondations** — socle transversal, Module I, Module II, Module XXIII, architecture
   offline-first (RG-OFF), sécurité de base (RG-SEC-01 à 07).
2. **Vie communautaire** — Modules III, IV, V, VI, VII, XII.
3. **Administration et finances** — Modules VIII, IX, X, XI, XX, XXI, intégration mobile money.
4. **Numérique et pédagogie** — Modules XIII, XIV, XVI, XVII, XIX, XXIV (Bible).
5. **Réseau et gouvernance** — Modules XV, XVIII, XXII.
6. **Durcissement et déploiement**.

Extensions hors Cahier (§2-6 de `RECONSTRUCTION_ecclesias360.md`) réappliquées dès que leurs
prérequis de phase existent — voir tableau §7.

---

## 9. Workflow attendu

1. Lire AGENTS.md, puis la section du Cahier concernée.
2. Présenter un plan d'architecture et obtenir validation avant de coder.
3. Implémenter domain → data → application → presentation.
4. `dart run build_runner build --delete-conflicting-outputs` si tables Drift modifiées.
5. `flutter analyze` → No issues found!
6. `flutter test` → tout au vert, un test par règle métier nouvelle.
7. Migration `supabase/migrations/000X_*.sql` si nouvelles données persistées (RLS activée, UUID, timestamps).
8. Commit en français, un commit par module/correction cohérente, **push immédiat vers `origin/main`**.

---

## 10. Sécurité

- `.env` exclu du dépôt, `.env.example` versionné.
- Jamais logger de clé/jeton/donnée sensible.
- Consentements RG-II-05, données sensibles RG-II-10 via `forbiddenFields`.
- Helpers `security definer` (`fidele_courant_id()`, `role_courant()`, `noeuds_du_perimetre()`) :
  `search_path` durci en `pg_catalog, pg_temp` dès l'écriture initiale (`public` exclu) — voir
  §3 de `RECONSTRUCTION_ecclesias360.md`.
- Toute `create policy` : écrite en entier même commentée (activation groupée au déploiement
  auth), jamais juste décrite en prose.

---

## 11. Intégration au GSG Platform Kernel — points ouverts

> Le Cahier §8.5 documente la relation d'Ecclésias360 au GSG Platform Kernel v3.0. Cette section
> trace les écarts entre cette cible et l'état du dépôt, et consigne les décisions déjà tranchées
> pour qu'un futur alignement Kernel ne les redéfasse pas.

1. **Référentiel `zones_geographiques` (Module XXIII) — TRANCHÉ, conserver tel quel.**
   Décision : le référentiel `zones_geographiques` (`libelle`, `niveau`, `parent_id`,
   `zone_geo_id` sur `organisation_nodes`) est **conservé**. Ce n'est pas un doublon du GSG
   Referential (pays/devise/langue/ville) : c'est une **zone pastorale interne** (zone,
   district, secteur...) au sens organisationnel du Module XXIII, distincte de l'adresse
   postale d'un nœud.
   Implications :
   - L'adresse d'un nœud, quand elle sera saisie, référencera `pays_id`, `unite_administrative_id`
     et `ville_id` du Kernel — jamais du texte libre, et jamais `zones_geographiques`.
   - `zones_geographiques` ne doit contenir ni pays, ni devise, ni langue, ni ville du Kernel.
   - Le Cahier §8.5 (« Instanciation du Referential Engine ») liste les référentiels internes
     portés en propre par le Module XXIII (dons spirituels, catégories de métiers, natures de
     faute) : les zones géographiques y ont été ajoutées à cette liste (voir Cahier) pour éviter
     toute contradiction lors d'un futur audit Kernel.

2. **Colonnes Kernel absentes du schéma — NON TRANCHÉ, à construire avec leur module porteur.**
   `gsg_org_id` (nœud racine, Org Registry), `langue_id` et `devise_id` (préférences/facturation,
   GSG Referential) ne figurent pas encore dans `organisation_nodes` ni ailleurs. Aucun module
   actuel n'en a besoin pour fonctionner ; à ajouter dès que le module qui les consomme réellement
   est construit (RG-XXIII-05 multilingue par nœud pour `langue_id` ; un futur module de
   facturation/abonnement, Cahier §10, pour `devise_id` et `gsg_org_id`) — ne pas les ajouter à
   vide avant d'avoir un consommateur réel, pour ne pas geler un schéma Kernel non encore stabilisé.

3. **Codes stables pour l'audit — NON TRANCHÉ.**
   `AppError.code` (voir `lib/core/error/app_error.dart`) fournit déjà des codes stables côté
   erreurs applicatives. Le bus d'événements et l'Audit du Kernel (§8.5 du Cahier : « non à ce
   stade ») ne sont pas construits — aucune action requise avant leur construction, mais toute
   future intégration doit transporter `AppError.code` ou équivalent, jamais un message traduit.
