# Rapport RLS table par table — migration 0019 (activation groupée)

Rapport de revue exigé avant fusion de `0019_activation_policies_rls.sql`
(RG-SEC-01/04/05/06/06bis). État relevé dans `pg_policies` après application
de la chaîne complète 0001 → 0019 sur la stack locale (`supabase db reset`) :
**67 tables, toutes avec RLS activée et au moins une policy, 168 policies,
toutes restreintes au rôle `authenticated`, aucune inconditionnelle
(`true`)**. Ces trois invariants sont vérifiés à chaque exécution par la
section 0 de `0019_activation_policies_rls_test.sql`.

## Gabarits de bornage

| Code | Bornage | Prédicat |
|---|---|---|
| **P** | Périmètre hiérarchique (RG-SEC-05) | `dans_perimetre(noeud)` : nœud d'un mandat actif (`node_responsables`) ou descendant |
| **O** | Propriétaire | ligne du fidèle courant (`fidele_courant_id()`) |
| **C** | Confidentialité relationnelle | appartenance nommée : commission disciplinaire, comité, trésorier, responsable de ministère en fonction — indépendante du périmètre |
| **R** | Rôle | seuil de rang `a_role_minimal(...)` ; jamais seul pour une donnée rattachée à un nœud |
| **G** | Référentiel global | lecture : fidèle enregistré (rang ≥ membre) ; écriture : administrateur |
| **A** | Administrateur | `est_administrateur()` : **non borné** (gabarit générique) |

**Vérification demandée — branche administrateur non bornée.** `dans_perimetre()`
renvoie vrai pour l'administrateur quel que soit le nœud : c'est le gabarit
générique voulu (Annexe B : « Administrateur Global Service Groupe — accès
complet, consolidation internationale » ; l'administrateur d'amorçage n'a ni
fiche ni mandat, il serait sinon aveugle). **Aucune exception nommée n'existe
encore dans le dépôt** : la seule tranchée différemment, Église Sœur
(RG-ES-04, administrateur *borné* par le partenariat actif), porte sur des
tables (`partenariats_eglises`, `echanges_partenaires`) qui ne sont pas encore
reconstruites. À sa reconstruction, sa policy ne doit **pas** appeler
`dans_perimetre()` (qui ferait hériter la branche administrateur) mais
`noeuds_du_perimetre()` directement, comme dans le prédicat déjà spécifié au
§6 de `RECONSTRUCTION_ecclesias360.md`.

**Utilisateur simple (RG-SEC-06bis).** Sans fiche : ni périmètre, ni
propriété, ni rang ≥ membre. Il ne lit que les contenus publiés de la
médiathèque, leurs commentaires publiés et son propre compte ; il n'écrit
rien. Vérifié (section 2 du test). `anon` ne lit rien (section 1).

## Tables

Légende des colonnes : L lecture, É écriture (insert/update), S suppression
(« — » : aucune policy, donc refusée).

### Socle et Module I — Organisation

| Table | L | É | S | Verdict |
|---|---|---|---|---|
| `organisation_nodes` | P · son église (O) · rang ≥ responsable (annuaire, capacité `consulter_annuaire_eglises`) | racine : A ; enfant : P sur le parent ; déplacement : P sur l'ancien et le nouveau parent | A | ✅ — `creer_noeud_niveau_superieur` reste applicative (le « niveau supérieur » n'est pas exprimable en SQL sans table des rangs de types de nœud) |
| `historique_rattachements` | P | P (ajout seul) | — | ✅ |
| `node_responsables` | P · O | P ∧ R ≥ pasteur | — (mandat clos par `date_fin`) | ✅ — un responsable ne se désigne pas, un membre ne se donne pas de mandat (testé) |
| `comptes_utilisateurs` | O · A | — (fonctions 0018 seulement) | — | ✅ |
| `journal_liaisons_comptes` | A | — (fonctions 0018 seulement) | — | ✅ |

### Module II — Fidèles

