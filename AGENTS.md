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

## 7. État d'avancement des modules

> Repli à zéro (2026-09) : ce tableau reflète l'état réel du dépôt reconstruit, pas l'état
> atteint avant le sinistre. Ordre canonique = Annexe D du Cahier (voir §8 « Phases » ci-dessous).
> Pour les modules/extensions déjà spécifiés en détail dans `RECONSTRUCTION_ecclesias360.md`
> (CV, Bible multi-versions, Cantiques, Église Sœur, sécurité RG-SEC-05), la spécification est
> **déjà tranchée** — seule l'implémentation reste à faire, dès que les prérequis existent.

| Module (n° Cahier) | Statut |
|---|---|
| Socle transversal (Phase 1) | ⚠️ partiel — `AppDatabase` (Drift), `IdGenerator`, `SyncCoordinator` (outbox RG-OFF-02) livrés |
| I — Organisation | ⚠️ partiel — Lot 1 (Domaine & Données) livré : `organisation_nodes`/`historique_rattachements`, RG-I-01/02/06/08/09, migration `0001` vérifiée par exécution réelle (PGlite). Lot 2 (Contrôleur & écrans) à venir |
| II — Fidèles | ⬜ à faire |
| XXIII — Paramètres de l'application | ⬜ à faire |
| III — Ministères et départements | ⬜ à faire |
| IV — Dons spirituels | ⬜ à faire |
| V — Groupes professionnels | ⬜ à faire |
| VI — Groupes de l'Église | ⬜ à faire |
| VII — Comité local | ⬜ à faire |
| XII — Cultes | ⬜ à faire |
| VIII — Archivage documentaire | ⬜ à faire |
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
| Sécurité RG-SEC-05 (helpers `noeuds_du_perimetre()` etc.) | ⬜ à faire — dès Phase 1 |

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
