# Dossier de reconstruction — Ecclésias360

> Produit suite à la perte totale du disque de développement (panne matérielle confirmée, 0 octet sur toutes les partitions détectées). Ce document capture tout ce qui est reconstituable depuis l'historique de conversation avec Claude, en attendant la récupération du Cahier de Conception v2.1 (existant ailleurs, à rapatrier en priorité).
>
> **Ce document ne remplace PAS le Cahier de Conception.** Il couvre : (1) l'AGENTS.md dans son dernier état connu, (2) la spécification complète de tout ce qui a été construit dans la session perdue (CV, i18n, Bible, Cantiques, Église Sœur). Aucune des décisions ci-dessous n'a besoin d'être redébattue — seulement ré-exécutée.

---

## 0. Statut au moment du sinistre

Dernier commit connu sur `main` : `b242d32` (Lot 2 Église Sœur — UI & Gestion).
Travail validé mais **pas encore committé au moment de la panne** : lot de code Bible multi-langues (KJV/RV1909/Almeida) + Cantiques catholiques (3 titres) + Sur les ailes de la foi (SAF-A, 4 titres) — le rapport de sourcing complet existe ci-dessous (section 5), rien n'avait été codé.
Restait également en attente : Palier 3 Bible (mentor/disciple), Paliers 4-6, favoris Cantiques, Lot 3 Église Sœur (Espace d'Échange + couture Module IX).

---

## 1. AGENTS.md — reconstitution

### 1a. Texte d'origine (avant toute modification de cette session)

Reproduit ci-dessous **texte pour texte**, tel que transmis en tout début de session — c'est la version qui existait avant toutes les modifications listées en 1b.

```markdown
# AGENTS.md — Feuille de route de développement

> Fichier de référence pour **tout agent de codage** (humain ou IA) travaillant sur Ecclésias360.
> À lire **en premier** avant toute tâche, et à **mettre à jour** à chaque module livré.
> Source de vérité métier : `Cahier_de_Conception_Ecclesias360_v2.1.md` (règles `RG-*`).

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
  core/
    config/app_config.dart
    constants/app_routes.dart
    constants/app_strings.dart   -- SUPPRIMÉ pendant la session (voir 1b, point i18n)
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

---

## 5. Conventions de code

- Nommage : PascalCase classes/widgets, camelCase méthodes/variables, snake_case fichiers.
- Chaînes UI : jamais en dur → système ARB / `l10n.*` (app_strings.dart supprimé, voir 1b).
- Routes : jamais en dur → `core/constants/app_routes.dart`.
- Valeurs IA : zéro valeur en dur → `assets/config/ai_roles.json`.
- Typage : éviter `dynamic`.
- Async : `context.mounted` après tout `await` avant usage de `context`.
- Thème : `core/theme/design_tokens.dart`, pas de hex en dur.
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

## 7. État d'avancement des modules (voir 1b pour l'état final avant sinistre)

## 8. Workflow attendu

1. Lire AGENTS.md, puis la section du Cahier concernée.
2. Présenter un plan d'architecture et obtenir validation avant de coder.
3. Implémenter domain → data → application → presentation.
4. `dart run build_runner build --delete-conflicting-outputs` si tables Drift modifiées.
5. `flutter analyze` → No issues found!
6. `flutter test` → tout au vert, un test par règle métier nouvelle.
7. Migration `supabase/migrations/000X_*.sql` si nouvelles données persistées (RLS activée, UUID, timestamps).
8. Commit en français, un commit par module/correction cohérente.

## 9. Sécurité

- `.env` exclu du dépôt, `.env.example` versionné.
- Jamais logger de clé/jeton/donnée sensible.
- Consentements RG-II-05, données sensibles RG-II-10 via `forbiddenFields`.
```

### 1b. Modifications apportées pendant la session (à réappliquer)

**§7 — refresh complet du tableau des modules** (commits `8f20d86`, `5eda7de`, puis ajouts successifs) :

| Module | Statut final connu |
|---|---|
| Phase 0 (socle) | ✅ livré |
| I — Organisation | ✅ livré |
| II — Fidèles | ✅ livré |
| III — Ministères | ✅ livré |
| IV — Dons spirituels | ✅ livré |
| V — Groupes professionnels | ✅ livré |
| VI — Groupes de l'Église | ✅ livré |
| VII — Comité local | ✅ livré |
| VIII — Archivage | ✅ livré |
| IX — Déplacements | ✅ livré |
| X — Discipline | ✅ livré |
| XI — Finances | ✅ livré |
| XII — Présences | ✅ livré |
| XIII — Événements (= Cahier XVIII) | ✅ livré |
| XIV — Patrimoine (= Cahier XX) | ✅ livré |
| XV — Médiathèque (= Cahier XIII) | ✅ livré |
| XVI — Formation & Discipulat (dépôt) — **collision assumée avec Cahier XVI = IA**, voir note ci-dessous | ✅ livré |
| IA (transversale, `core/ai/`, = Cahier XVI) | ⚠️ partiel |
| Habilitations / Sécurité (RG-SEC-05, `0018`/`0020`) | ⚠️ partiel — helpers écrits/testés, `create policy` inactifs jusqu'au déploiement auth groupé, écran d'admin des rôles à venir |
| i18n (socle) | ✅ livré — réserves documentées : chaînes `ai_assistant.dart` non migrées (~18, pas de `BuildContext`), format `_heure` non AM/PM pour en-US |
| Bible / accueil public | ✅ livré pour Paliers 1-2 (socle + multi-versions + plans de lecture pastoraux), ⚠️ Paliers 3-6 en attente |
| CV Ecclésiastique (Phase 2, sans n° Cahier, RG-CV-*) | ✅ livré (lots 1 → 2D) — fondé sur RG-II-07 |
| Cantiques (sans n° Cahier, RG-CANT-*) | ✅ livré pour le périmètre validé — lecture seule / domaine public (favoris hors périmètre, lot distinct non planifié) |
| Église Sœur (sans n° Cahier, RG-ES-*) | ⚠️ partiel — Lot 1 (Domaine & Data) + Lot 2 (UI & Gestion) livrés, Lot 3 (Espace d'Échange) en attente |

**Note de correspondance dépôt ↔ Cahier (bloc consolidé, §7)** :
- dépôt XIII → Cahier XVIII (Événements)
- dépôt XIV → Cahier XX (Patrimoine)
- dépôt XV → Cahier XIII (Médiathèque), enrichi live/streaming
- dépôt XVI = Formation & Discipulat = Cahier XIV (Centre de formation) + XIX (École biblique) + volet Discipulat propre, refs RG-XVI-*
- **Collision assumée du n° XVI (pas une coquille)** : Cahier XVI = IA, mais le n° XVI du dépôt est pris par Formation (module applicatif fini) ; l'IA est une couche transversale sans n° séquentiel dans le dépôt.
- Bible = amorce du Cahier XXIV
- Habilitations et CV : sans numéro Cahier (transversal RG-II-10/RG-SEC-05 ; Phase 2 RG-II-07)
- Cantiques, Église Sœur : sans numéro Cahier (même précédent que CV)

**§5 — suppression de `app_strings.dart`** : la ligne « Chaînes UI : jamais en dur → `core/constants/app_strings.dart` » doit être remplacée par « Chaînes UI : jamais en dur → système ARB / `l10n.*`, aucun fichier de constantes intermédiaire ». Le fichier `app_strings.dart` a été supprimé (66 constantes migrées vers ~45 clés ARB neuves + réutilisation des clés `action*` existantes, 286 sites d'appel migrés, 82 fichiers).

---

## 2. Reconstruction technique — CV Ecclésiastique (Phase 2, RG-CV-*)

- `CvController` : streams `passeport`/`emissions`, `peutConsulter` (propre CV, capacité pastorale, tuteur légal via `Tuteurs`), `emettre`/`verifier`/`revoquer`.
- `roles.json` : capacités `consulter_mon_cv` (membre), `consulter_cv_tiers` + `emettre_cv` (pasteur), `revoquer_cv` (administrateur).
- Écrans : `CvPasseportScreen` (`/cv`, `/cv/fidele/:id`), `CvVerificationScreen` (`/cv/verifier` — code `CV-XXXX-XXXX-XXXX`, contrôle déterministe hors ligne).
- `CvPasseportCard` : visuel ~A4, `QrImageView`, capture `RepaintBoundary`, partage image (`toImage(pixelRatio: 2)` → `SharePlus`, repli texte).
- Intégration Module IX : `DeplacementRepository` reçoit `CvRepository?` optionnel, `validerCote(annexerCvAuTitulaire:)` émet un CV (`emisPar: 'deplacements'`) après archivage de la lettre, échec non bloquant.
- Sync distante : table `emissions_cv`, `enable row level security` **sans policy active** (cohérent avec le reste du projet — activation groupée au déploiement auth), `SupabaseCvDataSource` (upsert PostgREST, no-op hors connexion), handler Outbox `emission_cv_upsert` sur `emettreCv`/`revoquerCv`.
- 45 clés ARB `cv*` (fr/en/es/pt).

---

## 3. Reconstruction technique — Sécurité / RG-SEC-05 (`0018`, `0020`)

**Contexte structurant à ne jamais reperdre** : une seule racine `organisation_nodes` pour tout le déploiement (l'app impose `hasRoot()` unique, lève `AppError.rootAlreadyExists` sinon). Chemin matérialisé `path` (`/id/id/id/`), `depth`. **Aucune** table `Eglises` séparée n'existe — une « Église » est un nœud `type_id = 'eglise_locale'` dans cet arbre unique.

Helpers `security definer` (avec `search_path` durci en `pg_catalog, pg_temp` — `public` exclu de la résolution) :
- `fidele_courant_id()` / `role_courant()` — promus de 0018.
- `noeuds_du_perimetre()` : `setof uuid` = nœuds où le fidèle courant a un mandat actif (`node_responsables`, `date_fin` nulle ou future) + tous les descendants (`n.path like racine.path || '%'`).

**Toutes les `create policy` du projet restent commentées** — activation groupée prévue avec le déploiement de l'auth, jamais isolée table par table. Spécification `PerimetreRules` (Dart pur, `features/organization/domain/rules/`) sert de source de vérité testable en l'absence d'infra pgTAP :
- `noeudsDuPerimetre(...)` : nœud+descendants, racine incluse, parent/pair exclus, mandat expiré exclu.
- `inscriptionVisible(...)` : prédicat de `inscriptions_lecture_self` (corrigé pour border via `noeuds_du_perimetre()` — 0018 promettait ce périmètre sans l'implémenter).
- `rencontres_discipulat_confidentiel` : confidentialité relationnelle RG-XVI-15 (mentor/pasteur nommé), PAS un cloisonnement organisationnel — `pasteur_referent` volontairement non borné au nœud.

---

## 4. Reconstruction technique — Module Bible (Cahier XXIV, RG-XXIV-*)

### Palier 1 — Socle
- Corpus **LSG 1910** (GetBible v2, domaine public) → `assets/bible/lsg1910.db.gz`, `BibleDatabase` (2ᵉ base Drift lecture seule, FTS5 accent-insensible), décompression au 1ᵉʳ lancement (marqueur SharedPreferences `bible_corpus_version` + taille d'octets asset — re-décompression si l'un ou l'autre change, mécanisme volontaire pour absorber un ré-export du corpus).
- `domain/rules` purs : `BibleReferenceRules`, `VersetDuJourRules` (précédence manuel > plan > rotation), `RechercheBibliqueRules`.
- bookId **1..66 = protocanon**, jamais l'ordre d'affichage d'une version (compat. ascendante des références/favoris).

### Palier 2 — Plans de lecture pastoraux
- Tables `plans_lecture` / `passages_plan_lecture` / `inscriptions_plan_lecture` / `progression_jour_plan`.
- `PlanLectureRules` : `expanserSpec`, `fusionStatutJour`, `progressionAgregee`, `enRetard`, `estComplet`.
- Capacité `creer_plan_lecture` sur `responsable` (héritée pasteur+) — **pas** de nouveau rôle, **pas** de réutilisation d'`editer_parcours` (élargirait trop).
- Rattachement optionnel cycle : discriminant `cycleType ∈ {serie_predication, evenement}` + `cycleId` nullable (pas de FK dure vers une seule entité — `PlaylistsSeries` Module XV et `Evenements` Module XIII coexistent).

### Multi-versions (Volet 1)
- **Darby (1885)** et **Crampon (1923, PAS 1904 — seule édition existant en dataset structuré)** ajoutés à la LSG 1910. `RG-XXIV-01` du Cahier amendé pour remplacer KJV par Crampon (écart francophone/catholique assumé et documenté).
- bookId **67..73 = deutérocanoniques** (Tobie, Judith, 1&2 Maccabées, Sagesse, Siracide, Baruch) — n'écrasent jamais 1..66.
- **Option B retenue** : un asset par version (`lsg1910.db.gz`, `darby.db.gz`, `crampon.db.gz`), ouverts à la demande — pas un asset unique avec colonne `translation`.
- **Versions secondaires (Darby/Crampon) téléchargées à la demande, PAS embarquées dans le binaire** (contrainte ajoutée après coup pour la taille de l'app) — service générique de téléchargement d'assets distants (Supabase Storage, checksum, progression, retry), **mutualisé avec le Palier 6 (audio)**.
- Sélecteur de version dans `bible_reader`, LSG 1910 par défaut, préférence `SharedPreferences 'bible_translation'`.

### Bible multi-langues (décidé, sourcing fait, code jamais écrit avant sinistre)
- **KJV** (anglais) — source `scrollmapper`, domaine public.
- **Reina-Valera 1909** (espagnol) — source `SpaRV` (**pas** `SpaRVG`, qui est sous CC BY-NC-ND).
- **Almeida (portugais)** — repli sur **Bíblia Livre** (CC-BY 3.0 BR, généalogie JFA 1819/1911) ; l'ARC moderne est confirmée sous droits actifs (preuve : retrait du module CrossWire `PorAr` pour infraction) — ne jamais utiliser l'ARC.
- Mapping automatique version par défaut ↔ locale app : `fr`→LSG 1910, `en`→KJV, `es`→RV1909, `pt`→Bíblia Livre. Préférence manuelle prioritaire une fois exercée.

### Navigation (bugs signalés, jamais codés avant sinistre)
1. Bouton retour explicite pour sortir de `bible_reader`.
2. Nom du livre dans l'AppBar cliquable → liste des chapitres du livre courant.
3. Tiroir latéral gauche (affichable/masquable) listant les chapitres du livre courant.

---

## 5. Reconstruction technique — Module Cantiques (RG-CANT-*)

Extension non numérotée au Cahier (précédent CV). `CantiquesDatabase` (2ᵉ base Drift lecture seule, pattern `BibleDatabase`).

Schéma : `recueils(id, titre, auteur, annee_edition, source_texte, source_scan, notes)`, `cantiques(id, recueil_id, numero, titre, partie, theme, reference_biblique, reference_brute, reference_source, is_public_domain, texte, strophes)`, `cantiques_fts` (FTS5).

`reference_source ∈ {imprimee, inferee, null}` — distinction ajoutée après coup pour ne jamais présenter une référence déduite par l'équipe avec la même autorité qu'une note originale de l'auteur. UI : badge « Référence suggérée » sur `inferee`.

`is_public_domain` gate le comportement dès la V1 : `peutPartager`/`peutExporter` = `isPublicDomain`, bandeau droits si `false` (aucune entrée `false` réelle dans le corpus, comportement testé avec une entrée fictive).

### Recueil 1 — César Malan, « Chants de Sion » (5ᵉ éd. 1843, mort 1864 → PD)
Source OCR : Internet Archive `chantsdesionour00malagoog` (en réalité la 2ᵉ éd. 1855, ~280 cantiques — pas l'édition à 100 initialement crue). **31 cantiques vérifiés individuellement au fac-similé** (pas d'import brut du corpus complet, QC bloquante sur résidus OCR, `cantiques_corrections.json` = transcriptions complètes) :

| Partie | Numéros |
|---|---|
| I — Objet de la foi (15) | 1,2,3,4,6,7,8,9,10,11,12,13,14,17,18 |
| II — Profession de la foi (5) | 47,48,53,55,57 |
| III — Travaux de la foi (5) | 81,83,84,85,86 |
| IV — Privilèges de la foi (2) | 129,135 |
| V — Gloire de la foi (4) | 176,177,179,288 |

`reference_source` : imprimée (19), inférée (10 : {6,11,12,13,14,18,81,84,86,129}), nulle (2 : n°9, n°57).

### Recueil 2 — Répertoire catholique (nouveau, RG-CANT-*, sourcing fait, code jamais écrit)
**3 titres validés individuellement**, champ `confession = catholique`, sourcés sur numérisations d'origine (jamais sur une compilation commerciale actuelle type Le Barroux ou IBN 2015) :

| Titre | Auteur (texte) | Compositeur | Source scan |
|---|---|---|---|
| Minuit, chrétiens | Placide Cappeau (1808–1877) | Adolphe Adam (1803–1856) | Gallica, partition d'époque (bpt6k13112821) |
| Nous voulons Dieu | Abbé F.-X. Moreau (1827–1905) | — (même auteur) | Gallica, 4ᵉ éd. 1882 (bpt6k8586591) |
| Ave Maria de Lourdes / Ô Vierge Marie | Jean Gaignet (1839–1914) | Louis Lambillotte (1796–1855), mélodie 1842 réemployée | Gallica, éd. 1875 (bpt6k6137755t) |

Exclus (traçabilité, ne pas réintroduire sans nouvelle preuve) : « Chez nous soyez Reine » (auteur non identifiable), « Credo royal » (Henry Du Mont, PD mais pièce liturgique continue, hors modèle strophique — périmètre futur distinct).

### Recueil 3 — « Sur les ailes de la foi », **édition 1928 spécifiquement** (Gallica), jamais l'édition 2015/IBN sous droits actifs
`confession = protestant`. **SAF-A = 4 titres confirmés uniquement** (le reste bloqué par l'anti-robot Gallica ALTCHA, pas un manque de candidats) :

| Titre | Original | Traducteur/adaptateur |
|---|---|---|
| Plus près de toi, mon Dieu | Sarah Flower Adams (1805–1848) / Lowell Mason (1792–1872) | Ruben Saillens (1855–1942) |
| Debout, sainte cohorte | George Duffield Jr. (1818–1888) / George J. Webb (1803–1887) | Ruben Saillens |
| Voyez, voyez, les voici | Jacob Wakefield MacGill (1829–1902) | Saillens, adaptation libre |
| La Cévenole | paroles Saillens | musique L. Roucaute (1885) — **compositeur sans date de décès confirmée, à re-vérifier avant inclusion définitive** |

3 titres à forte présomption mais présence dans l'édition 1928 non confirmée (À toi la gloire — Budry/Haendel ; C'est un rempart — Lutteroth/Luther ; Quel ami fidèle et tendre — Bonnard/Scriven) : **ne pas inclure tant que la table des matières 1928 n'est pas confirmée** (nécessite un scan manuel de l'édition, le blocage anti-robot empêchant l'accès automatisé).

---

## 6. Reconstruction technique — Église Sœur (RG-ES-*)

**Prémisse validée après audit** : pas de tenant multi-base — une « Église Sœur » relie deux nœuds `eglise_locale` du **même** arbre `organisation_nodes` (même instance GSG). `eglise_amie` (inter-dénominationnelle, cross-instance) est **hors périmètre**, chantier de fédération non engagé — aucune valeur dans le schéma actif.

### Schéma (DDL — reproduit tel quel, déjà écrit et vérifié par PGlite avant le sinistre)

```sql
create table if not exists public.partenariats_eglises (
  id uuid primary key,
  type_partenariat text not null default 'eglise_soeur'
    check (type_partenariat in ('eglise_soeur')),
  eglise_a_node_id uuid not null references public.organisation_nodes(id) on delete cascade,
  eglise_b_node_id uuid not null references public.organisation_nodes(id) on delete cascade,
  statut text not null default 'demandee'
    check (statut in ('demandee', 'active', 'refusee', 'suspendue', 'terminee')),
  motif_statut text,
  initie_par_fidele_id uuid references public.fideles(id) on delete set null,
  valide_par_fidele_id uuid references public.fideles(id) on delete set null,
  date_demande     timestamptz not null default now(),
  date_decision    timestamptz,
  date_fin         timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  check (eglise_a_node_id <> eglise_b_node_id)
);

create unique index if not exists uq_partenariats_eglises_paire_active
  on public.partenariats_eglises (
    least(eglise_a_node_id, eglise_b_node_id),
    greatest(eglise_a_node_id, eglise_b_node_id),
    type_partenariat
  )
  where statut in ('demandee', 'active', 'suspendue');

create table if not exists public.echanges_partenaires (
  id uuid primary key,
  partenariat_id uuid not null references public.partenariats_eglises(id) on delete cascade,
  emis_par_node_id uuid not null references public.organisation_nodes(id) on delete cascade,
  emis_par_fidele_id uuid references public.fideles(id) on delete set null,
  type_contenu text not null
    check (type_contenu in (
      'annonce', 'invitation', 'partage_predication',
      'demande_priere', 'temoignage', 'recommandation_fidele'
    )),
  titre text not null,
  corps text not null,
  reference_uri text,
  date_evenement timestamptz,
  statut_moderation text not null default 'en_attente'
    check (statut_moderation in ('en_attente', 'approuve', 'rejete')),
  modere_par_fidele_id uuid references public.fideles(id) on delete set null,
  date_moderation timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
```

### Transitions de statut (RG-ES-02)

| De | Vers | Qui | Champ requis |
|---|---|---|---|
| (création) | demandee | côté A | `initie_par_fidele_id` |
| demandee | active | côté B | `valide_par_fidele_id`, `date_decision` |
| demandee | refusee | côté B | `motif_statut`, `date_decision` |
| demandee | terminee | côté A (retrait) | `motif_statut`, `date_fin` |
| active | suspendue | A ou B | `motif_statut` |
| **suspendue → active** | **autorisé** (réactivation) | A ou B | `motif_statut` (motif de reprise) |
| active | terminee | A ou B | `motif_statut`, `date_fin` |
| suspendue | terminee | A ou B | `motif_statut`, `date_fin` |
| refusee, terminee | — | — | terminal, **re-demande possible** (unicité partielle, pas absolue) |

Garde `eglise_locale` (les deux nœuds doivent être de ce type) : **applicative** (`PartenariatRules` + repository), **pas de trigger** — cohérent avec zéro trigger ailleurs dans le dépôt.

### RG-ES-03/04 — prédicat RLS (premier accès cross-périmètre délibéré du projet)

```sql
-- echanges_partenaires_lecture
-- using (
--   exists (
--     select 1 from public.partenariats_eglises p
--     where p.id = public.echanges_partenaires.partenariat_id
--       and p.statut = 'active'
--       and (
--         p.eglise_a_node_id in (select public.noeuds_du_perimetre())
--         or p.eglise_b_node_id in (select public.noeuds_du_perimetre())
--       )
--   )
--   or public.echanges_partenaires.emis_par_node_id in (select public.noeuds_du_perimetre())
-- );
```

**RG-ES-04 — écart assumé** : l'administrateur est **borné** par ce prédicat comme tout autre rôle (contrairement à partout ailleurs dans le dépôt où `role_courant() = 'administrateur'` est non borné). Raison documentée : un échange inter-églises est la donnée partagée de deux organisations, le consentement à la voir est le partenariat actif, pas le rang hiérarchique.

### Repository — garde de provenance (au-delà du plan initial, ajoutée en durcissement)
- `changerStatut`/`emettreEchange`/`modererEchange` reçoivent `perimetre` et vérifient que le `parCote` revendiqué est **réellement couvert** par ce périmètre (rejet sinon, `AppError.partenariatSideOutsidePerimetre`) — intégrité de provenance, distincte de la capacité.
- `modererEchange` : côté récepteur **dérivé de la donnée** (pas revendiqué) — un émetteur ne peut pas modérer son propre envoi.
- `echangesVisibles({partenariatId, perimetre})` remplace toute API de lecture non filtrée — miroir exact du prédicat RLS.
- Capacité `gerer_partenariats` reste au **contrôleur** (Lot 2), pas au repository — convention du dépôt (comme `formation`/`plan_lecture`/`cv`).

### roles.json
- Nouvelle capacité `gerer_partenariats` sur `responsable` (héritée pasteur+). Aucun rôle nouveau (`responsable_eglise`/`pasteur_principal` de la proposition initiale abandonnés).

### RG-ES-10 — impact Module IX (documenté, jamais câblé)
La lettre de recommandation n'est **jamais transmise automatiquement** à une Église sœur. Transmission opt-in, non bloquante (pattern `annexerCvAuTitulaire`), via un `echanges_partenaires` de `type_contenu = 'recommandation_fidele'` (payload borné : texte rendu + code de vérification CV, pas de FK vers `documents_archive`). Soumise aux consentements RG-II-05 et au régime RG-II-10, journalisée (Uriel).

### Découpage en lots
- Lot 1 — Domaine & Data : **livré** (`d7044ca`, complété tests repository `ef4facf`).
- Lot 2 — UI & Gestion : **livré** (`b242d32`).
- Lot 3 — Espace d'Échange (écrans émission/modération) + couture Module IX : **jamais commencé**.

---

## 7. Bugs corrigés pendant la session (à revérifier une fois le code reconstruit)

1. `0022_plans_lecture.sql` référençait `organization_nodes` (anglais) au lieu de `organisation_nodes` (français, la vraie table depuis `0001`) — FK cassée, migration échouait à l'exécution. Corrigé, vérifié par exécution PGlite réelle (pas seulement compilation).
2. `0010` : `dossiers_disciplinaires` référençait `commissions_disciplinaires` créée après elle dans le même fichier — ordre de création cassé. Corrigé.

**Ces deux bugs préexistaient à la session et ont été trouvés par audit — à revérifier explicitement dans la reconstruction, ils pourraient être réintroduits si le code est régénéré sans cette mémoire.**

---

## 8. Méthodologie à ne pas perdre en reconstruisant

- Toute migration touchant les nœuds/périmètre : vérifier par **exécution réelle** (PGlite ou équivalent), pas seulement compilation syntaxique.
- Toute source de contenu (Bible, Cantiques) : vérifier la licence de l'**édition exacte**, jamais supposer qu'un nom d'auteur ancien suffit (cf. Crampon 1904 vs 1923, ARC vs JFA, édition 2015 vs 1928 de « Sur les ailes de la foi »).
- Toute nouvelle capacité/permission : vérifier si une capacité existante peut être réutilisée avant d'en créer une nouvelle (mais jamais réutiliser une capacité dont le périmètre réel diffère — cf. `editer_parcours` rejeté pour les plans de lecture).
- Tout compte de tests communiqué : chiffre unique et vérifié en isolation, jamais une formulation combinée ambiguë (« X + Y nouveaux »).
- `create policy` : toujours écrites en entier même commentées, jamais juste décrites en prose — elles doivent être relisables et activables telles quelles au moment du déploiement auth groupé.