| Table | L | É | S | Verdict |
|---|---|---|---|---|
| `fideles` | O · P | P ; colonnes `role`, `auth_user_id` jamais modifiables par un client (privilèges de colonne, 0018) | P ∧ R ≥ pasteur | ✅ — élévation de rôle refusée même dans son périmètre (testé) |
| `liens_familiaux` | O · P (sur `fidele_id1`) | P | P | ✅ |
| `historique_fideles` | O · P | P (ajout seul) | — | ✅ |
| `tuteurs` | O · P (sur le mineur) | P | P | ✅ |

### Module III — Ministères

| Table | L | É | S | Verdict |
|---|---|---|---|---|
| `ministeres` | P · son église · C (responsable en fonction) | P | — | ✅ |
| `affectations_ministeres` | P · C · O | P · C | — (suspension/fin par mise à jour) | ✅ |
| `mandats_responsables` | P · O | P — jamais le responsable lui-même | — (historique RG-III-05) | ✅ |
| `activites_ministeres` | P · C | P · C (ajout seul, RG-III-05) | — | ✅ |
| `types_ministeres` | G | A | A | ✅ |

### Module IV — Dons spirituels

| Table | L | É | S | Verdict |
|---|---|---|---|---|
| `dons_fideles` | O · P · C (responsable d'un ministère du fidèle, Annexe B) | P (ajout seul, RG-IV-01/02) | — | ✅ |
| `dons_spirituels`, `dons_ministeres_compatibles` | G | A | A | ✅ |

### Module V — Groupes professionnels

| Table | L | É | S | Verdict |
|---|---|---|---|---|
| `professions_fideles` | O · P | création : P, ou O au statut `declare` seulement ; vérification : P | — | ✅ — le fidèle ne peut pas s'auto-vérifier (RG-V-01) |
| `sollicitations` | O · P | création : P ; réponse : O · P | — | ✅ |
| `professions` | G | A | A | ✅ |

### Module VI — Groupes de l'Église

| Table | L | É | S | Verdict |
|---|---|---|---|---|
| `appartenances_groupe` | O · P | P | P | ✅ |
| `groupes_eglise` | G | A | A | ✅ — groupes globaux, sans nœud |

### Module VII — Comité local

| Table | L | É | S | Verdict |
|---|---|---|---|---|
| `membres_comite` | P · C | P ∧ R ≥ pasteur | — | ✅ |
| `quorums_comite` | P · C | P ∧ R ≥ pasteur | — | ✅ |
| `seances_comite`, `presents_seance`, `decisions` | P · C | P · C | — | ✅ |
| `proces_verbaux` | P · C | création : P · C ; modification : **seulement au statut `brouillon`** | — | ✅ — RG-VII-02, un PV validé est immuable |
| `erratums_pv` | P · C | P · C (ajout seul) | — | ✅ |
| `taches_suivi` | P · C · O (assigné) | création : P · C ; modification : P · C · assigné | — | ✅ |

### Module VIII — Archivage

| Table | L | É | S | Verdict |
|---|---|---|---|---|
| `documents_archive` | P ; niveau `restreint` : P ∧ R ≥ pasteur, ou commission du dossier dont il est une pièce | création : P · comité du nœud (PV, RG-VII-03) · commission du nœud (pièces, RG-X-06) | P ∧ R ≥ pasteur (purge RG-VIII-05) | ✅ — RG-VIII-03 désormais réellement appliqué côté serveur (testé : responsable ne lit pas le restreint, pasteur de la branche paire non plus) |
| `versions_document` | comme le document | si le document est visible | P ∧ R ≥ pasteur | ✅ |
| `nomenclatures_archivage` | G | A | A | ✅ — la séquence est calculée, aucune colonne de compteur à ouvrir |

### Module IX — Déplacements

| Table | L | É | S | Verdict |
|---|---|---|---|---|
| `mutations` | P origine · P destination · O | P origine · P destination | — | ✅ |
| `lettres_recommandation` | si la mutation est visible | P origine · P destination | — | ✅ |

### Module X — Discipline (RG-SEC-06)

| Table | L | É | S | Verdict |
|---|---|---|---|---|
| `dossiers_disciplinaires` | (P ∧ R ≥ pasteur) · C (commission assignée) — **jamais le fidèle concerné** | ouverture : (P ∧ R ≥ pasteur) · C (commission du nœud, RG-X-01) ; instruction : (P ∧ R ≥ pasteur) · C | — | ✅ — testé : membre ne lit pas son propre dossier, pasteur de la branche paire ne lit pas, commission ne peut ouvrir hors de son nœud |
| `pieces_dossier` | si le dossier est accessible | si le dossier est accessible (ajout seul) | — | ✅ |
| `commissions_disciplinaires` | (P ∧ R ≥ pasteur) · C | P ∧ R ≥ pasteur | — | ✅ |
| `membres_commission_disciplinaire` | (P ∧ R ≥ pasteur) · C | P ∧ R ≥ pasteur | P ∧ R ≥ pasteur | ✅ |
| `natures_faute` | G | A | A | ✅ |

### Module XI — Finances (RG-SEC-06)

| Table | L | É | S | Verdict |
|---|---|---|---|---|
| `contributions` | (P ∧ R ≥ pasteur) · C (trésorier du nœud) · O (donateur) | saisie : O, P ou trésorier, **toujours `en_attente`** ; contre-passation validée : P ∧ R ≥ pasteur ou trésorier ; validation/rejet : P ∧ R ≥ pasteur ou trésorier, **seulement depuis `en_attente`** | — | ✅ — RG-XI-02/05 testés : auto-validation refusée, validée immuable, trésorier d'E2 sans effet sur E1 |
| `tresoriers_noeud` | P · O | P ∧ R ≥ pasteur | — | ✅ |
| `projets` | P · trésorier | P · trésorier | — | ✅ |
| `depenses_projet` | P · trésorier | P · trésorier (ajout seul) | — | ✅ |
| `engagements` | O · (P ∧ R ≥ pasteur) · trésorier | idem | — | ✅ |
| `echeances_engagement` | si l'engagement est visible | idem | — | ✅ |
| `types_offrande` | G | A | A | ✅ |

### Module XII — Cultes

| Table | L | É | S | Verdict |
|---|---|---|---|---|
| `cultes`, `publications_culte` | P · son église | P | — | ✅ |
| `sequences_liturgiques` | P · son église | P | P | ✅ |
| `presences_culte` | P · O | P | P | ✅ |
| `propositions_theme` | R ≥ membre | création : R ≥ membre, en son nom ; statut : R ≥ pasteur | — | ✅ |
| `votes_proposition` | R ≥ membre | R ≥ membre, en son nom (ajout seul, RG-XII-06) | — | ✅ |

### Module XIII — Médiathèque

| Table | L | É | S | Verdict |
|---|---|---|---|---|
| `contenus_mediatheque` | publiés : tout compte (y compris utilisateur simple) ; brouillons : P du nœud éditeur | P du nœud éditeur | — | ✅ |
| `commentaires` | publiés sur contenu publié · O · modérateur | création : R ≥ membre, en son nom, sur contenu publié, **statut initial imposé par le contenu** (a priori → `en_attente`) ; modération : R ≥ pasteur ou P du nœud éditeur | — | ✅ — contournement de la modération a priori refusé (testé) |
| `favoris` | O | O ∧ R ≥ membre | O | ✅ |

### Module XX — Biens

| Table | L | É | S | Verdict |
|---|---|---|---|---|
| `biens`, `campagnes_inventaire`, `reservations_bien` | P | P | — | ✅ — la sortie reste une mise à jour tracée (RG-XX-02), jamais une suppression |
| `mouvements_stock`, `pointages_inventaire` | P | P (ajout seul) | — | ✅ |
| `categories_bien` | G | A | A | ✅ |

### Module XXI — Comptabilité (RG-SEC-06)

| Table | L | É | S | Verdict |
|---|---|---|---|---|
| `ecritures_comptables` | (P ∧ R ≥ pasteur) · trésorier | création : idem, **jamais dans une période `cloturee`** ; modification : seule la colonne `rapproche` (privilège de colonne) | — | ✅ — RG-XXI-03/05 testés |
| `budgets` | (P ∧ R ≥ pasteur) · trésorier | idem | — | ✅ |
| `periodes_comptables` | R ≥ membre | R ≥ pasteur | — | ✅ — plus aucune suppression d'exercice (testé) |
| `comptes_comptables` | G | A | A | ✅ |

### Module XXIII — Paramètres

| Table | L | É | S | Verdict |
|---|---|---|---|---|
| `zones_geographiques` | G | A | A | ✅ |

## Corrections apportées pendant la revue (avant ce rapport)

1. **`for all` accordait aussi la suppression** sur 20 policies de tables que
   l'application ne supprime jamais (biens, mandats, exercices comptables,
   trésoriers, commissions…) : un bien supprimable contournait la sortie
   tracée RG-XX-02, un mandat supprimé effaçait l'historique RG-III-05.
   Scindées en lecture / création / modification ; `for all` n'est conservé
   que sur les 7 tables où l'application supprime réellement
   (`appartenances_groupe`, `sequences_liturgiques`, `presences_culte`,
   `membres_commission_disciplinaire`, `favoris`, `liens_familiaux`,
   `tuteurs`) et sur les référentiels écrits par l'administrateur.
2. **Contribution validée encore modifiable** par un pasteur ou un trésorier
   (montant compris), contraire à RG-XI-05 : la modification n'est plus
   possible que depuis `en_attente`.
3. **Écriture comptable modifiable sur toutes ses colonnes et possible en
   période clôturée** (RG-XXI-03) : privilège de colonne limité à
   `rapproche`, et insertion refusée dans une période `cloturee`.

## Limites connues (acceptées, sans risque d'élévation)

- **Chemins serveur à router par fonction `security definer` au branchement
  de la synchronisation du Module XIII** : l'incrément de
  `compteur_consultations` (RG-XIII-05) et le signalement d'un commentaire
  (`nombre_signalements`, masquage automatique) sont faits par tout lecteur ;
  la RLS les refuse aujourd'hui (refus sûr, pas de fuite). Sans effet tant que
  la synchronisation de ce module n'est pas active.
- **Ouverture d'un dossier par un membre de commission sans mandat** :
  l'insertion du dossier est autorisée (RG-X-01) mais la bascule du statut
  spirituel de la fiche (`fideles`, module II) exige le périmètre. À router par
  une fonction `security definer` au branchement de la synchronisation des
  Modules II/X (même précédent que `enregistrer_compte_courant`).
- **Modification des rôles (`fideles.role`)** : aucun client ne peut l'écrire,
  administrateur compris (privilège de colonne 0018). L'écran d'administration
  des rôles (Module XXIII, écran Windows 4) devra passer par une fonction
  dédiée, réservée à l'administrateur et tracée (RG-XXIII-06).
- **Fonctions d'aide exécutables par `authenticated`** (nécessaire à
  l'évaluation des policies) : `noeud_du_fidele(uuid)` révèle le nœud d'un
  fidèle dont on connaît déjà l'UUID. Fuite marginale (UUID v4 non
  devinables), aucune donnée de fiche exposée.
- **Création d'un nœud de niveau supérieur** : bornée au périmètre en SQL ;
  la règle de rang de type (`creer_noeud_niveau_superieur` = administrateur)
  reste applicative.

## Vérification

```
supabase db reset
psql -v ON_ERROR_STOP=1 -f supabase/tests/0018_authentification_test.sql       "postgresql://postgres:postgres@127.0.0.1:54322/postgres"
psql -v ON_ERROR_STOP=1 -f supabase/tests/0019_activation_policies_rls_test.sql "postgresql://postgres:postgres@127.0.0.1:54322/postgres"
```

Le test 0019 joue 9 profils réels (`auth.uid()` et rôle `authenticated`
PostgREST) sur un arbre siège → région → église 1, plus une église 2 en
branche paire : anonyme, utilisateur simple, membre sans mandat, responsable
régional, pasteur d'E1, pasteur d'E2, trésorier d'E2 (rôle membre), membre
de commission d'E2, administrateur d'amorçage.
