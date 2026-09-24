**GLOBAL SERVICE GROUPE**

**CAHIER DE CONCEPTION APPLICATIVE**

**ECCLESIAS 360**

*Architecture modulaire intégrale, règles de gestion, écrans, mode hors ligne,*

*intégration progressive africaine, sécurité, gestion des caches et programmation*

Plateforme intégrée de gestion ecclésiastique — de l'église locale au réseau international

Application Flutter — édition mobile (Android / iOS) et édition de bureau (Windows)

**Version 2.1 — Édition modulaire consolidée, alignée sur le GSG Platform Kernel v3.0 et le modèle d'authentification Supabase**

Août 2026

# **Sommaire**

La table des matières ci-dessous est un champ Word généré automatiquement à partir des titres du document ; faites un clic droit puis « Mettre à jour les champs » (ou F9) après ouverture pour afficher la pagination réelle.

[**Sommaire**](#sommaire)

[**Introduction**](#introduction)

[**Chapitre 1 — Architecture fonctionnelle modulaire et cartographie des relations**](#chapitre-1-architecture-fonctionnelle-modulaire-et-cartographie-des-relations)

[**1.1 Les sept axes fonctionnels**](#les-sept-axes-fonctionnels)

[**Pilier hiérarchique — la structure organisationnelle (Module I)**](#pilier-hiérarchique-la-structure-organisationnelle-module-i)

[**Pilier humain — le fidèle (Module II)**](#pilier-humain-le-fidèle-module-ii)

[**Axe spirituel — ministères, dons, groupes et comité (Modules III, IV, VI, VII)**](#axe-spirituel-ministères-dons-groupes-et-comité-modules-iii-iv-vi-vii)

[**Axe administratif et disciplinaire (Modules VIII, IX, X)**](#axe-administratif-et-disciplinaire-modules-viii-ix-x)

[**Axe financier et patrimonial (Modules XI, XII, XV, XX, XXI)**](#axe-financier-et-patrimonial-modules-xi-xii-xv-xx-xxi)

[**Axe numérique et pédagogique (Modules XIII, XIV, XVI, XVII, XIX, XXIV)**](#axe-numérique-et-pédagogique-modules-xiii-xiv-xvi-xvii-xix-xxiv)

[**Pilier de gouvernance — paramètres et tableau de bord (Modules XXII, XXIII)**](#pilier-de-gouvernance-paramètres-et-tableau-de-bord-modules-xxii-xxiii)

[**1.2 Vue d'ensemble des relations inter-modules**](#vue-densemble-des-relations-inter-modules)

[**Chapitre 2 — Les vingt-quatre modules : règles de gestion, données, relations et écrans**](#chapitre-2-les-vingt-quatre-modules-règles-de-gestion-données-relations-et-écrans)

[**Module I — Gestion de l'organisation ecclésiastique**](#module-i-gestion-de-lorganisation-ecclésiastique)

[**Objectif fonctionnel**](#objectif-fonctionnel)

[**Règles de gestion**](#règles-de-gestion)

[**Modèle de données (entités clés)**](#modèle-de-données-entités-clés)

[**Relations avec les autres modules**](#relations-avec-les-autres-modules)

[**Écrans par édition**](#écrans-par-édition)

[**Module II — Gestion complète des fidèles**](#module-ii-gestion-complète-des-fidèles)

[**Objectif fonctionnel**](#objectif-fonctionnel-1)

[**Règles de gestion**](#règles-de-gestion-1)

[**Modèle de données (entités clés)**](#modèle-de-données-entités-clés-1)

[**Relations avec les autres modules**](#relations-avec-les-autres-modules-1)

[**Écrans par édition**](#écrans-par-édition-1)

[**Module III — Gestion des ministères et départements**](#module-iii-gestion-des-ministères-et-départements)

[**Objectif fonctionnel**](#objectif-fonctionnel-2)

[**Règles de gestion**](#règles-de-gestion-2)

[**Modèle de données (entités clés)**](#modèle-de-données-entités-clés-2)

[**Relations avec les autres modules**](#relations-avec-les-autres-modules-2)

[**Écrans par édition**](#écrans-par-édition-2)

[**Module IV — Gestion des dons spirituels**](#module-iv-gestion-des-dons-spirituels)

[**Objectif fonctionnel**](#objectif-fonctionnel-3)

[**Règles de gestion**](#règles-de-gestion-3)

[**Modèle de données (entités clés)**](#modèle-de-données-entités-clés-3)

[**Relations avec les autres modules**](#relations-avec-les-autres-modules-3)

[**Écrans par édition**](#écrans-par-édition-3)

[**Module V — Gestion des groupes professionnels**](#module-v-gestion-des-groupes-professionnels)

[**Objectif fonctionnel**](#objectif-fonctionnel-4)

[**Règles de gestion**](#règles-de-gestion-4)

[**Modèle de données (entités clés)**](#modèle-de-données-entités-clés-4)

[**Relations avec les autres modules**](#relations-avec-les-autres-modules-4)

[**Écrans par édition**](#écrans-par-édition-4)

[**Module VI — Gestion des groupes de l'Église**](#module-vi-gestion-des-groupes-de-léglise)

[**Objectif fonctionnel**](#objectif-fonctionnel-5)

[**Règles de gestion**](#règles-de-gestion-5)

[**Modèle de données (entités clés)**](#modèle-de-données-entités-clés-5)

[**Relations avec les autres modules**](#relations-avec-les-autres-modules-5)

[**Écrans par édition**](#écrans-par-édition-5)

[**Module VII — Gestion du comité local**](#module-vii-gestion-du-comité-local)

[**Objectif fonctionnel**](#objectif-fonctionnel-6)

[**Règles de gestion**](#règles-de-gestion-6)

[**Modèle de données (entités clés)**](#modèle-de-données-entités-clés-6)

[**Relations avec les autres modules**](#relations-avec-les-autres-modules-6)

[**Écrans par édition**](#écrans-par-édition-6)

[**Module VIII — Gestion administrative (archivage documentaire)**](#module-viii-gestion-administrative-archivage-documentaire)

[**Objectif fonctionnel**](#objectif-fonctionnel-7)

[**Règles de gestion**](#règles-de-gestion-7)

[**Modèle de données (entités clés)**](#modèle-de-données-entités-clés-7)

[**Relations avec les autres modules**](#relations-avec-les-autres-modules-7)

[**Écrans par édition**](#écrans-par-édition-7)

[**Module IX — Gestion des déplacements**](#module-ix-gestion-des-déplacements)

[**Objectif fonctionnel**](#objectif-fonctionnel-8)

[**Règles de gestion**](#règles-de-gestion-8)

[**Modèle de données (entités clés)**](#modèle-de-données-entités-clés-8)

[**Relations avec les autres modules**](#relations-avec-les-autres-modules-8)

[**Écrans par édition**](#écrans-par-édition-8)

[**Module X — Gestion disciplinaire**](#module-x-gestion-disciplinaire)

[**Objectif fonctionnel**](#objectif-fonctionnel-9)

[**Règles de gestion**](#règles-de-gestion-9)

[**Modèle de données (entités clés)**](#modèle-de-données-entités-clés-9)

[**Relations avec les autres modules**](#relations-avec-les-autres-modules-9)

[**Écrans par édition**](#écrans-par-édition-9)

[**Module XI — Gestion financière**](#module-xi-gestion-financière)

[**Objectif fonctionnel**](#objectif-fonctionnel-10)

[**Règles de gestion**](#règles-de-gestion-10)

[**Modèle de données (entités clés)**](#modèle-de-données-entités-clés-10)

[**Relations avec les autres modules**](#relations-avec-les-autres-modules-10)

[**Écrans par édition**](#écrans-par-édition-10)

[**Module XII — Gestion des cultes**](#module-xii-gestion-des-cultes)

[**Objectif fonctionnel**](#objectif-fonctionnel-11)

[**Règles de gestion**](#règles-de-gestion-11)

[**Modèle de données (entités clés)**](#modèle-de-données-entités-clés-11)

[**Relations avec les autres modules**](#relations-avec-les-autres-modules-11)

[**Écrans par édition**](#écrans-par-édition-11)

[**Module XIII — Médiathèque chrétienne (Global Service Groupe)**](#module-xiii-médiathèque-chrétienne-global-service-groupe)

[**Objectif fonctionnel**](#objectif-fonctionnel-12)

[**Règles de gestion**](#règles-de-gestion-12)

[**Modèle de données (entités clés)**](#modèle-de-données-entités-clés-12)

[**Relations avec les autres modules**](#relations-avec-les-autres-modules-12)

[**Écrans par édition**](#écrans-par-édition-12)

[**Module XIV — Centre de formation en ligne**](#module-xiv-centre-de-formation-en-ligne)

[**Objectif fonctionnel**](#objectif-fonctionnel-13)

[**Règles de gestion**](#règles-de-gestion-13)

[**Modèle de données (entités clés)**](#modèle-de-données-entités-clés-13)

[**Relations avec les autres modules**](#relations-avec-les-autres-modules-13)

[**Écrans par édition**](#écrans-par-édition-13)

[**Module XV — Espace de soutien à Global Service Groupe**](#module-xv-espace-de-soutien-à-global-service-groupe)

[**Objectif fonctionnel**](#objectif-fonctionnel-14)

[**Règles de gestion**](#règles-de-gestion-14)

[**Modèle de données (entités clés)**](#modèle-de-données-entités-clés-14)

[**Relations avec les autres modules**](#relations-avec-les-autres-modules-14)

[**Écrans par édition**](#écrans-par-édition-14)

[**Module XVI — Intelligence artificielle (assistant biblique et ecclésiastique)**](#module-xvi-intelligence-artificielle-assistant-biblique-et-ecclésiastique)

[**Objectif fonctionnel**](#objectif-fonctionnel-15)

[**Règles de gestion**](#règles-de-gestion-15)

[**Modèle de données (entités clés)**](#modèle-de-données-entités-clés-15)

[**Relations avec les autres modules**](#relations-avec-les-autres-modules-15)

[**Écrans par édition**](#écrans-par-édition-15)

[**Module XVII — Communication**](#module-xvii-communication)

[**Objectif fonctionnel**](#objectif-fonctionnel-16)

[**Règles de gestion**](#règles-de-gestion-16)

[**Modèle de données (entités clés)**](#modèle-de-données-entités-clés-16)

[**Relations avec les autres modules**](#relations-avec-les-autres-modules-16)

[**Écrans par édition**](#écrans-par-édition-16)

[**Module XVIII — Gestion des événements**](#module-xviii-gestion-des-événements)

[**Objectif fonctionnel**](#objectif-fonctionnel-17)

[**Règles de gestion**](#règles-de-gestion-17)

[**Modèle de données (entités clés)**](#modèle-de-données-entités-clés-17)

[**Relations avec les autres modules**](#relations-avec-les-autres-modules-17)

[**Écrans par édition**](#écrans-par-édition-17)

[**Module XIX — École biblique**](#module-xix-école-biblique)

[**Objectif fonctionnel**](#objectif-fonctionnel-18)

[**Règles de gestion**](#règles-de-gestion-18)

[**Modèle de données (entités clés)**](#modèle-de-données-entités-clés-18)

[**Relations avec les autres modules**](#relations-avec-les-autres-modules-18)

[**Écrans par édition**](#écrans-par-édition-18)

[**Module XX — Gestion des biens**](#module-xx-gestion-des-biens)

[**Objectif fonctionnel**](#objectif-fonctionnel-19)

[**Règles de gestion**](#règles-de-gestion-19)

[**Modèle de données (entités clés)**](#modèle-de-données-entités-clés-19)

[**Relations avec les autres modules**](#relations-avec-les-autres-modules-19)

[**Écrans par édition**](#écrans-par-édition-19)

[**Module XXI — Comptabilité**](#module-xxi-comptabilité)

[**Objectif fonctionnel**](#objectif-fonctionnel-20)

[**Règles de gestion**](#règles-de-gestion-20)

[**Modèle de données (entités clés)**](#modèle-de-données-entités-clés-20)

[**Relations avec les autres modules**](#relations-avec-les-autres-modules-20)

[**Écrans par édition**](#écrans-par-édition-20)

[**Module XXII — Tableau de bord**](#module-xxii-tableau-de-bord)

[**Objectif fonctionnel**](#objectif-fonctionnel-21)

[**Règles de gestion**](#règles-de-gestion-21)

[**Modèle de données (entités clés)**](#modèle-de-données-entités-clés-21)

[**Relations avec les autres modules**](#relations-avec-les-autres-modules-21)

[**Écrans par édition**](#écrans-par-édition-21)

[**Module XXIII — Paramètres de l'application**](#module-xxiii-paramètres-de-lapplication)

[**Objectif fonctionnel**](#objectif-fonctionnel-22)

[**Règles de gestion**](#règles-de-gestion-22)

[**Modèle de données (entités clés)**](#modèle-de-données-entités-clés-22)

[**Relations avec les autres modules**](#relations-avec-les-autres-modules-22)

[**Écrans par édition**](#écrans-par-édition-22)

[**Module XXIV — Bible numérique et vie de l'Église**](#module-xxiv-bible-numérique-et-vie-de-léglise)

[**Objectif fonctionnel**](#objectif-fonctionnel-23)

[**Règles de gestion**](#règles-de-gestion-23)

[**Modèle de données (entités clés)**](#modèle-de-données-entités-clés-23)

[**Relations avec les autres modules**](#relations-avec-les-autres-modules-23)

[**Écrans par édition**](#écrans-par-édition-23)

[**Chapitre 3 — Architecture technique globale : une base Flutter unique, offline-first**](#chapitre-3-architecture-technique-globale-une-base-flutter-unique-offline-first)

[**3.1 Architecture logicielle en couches**](#architecture-logicielle-en-couches)

[**3.2 Édition mobile**](#édition-mobile)

[**3.3 Édition Windows**](#édition-windows)

[**3.4 Mutualisation et cohérence**](#mutualisation-et-cohérence)

[**Chapitre 4 — Gestion hors ligne (offline-first)**](#chapitre-4-gestion-hors-ligne-offline-first)

[**4.1 Principes directeurs**](#principes-directeurs)

[**4.2 Stratégie de synchronisation**](#stratégie-de-synchronisation)

[**4.3 Modules à criticité hors ligne renforcée**](#modules-à-criticité-hors-ligne-renforcée)

[**Chapitre 5 — Intégration progressive africaine**](#chapitre-5-intégration-progressive-africaine)

[**5.1 Réalités de terrain adressées**](#réalités-de-terrain-adressées)

[**5.2 Canaux de repli en absence de smartphone ou de connexion internet**](#canaux-de-repli-en-absence-de-smartphone-ou-de-connexion-internet)

[**5.3 Feuille de route de déploiement par paliers**](#feuille-de-route-de-déploiement-par-paliers)

[**Chapitre 6 — Sécurité**](#chapitre-6-sécurité)

[**6.1 Authentification et gestion des identités**](#authentification-et-gestion-des-identités)

[**6.2 Rôles, permissions et cloisonnement des données**](#rôles-permissions-et-cloisonnement-des-données)

[**6.3 Protection des données**](#protection-des-données)

[**6.4 Traçabilité et intégrité**](#traçabilité-et-intégrité)

[**Chapitre 7 — Gestion des caches**](#chapitre-7-gestion-des-caches)

[**7.1 Niveaux de cache**](#niveaux-de-cache)

[**7.2 Politiques d'invalidation par type de donnée**](#politiques-dinvalidation-par-type-de-donnée)

[**7.3 Cohérence entre cache et source de vérité**](#cohérence-entre-cache-et-source-de-vérité)

[**Chapitre 8 — Programmation : pile technologique, standards et organisation du code**](#chapitre-8-programmation-pile-technologique-standards-et-organisation-du-code)

[**8.1 Pile technologique**](#pile-technologique)

[**8.2 Organisation du code partagé**](#organisation-du-code-partagé)

[**8.3 Standards de développement**](#standards-de-développement)

[**8.4 Intégration et livraison continues**](#intégration-et-livraison-continues)

[**Chapitre 9 — Récapitulatif quantitatif des écrans**](#chapitre-9-récapitulatif-quantitatif-des-écrans)

[**Chapitre 10 — Modèle économique et monétisation**](#chapitre-10-modèle-économique-et-monétisation)

[**10.1 Principes directeurs du modèle économique**](#principes-directeurs-du-modèle-économique)

[**10.2 Sources de revenus**](#sources-de-revenus)

[**10.3 Paliers d'abonnement**](#paliers-dabonnement)

[**10.4 Règles de gestion de la facturation et des paiements**](#règles-de-gestion-de-la-facturation-et-des-paiements)

[**10.5 Entités de données du modèle économique**](#entités-de-données-du-modèle-économique)

[**10.6 Relations avec les modules existants**](#relations-avec-les-modules-existants)

[**Résumé détaillé**](#résumé-détaillé)

[**Ce que ce document livre**](#ce-que-ce-document-livre)

[**Principes de conception à retenir**](#principes-de-conception-à-retenir)

[**Pour qui**](#pour-qui)

[**Annexes**](#annexes)

[**Annexe A — Glossaire**](#annexe-a-glossaire)

[**Annexe B — Matrice synthétique des rôles types**](#annexe-b-matrice-synthétique-des-rôles-types)

[**Annexe C — Dictionnaire de données consolidé**](#annexe-c-dictionnaire-de-données-consolidé)

[**Annexe D — Feuille de route de mise en œuvre**](#annexe-d-feuille-de-route-de-mise-en-œuvre)

[**Annexe E — Index des règles de gestion transversales**](#annexe-e-index-des-règles-de-gestion-transversales)

[**Annexe F — Synthèse des paliers d'abonnement et sources de revenus**](#annexe-f-synthèse-des-paliers-dabonnement-et-sources-de-revenus)

[**Conclusion**](#conclusion)

# **Introduction**

*« Que tout se fasse avec bienséance et avec ordre. » — 1 Corinthiens 14.40*

Ecclesias 360 n'est pas un simple outil de gestion : c'est l'infrastructure numérique d'une vision. Le présent cahier de conception reprend intégralement le périmètre fonctionnel des vingt-quatre domaines de gestion identifiés pour Ecclesias 360 et le reconstruit selon une architecture modulaire rigoureuse, conçue pour être immédiatement exploitable par une équipe de développement : chaque module y est documenté avec son objectif fonctionnel, ses règles de gestion complètes, ses entités de données, ses relations explicites avec les autres modules, et l'inventaire nommé de ses écrans, mobile et Windows.

Ce document ajoute au cahier initial cinq dimensions transversales indispensables à un déploiement réel en contexte africain et international : la gestion hors ligne (offline-first), condition de survie fonctionnelle dans les zones à connectivité intermittente ; l'intégration progressive africaine, qui définit une stratégie de déploiement par paliers adaptée aux réalités d'infrastructure, d'appareils et de paiement du continent ; la sécurité, qui protège les données spirituelles, disciplinaires et financières les plus sensibles ; la gestion des caches, qui arbitre entre fraîcheur des données et disponibilité hors connexion ; et la programmation, qui fixe l'architecture logicielle, les choix technologiques et les standards de code communs aux deux éditions Flutter.

Il précise également le modèle économique de la plateforme : comment Global Service Groupe génère des revenus pour financer durablement le développement, l'hébergement et l'accompagnement des églises, à travers des abonnements par palier, des commissions de transaction, des formations payantes et des services professionnels, sans jamais monétiser les données personnelles ni restreindre l'accès au socle communautaire gratuit.

Cette édition 2.1 corrige et aligne le cahier sur le socle transversal du portefeuille Global Service Groupe : l'authentification (chapitre 6.1) reprend désormais nativement le modèle Supabase Auth partagé par l'ensemble des applications GSG, la pile technologique (chapitre 8.1) nomme Supabase comme backend standard (KER-DEC-01), et une nouvelle section 8.5 documente précisément la relation d'Ecclesias 360 au GSG Platform Kernel v3.0, selon le gabarit d'intégration commun à tout le portefeuille.

Le document se referme sur un résumé détaillé destiné aux décideurs et sur un ensemble d'annexes opérationnelles : glossaire, dictionnaire de données consolidé, matrice rôles × modules, tableau récapitulatif des écrans, synthèse du modèle économique et feuille de route de mise en œuvre par phases.

# **Chapitre 1 — Architecture fonctionnelle modulaire et cartographie des relations**

L'intelligence d'Ecclesias 360 ne réside pas dans l'accumulation de vingt-quatre modules juxtaposés, mais dans la manière dont ils s'articulent autour de trois entités pivots : la structure organisationnelle, le fidèle, et le flux financier. La conception modulaire retenue applique quatre principes d'architecture qui s'appliquent à chacun des vingt-quatre modules détaillés au chapitre 2 :

- **Principe 1 — Source unique de vérité —** chaque donnée n'est saisie qu'une seule fois, dans le module qui en est propriétaire fonctionnel ; tout autre module y accède par référence (identifiant), jamais par duplication.

- **Principe 2 — Couplage faible, contrat explicite —** un module expose ses données aux autres via des relations documentées et des règles de gestion nommées (RG-xxx) ; aucune dépendance implicite n'est tolérée.

- **Principe 3 — Transversalité assumée —** cinq modules (VIII Archivage, XVI IA, XVII Communication, XXII Tableau de bord, XXIII Paramètres) ne portent pas de métier propre mais servent l'ensemble du système ; ils sont documentés comme des services transversaux plutôt que comme des silos verticaux.

- **Principe 4 — Cohérence multi-niveaux —** toute donnée rattachée à un nœud organisationnel (module I) est consolidable sans re-saisie à chaque niveau supérieur de la hiérarchie, condition du pilotage du réseau international.

## **1.1 Les sept axes fonctionnels**

### **Pilier hiérarchique — la structure organisationnelle (Module I)**

Le module I est le socle sur lequel repose l'ensemble du système. Chaque église locale, chaque secteur, chaque district, jusqu'au siège international, constitue un nœud auquel se rattachent des fidèles, des biens, des cultes, des finances et des statistiques. C'est cette hiérarchie qui rend possible la consolidation multi-niveaux sans double saisie.

### **Pilier humain — le fidèle (Module II)**

Le fidèle est l'entité relationnelle la plus connectée de toute la plateforme. Sa fiche constitue la clé d'entrée vers ses ministères, ses dons spirituels, sa profession, ses groupes d'appartenance, sa fonction éventuelle au comité, ses documents administratifs, ses déplacements, son parcours disciplinaire, ses contributions financières, sa présence aux cultes et aux événements, et son parcours à l'école biblique.

### **Axe spirituel — ministères, dons, groupes et comité (Modules III, IV, VI, VII)**

Cet axe organise la vie communautaire du fidèle. Les dons spirituels identifiés orientent l'affectation aux ministères ; les groupes démographiques et fonctionnels permettent une pastorale ciblée ; le comité local, sous-ensemble qualifié des fidèles, porte la gouvernance de proximité.

### **Axe administratif et disciplinaire (Modules VIII, IX, X)**

La gestion administrative agit comme un greffe numérique transversal : elle archive et numérote automatiquement tout document produit par un autre module. Ces trois modules ne peuvent fonctionner correctement l'un sans l'autre : une mutation sans lettre archivée, ou une sanction sans document tracé, viderait le système de sa valeur probante.

### **Axe financier et patrimonial (Modules XI, XII, XV, XX, XXI)**

Les offrandes et contributions des fidèles, perçues lors des cultes ou en soutien à Global Service Groupe, sont consolidées par la comptabilité, qui intègre la valorisation du patrimoine matériel de l'Église. Cet axe exige la plus grande rigueur de traçabilité.

### **Axe numérique et pédagogique (Modules XIII, XIV, XVI, XVII, XIX, XXIV)**

Cet axe porte l'ambition numérique de Global Service Groupe : la médiathèque diffuse les contenus des cultes et des formations ; l'école biblique recoupe le centre de formation en ligne ; l'assistant IA interroge l'ensemble de ces contenus, y compris pour analyser, reformuler et classer les propositions de thèmes de culte soumises par les fidèles (module XII) ; la communication relaie cette production ; la Bible numérique nourrit la préparation des prédications et alimente l'assistant IA et la médiathèque.

### **Pilier de gouvernance — paramètres et tableau de bord (Modules XXII, XXIII)**

Le module XXIII, les paramètres, est fondateur : il définit en amont les référentiels que les vingt-trois autres modules consomment. Le module XXII, le tableau de bord, ferme la boucle en aval en agrégeant en temps réel les données produites par tous les modules.

## **1.2 Vue d'ensemble des relations inter-modules**

Le tableau ci-dessous synthétise, pour chacun des vingt-quatre modules, les autres modules avec lesquels il entretient une relation fonctionnelle directe. Le détail complet de chaque relation — nature, sens, données échangées — est documenté module par module au chapitre 2.

| **N°** | **Module**                                                       | **Relations directes (modules)**                                                                                                                                                     |
|--------|------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| I      | Gestion de l'organisation ecclésiastique                         | Module II (Fidèles) , Modules XI/XXI (Finances/Comptabilité) , Module XX (Biens) , Modules XII/XVIII (Cultes/Événements) , Module XXII (Tableau de bord) , Module XXIII (Paramètres) |
| II     | Gestion complète des fidèles                                     | Modules III, IV, V, VI, VII , Module IX (Déplacements) , Module X (Discipline) , Module XI (Finances) , Modules XII/XVIII (Cultes/Événements) , Module XIX (École biblique)          |
| III    | Gestion des ministères et départements                           | Module II , Module IV (Dons spirituels) , Module X (Discipline) , Module XVII (Communication)                                                                                        |
| IV     | Gestion des dons spirituels                                      | Module II , Module III , Module XXII                                                                                                                                                 |
| V      | Gestion des groupes professionnels                               | Module II , Module XI , Module XIV                                                                                                                                                   |
| VI     | Gestion des groupes de l'Église                                  | Module II , Module XVII , Module XVIII , Module XXII                                                                                                                                 |
| VII    | Gestion du comité local                                          | Module I , Module II , Module VIII , Module X                                                                                                                                        |
| VIII   | Gestion administrative (archivage documentaire)                  | Module II , Module VII , Module IX , Module X , Module XIV/XIX                                                                                                                       |
| IX     | Gestion des déplacements                                         | Module I , Module II , Module VIII                                                                                                                                                   |
| X      | Gestion disciplinaire                                            | Module II , Module III , Module VII , Module VIII                                                                                                                                    |
| XI     | Gestion financière                                               | Module II , Module XII , Module XXI , Module XXII                                                                                                                                    |
| XII    | Gestion des cultes                                               | Module I , Module II , Module XI , Module XIII , Module XVI , Module XXIV                                                                                                            |
| XIII   | Médiathèque chrétienne (Global Service Groupe)                   | Module XII , Module XIV , Module XVI , Module XXIV                                                                                                                                   |
| XIV    | Centre de formation en ligne                                     | Module V , Module VIII , Module XIII , Module XIX                                                                                                                                    |
| XV     | Espace de soutien à Global Service Groupe                        | Module XI , Module XVII , Module III/V                                                                                                                                               |
| XVI    | Intelligence artificielle (assistant biblique et ecclésiastique) | Module II , Module XII , Module XIII/XIX/XXIV , Transversal                                                                                                                          |
| XVII   | Communication                                                    | Module II/III/V/VI , Module XV , Module XVIII                                                                                                                                        |
| XVIII  | Gestion des événements                                           | Module I , Module II , Module VIII , Module XI , Module XVII                                                                                                                         |
| XIX    | École biblique                                                   | Module II , Module VIII , Module XIV                                                                                                                                                 |
| XX     | Gestion des biens                                                | Module I , Module XII/XVIII , Module XXI                                                                                                                                             |
| XXI    | Comptabilité                                                     | Module XI , Module XX , Module I , Module XXII                                                                                                                                       |
| XXII   | Tableau de bord                                                  | Transversal , Module I , Module XXIII                                                                                                                                                |
| XXIII  | Paramètres de l'application                                      | Transversal , Module I , Module XXII                                                                                                                                                 |
| XXIV   | Bible numérique et vie de l'Église                               | Module XII , Module XIII , Module XVI , Module XIX                                                                                                                                   |

# **Chapitre 2 — Les vingt-quatre modules : règles de gestion, données, relations et écrans**

Ce chapitre documente chacun des vingt-quatre modules de gestion selon un canevas identique, pensé pour être directement exploitable par les équipes de développement, de design et de recette : objectif fonctionnel, règles de gestion numérotées (RG), modèle de données synthétique, relations explicites avec les autres modules, et inventaire nommé des écrans par édition. Un cas d'usage illustre la mise en situation concrète de chaque module.

# **Module I — Gestion de l'organisation ecclésiastique**

*Axe : Pilier hiérarchique · Écrans mobile : 9 · Écrans Windows : 7*

### **Objectif fonctionnel**

Constituer le référentiel hiérarchique unique de la plateforme : chaque entité organisationnelle (église locale, secteur, district, zone, région, préfecture, union, mission, réseau d'Églises, direction nationale, direction internationale, siège Global Service Groupe) est un nœud typé, doté de sa propre identité visuelle et administrative, auquel se rattachent tous les objets métier des vingt-trois autres modules.

### **Règles de gestion**

- **RG-I-01 —** Chaque nœud organisationnel possède un type fermé (église locale, secteur, district, zone, région, préfecture, union, mission, réseau, direction nationale, direction internationale, siège) et un seul nœud parent, à l'exception du siège international qui est racine unique de l'arborescence.

- **RG-I-02 —** Un nœud ne peut être supprimé s'il possède des fidèles actifs, des biens, des comptes financiers ou des cultes rattachés ; il doit d'abord être archivé ou ses rattachements transférés vers un autre nœud.

- **RG-I-03 —** La création d'un nœud de niveau supérieur (ex. district) exige la validation d'un utilisateur porteur du rôle « administrateur de niveau N+1 » ou « administrateur Global Service Groupe ».

- **RG-I-04 —** Tout rapport (financier, statistique, présence) est calculable à deux niveaux : au nœud lui-même (vue propre) et par consolidation ascendante (somme récursive des nœuds enfants), sans double saisie.

- **RG-I-05 —** Chaque nœud dispose d'une fiche d'identité obligatoire : nom, code interne unique, logo, cachet officiel, date de fondation, responsables en fonction (avec historique des titulaires), coordonnées, zone géographique (module XXIII).

- **RG-I-06 —** Le changement de rattachement d'un nœud (ex. une église locale change de district) est un événement tracé horodaté qui déclenche la recomputation des consolidations statistiques et financières des deux branches concernées.

- **RG-I-07 —** Les niveaux hiérarchiques et leurs libellés sont paramétrables par territoire (module XXIII) pour s'adapter aux nomenclatures ecclésiastiques nationales, tout en conservant un ordre de consolidation strict.

- **RG-I-08 —** Un nœud « en création » (statut provisoire) peut fonctionner en autonomie limitée (saisie locale hors ligne) avant validation officielle et rattachement définitif à la hiérarchie.

- **RG-I-09 —** Chaque nœud de type « église locale » est catégorisé à sa création selon son appartenance confessionnelle (Église Catholique / Autres confessions), champ obligatoire et immuable après validation. Cette catégorisation alimente un annuaire des Églises, consultable par les pasteurs et responsables habilités, listant l'ensemble des églises présentes sur la plateforme et filtrable selon ce critère.

### **Modèle de données (entités clés)**

| **Entité de données**  | **Champs clés**                                                                                                                                                                                                                          |
|------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| NœudOrganisationnel    | id_noeud (UUID) · type_noeud · noeud_parent_id · nom · code_interne · logo · cachet · date_fondation · statut (actif/provisoire/archivé) · categorie_confessionnelle (Catholique/Autres, pour les nœuds « église locale ») · zone_geo_id |
| ResponsableNoeud       | id · noeud_id · fidele_id · fonction · date_debut · date_fin                                                                                                                                                                             |
| HistoriqueRattachement | id · noeud_id · ancien_parent_id · nouveau_parent_id · date_effet · motif                                                                                                                                                                |

### **Relations avec les autres modules**

- **• Module II (Fidèles) —** chaque fidèle est rattaché à un nœud d'appartenance.

- **• Modules XI/XXI (Finances/Comptabilité) —** chaque compte et écriture porte un nœud d'imputation.

- **• Module XX (Biens) —** chaque bien est localisé sur un nœud.

- **• Modules XII/XVIII (Cultes/Événements) —** chaque occurrence est rattachée à un nœud organisateur.

- **• Module XXII (Tableau de bord) —** consomme la hiérarchie pour la consolidation multi-niveaux.

- **• Module XXIII (Paramètres) —** définit les types de nœuds et zones géographiques utilisés ici.

### **Écrans par édition**

| **Édition mobile (9 écrans)**                                      | **Édition Windows (7 écrans)**                |
|--------------------------------------------------------------------|-----------------------------------------------|
| 1\. Arbre hiérarchique (vue navigable)                             | 1\. Explorateur hiérarchique multi-colonnes   |
| 2\. Fiche d'un nœud                                                | 2\. Fiche détaillée d'un nœud                 |
| 3\. Création / édition d'un nœud                                   | 3\. Création / édition avancée d'un nœud      |
| 4\. Liste des responsables d'un nœud                               | 4\. Gestion des responsables et mandats       |
| 5\. Affectation d'un responsable                                   | 5\. Rapports de consolidation multi-niveaux   |
| 6\. Historique des rattachements                                   | 6\. Export de l'organigramme                  |
| 7\. Recherche de nœud                                              |                                               |
| 8\. Statistiques rapides du nœud                                   |                                               |
| 9\. Annuaire des Églises (filtrable par catégorie confessionnelle) | 7\. Annuaire des Églises (vue administrateur) |

> ***Cas d'usage —** un district ajoute une nouvelle église locale « en création » : elle fonctionne d'emblée hors ligne pour la saisie de ses premiers fidèles, puis se rattache officiellement à la hiérarchie dès validation par l'administrateur de district, sans perte de données.*

# **Module II — Gestion complète des fidèles**

*Axe : Pilier humain · Écrans mobile : 14 · Écrans Windows : 10*

### **Objectif fonctionnel**

Constituer la fiche fidèle comme entité relationnelle centrale : identité civile, cheminement spirituel, vie familiale, historique complet, servant de clé d'entrée à l'ensemble des modules communautaires, disciplinaires et financiers sans jamais dupliquer l'information.

### **Règles de gestion**

- **RG-II-01 —** Chaque fidèle possède un identifiant unique (matricule) généré à la première saisie et conservé à vie, y compris en cas de mutation (module IX) entre nœuds organisationnels.

- **RG-II-02 —** Le statut spirituel (visiteur, nouveau converti, baptisé, membre actif, membre en discipline, membre décédé, membre transféré) suit une machine à états dont les transitions sont contraintes : un visiteur ne peut passer directement à « membre actif » sans étape « nouveau converti » puis « baptisé », sauf import historique explicitement marqué.

- **RG-II-03 —** Le passage au statut « en discipline » ne peut être déclenché que depuis le module X, jamais par une modification directe de la fiche fidèle.

- **RG-II-04 —** La fiche familiale relie les fidèles entre eux (conjoint, enfants, parents) sans dupliquer les champs d'identité civile ; la suppression d'un lien familial n'entraîne jamais la suppression du fidèle lié.

- **RG-II-05 —** Toute modification d'un champ sensible (statut spirituel, coordonnées, photo) est historisée avec auteur et date, consultable dans l'onglet historique de la fiche.

- **RG-II-06 —** Un fidèle mineur requiert la saisie d'un tuteur légal (autre fidèle ou tiers) et certaines actions (baptême, mutation) exigent une validation pastorale explicite tracée.

- **RG-II-07 —** La fiche agrège en lecture seule les données des modules III, IV, V, VI, VII, IX, X, XI, XII, XVIII, XIX rattachées au fidèle ; elle ne les stocke jamais en double.

- **RG-II-08 —** La suppression physique d'un fidèle est interdite tant qu'il existe des mouvements financiers, disciplinaires ou documentaires associés ; seule l'archivage logique (statut « inactif ») est permis.

- **RG-II-09 —** L'import de masse (migration depuis une base papier ou un tableur) exige une phase de dédoublonnage assistée (nom, date de naissance, téléphone) avant validation définitive.

- **RG-II-10 —** Le fidèle authentifié accède, en écriture sur ses champs non sensibles et en lecture sur le reste — à l'exception des notes pastorales privées écrites sur lui (RG-II-11) —, à sa propre fiche depuis l'écran « Profil et préférences utilisateur » du module XXIII, où il peut compléter ses informations personnelles, consulter son nœud d'appartenance (module I) et son historique complet (RG-II-05).

- **RG-II-11 — Notes pastorales privées —** un pasteur peut consigner sur un fidèle des notes pastorales privées, portées par une entité dédiée (jamais un champ de la fiche ni de son historique). Une note est lisible de son seul auteur et des pasteurs (ou rôle supérieur, administrateur compris) du périmètre du nœud auquel elle est rattachée, **jamais du fidèle concerné**, même s'il détient lui-même le rang de pasteur, jamais d'un responsable, d'un trésorier ou d'un membre de commission à ce titre. Elle est rédigée par un pasteur du périmètre, en son nom propre (personne du registre), jamais sur sa propre fiche ; elle reste rattachée au nœud du fidèle au moment de sa rédaction et ne suit pas une mutation (module IX) — elle n'est donc jamais transmise automatiquement aux pasteurs d'une autre église. Seul son auteur en modifie le contenu, sans historique ; aucune suppression n'est offerte à l'utilisateur. Les listes de notes n'exposent que l'auteur et la date ; le contenu n'est affiché qu'à l'ouverture d'une note, et **chaque ouverture est journalisée** (compte, fiche, rôle, date), journal lisible de qui peut lire la note — extension explicite, par analogie, de la journalisation que RG-SEC-06 impose aux dossiers disciplinaires. Les notes sont exclues de l'agrégation de la fiche (RG-II-07), de la fiche synthèse imprimable et de tout rôle d'assistant IA (module XVI). **Droit d'accès légal —** le refus d'affichage au fidèle concerné est une règle applicative ; il n'éteint pas le droit d'accès que lui reconnaît la réglementation sur les données personnelles (RGPD, législation nationale applicable). L'exercice de ce droit relève d'une procédure administrative encadrée (export sur demande, par l'administrateur), à définir séparément.

### **Modèle de données (entités clés)**

| **Entité de données** | **Champs clés**                                                                                                                                                                                                       |
|-----------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Fidèle                | id_fidele (matricule) · noeud_id · nom · prénoms · date_naissance · sexe · statut_civil · statut_spirituel · date_conversion · date_bapteme · eglise_provenance · photo · coordonnées · statut (actif/inactif/décédé) |
| LienFamilial          | id · fidele_id_1 · fidele_id_2 · type_lien                                                                                                                                                                            |
| HistoriqueFidele      | id · fidele_id · champ_modifie · ancienne_valeur · nouvelle_valeur · auteur · date                                                                                                                                    |
| Tuteur                | id · mineur_id · tuteur_fidele_id_ou_tiers · lien                                                                                                                                                                     |
| NotePastorale         | id · fidele_id · auteur_fidele_id · noeud_id (nœud du fidèle à la rédaction, figé) · contenu · created_at · updated_at (RG-II-11)                                                                                     |
| ConsultationNotePastorale | id · note_id · auth_user_id · fidele_id · role · consulte_le (journal des ouvertures, ajout seul, RG-II-11)                                                                                                       |

### **Relations avec les autres modules**

- **• Modules III, IV, V, VI, VII —** affectations et qualifications du fidèle.

- **• Module IX (Déplacements) —** conserve le matricule lors d'une mutation entre nœuds.

- **• Module X (Discipline) —** seul déclencheur autorisé du statut « en discipline ».

- **• Module XI (Finances) —** chaque contribution référence le fidèle contributeur.

- **• Modules XII/XVIII (Cultes/Événements) —** présence rattachée au fidèle.

- **• Module XIX (École biblique) —** parcours pédagogique rattaché au fidèle.

### **Écrans par édition**

| **Édition mobile (14 écrans)**                | **Édition Windows (10 écrans)**                 |
|-----------------------------------------------|-------------------------------------------------|
| 1\. Liste des fidèles (filtrable)             | 1\. Grille des fidèles (multi-critères, export) |
| 2\. Fiche fidèle (vue synthèse)               | 2\. Fiche fidèle complète                       |
| 3\. Création / édition fidèle                 | 3\. Création / édition fidèle avancée           |
| 4\. Cheminement spirituel (timeline)          | 4\. Import de masse et dédoublonnage            |
| 5\. Liens familiaux                           | 5\. Rapports démographiques                     |
| 6\. Historique des modifications              | 6\. Gestion des liens familiaux                 |
| 7\. Recherche avancée fidèle                  | 7\. Historique et audit des fiches              |
| 8\. Scan / capture de photo fidèle            | 8\. Fusion de doublons (outil dédié)            |
| 9\. Import rapide (contact téléphone)         | 9\. Génération de fiches synthèse en lot        |
| 10\. Fiche synthèse imprimable                | 10\. Consentement et conformité RGPD            |
| 11\. Fusion de doublons                       |                                                 |
| 12\. Statuts spirituels (vue par catégorie)   |                                                 |
| 13\. Notes pastorales privées                 |                                                 |
| 14\. Consentement RGPD / données personnelles |                                                 |

> ***Cas d'usage —** un pasteur enregistre un nouveau converti lors d'une croisade dans une zone sans réseau ; la fiche est créée localement, puis synchronisée le soir venu, alimentant automatiquement le tableau de bord (XXII) et devenant éligible à une affectation ministérielle (III).*

# **Module III — Gestion des ministères et départements**

*Axe : Axe spirituel · Écrans mobile : 9 · Écrans Windows : 6*

### **Objectif fonctionnel**

Gérer les vingt-quatre ministères types (chorale, louange, intercession, jeunesse, diaconat, média, sonorisation, action sociale, etc.), leurs responsables, mandats et affectations multiples de fidèles.

### **Règles de gestion**

- **RG-III-01 —** Un ministère est toujours rattaché à un nœud organisationnel (I) ; un fidèle peut être affecté à plusieurs ministères simultanément, avec au plus un rôle « responsable » actif par ministère et par nœud.

- **RG-III-02 —** Un mandat de responsable a une date de début et une date de fin (ou durée indéterminée) ; à l'expiration, le système notifie le pasteur référent pour renouvellement ou remplacement.

- **RG-III-03 —** La suspension disciplinaire d'un fidèle (module X) suspend automatiquement toutes ses affectations ministérielles actives, avec réintégration manuelle après clôture de la procédure.

- **RG-III-04 —** Le catalogue des types de ministères est paramétrable (module XXIII) mais les vingt-quatre types standards sont proposés par défaut et non supprimables sans droits d'administration globale.

- **RG-III-05 —** Chaque ministère conserve un historique des responsables successifs et un journal d'activités (réunions, rapports d'activité).

### **Modèle de données (entités clés)**

| **Entité de données** | **Champs clés**                                                       |
|-----------------------|-----------------------------------------------------------------------|
| Ministere             | id · noeud_id · type_ministere · nom · date_creation · statut         |
| AffectationMinistere  | id · ministere_id · fidele_id · role · date_debut · date_fin · statut |
| MandatResponsable     | id · ministere_id · fidele_id · date_debut · date_fin_prevue          |

### **Relations avec les autres modules**

- **• Module II —** porte les affectations multiples du fidèle.

- **• Module IV (Dons spirituels) —** oriente les recommandations d'affectation.

- **• Module X (Discipline) —** suspend les affectations en cas de sanction.

- **• Module XVII (Communication) —** cible les membres par ministère.

### **Écrans par édition**

| **Édition mobile (9 écrans)**                       | **Édition Windows (6 écrans)**            |
|-----------------------------------------------------|-------------------------------------------|
| 1\. Liste des ministères                            | 1\. Grille des ministères (multi-nœuds)   |
| 2\. Fiche ministère                                 | 2\. Fiche ministère détaillée             |
| 3\. Création / édition ministère                    | 3\. Gestion des mandats et responsables   |
| 4\. Membres affectés au ministère                   | 4\. Rapports d'effectifs par ministère    |
| 5\. Affectation d'un fidèle                         | 5\. Historique consolidé                  |
| 6\. Historique des responsables                     | 6\. Export des organigrammes ministériels |
| 7\. Journal d'activités du ministère                |                                           |
| 8\. Suggestions d'affectation (basées sur les dons) |                                           |
| 9\. Suivi des mandats arrivant à échéance           |                                           |

> ***Cas d'usage —** un fidèle identifié avec le don de musique (IV) reçoit une suggestion d'affectation au ministère de louange (III) ; le responsable valide, et la communication (XVII) peut désormais le cibler pour les répétitions.*

# **Module IV — Gestion des dons spirituels**

*Axe : Axe spirituel · Écrans mobile : 6 · Écrans Windows : 4*

### **Objectif fonctionnel**

Assurer le suivi pastoral des neuf dons spirituels (1 Corinthiens 12) manifestés par chaque fidèle : identification, maturité, observations, responsable de suivi et historique de développement.

### **Règles de gestion**

- **RG-IV-01 —** Un fidèle peut se voir reconnaître plusieurs dons spirituels, chacun évalué sur une échelle de maturité fermée (émergent, en développement, confirmé, mature) mise à jour périodiquement par un responsable désigné.

- **RG-IV-02 —** Toute évaluation de don est signée par un responsable de suivi (pasteur ou responsable de ministère habilité) et horodatée ; l'historique des évaluations n'est jamais écrasé, seulement complété.

- **RG-IV-03 —** L'identification d'un don déclenche une suggestion automatique d'affectation aux ministères compatibles (module III), sans affectation automatique — validation humaine requise.

- **RG-IV-04 —** Le référentiel des neuf dons est fixe par défaut (paramétrable en extension via module XXIII) pour rester conforme à la doctrine de référence de l'organisation.

### **Modèle de données (entités clés)**

| **Entité de données** | **Champs clés**                                                                                   |
|-----------------------|---------------------------------------------------------------------------------------------------|
| DonSpirituel          | id · libelle · description_biblique                                                               |
| DonFidele             | id · fidele_id · don_id · niveau_maturite · responsable_suivi_id · date_evaluation · observations |

### **Relations avec les autres modules**

- **• Module II —** enrichit la fiche spirituelle du fidèle.

- **• Module III —** oriente l'affectation aux ministères.

- **• Module XXII —** statistiques de répartition des dons.

### **Écrans par édition**

| **Édition mobile (6 écrans)**                | **Édition Windows (4 écrans)**         |
|----------------------------------------------|----------------------------------------|
| 1\. Liste des dons d'un fidèle               | 1\. Grille des dons par fidèle         |
| 2\. Évaluation d'un don                      | 2\. Évaluation et historisation        |
| 3\. Référentiel des neuf dons                | 3\. Rapports de répartition des dons   |
| 4\. Historique d'évolution d'un don          | 4\. Référentiel des dons (paramétrage) |
| 5\. Suggestions de ministères compatibles    |                                        |
| 6\. Statistiques de répartition (vue locale) |                                        |

> ***Cas d'usage —** lors d'un entretien pastoral, un responsable de suivi met à jour la maturité du don d'enseignement d'un fidèle ; l'historique conserve l'évaluation précédente, et la fiche fidèle (II) reflète immédiatement la mise à jour.*

# **Module V — Gestion des groupes professionnels**

*Axe : Axe spirituel · Écrans mobile : 5 · Écrans Windows : 3*

### **Objectif fonctionnel**

Cartographier les compétences professionnelles de l'assemblée (enseignants, médecins, informaticiens, entrepreneurs, artisans, etc.) pour mobiliser l'expertise disponible au service des projets, de l'action sociale et de la formation.

### **Règles de gestion**

- **RG-V-01 —** Un fidèle peut déclarer une ou plusieurs professions/compétences, chacune vérifiable (statut « déclaré » puis « vérifié » par un responsable).

- **RG-V-02 —** Le référentiel de métiers est hiérarchisé (catégorie / métier) et paramétrable, permettant des recherches par grande famille professionnelle.

- **RG-V-03 —** Les groupes professionnels peuvent être sollicités nommément pour un projet (module XI) ou une action sociale, avec traçabilité de la sollicitation et de la réponse du fidèle.

### **Modèle de données (entités clés)**

| **Entité de données** | **Champs clés**                                                          |
|-----------------------|--------------------------------------------------------------------------|
| Profession            | id · categorie · libelle                                                 |
| ProfessionFidele      | id · fidele_id · profession_id · statut_verification · annees_experience |
| Sollicitation         | id · fidele_id · objet · date · reponse                                  |

### **Relations avec les autres modules**

- **• Module II —** lié à la fiche fidèle.

- **• Module XI —** mobilisée par la gestion des projets.

- **• Module XIV —** recoupe les compétences requises par les formations.

### **Écrans par édition**

| **Édition mobile (5 écrans)**        | **Édition Windows (3 écrans)**             |
|--------------------------------------|--------------------------------------------|
| 1\. Liste des groupes professionnels | 1\. Cartographie des compétences (grille)  |
| 2\. Fiche compétence d'un fidèle     | 2\. Vérification des déclarations          |
| 3\. Déclaration d'une profession     | 3\. Rapports par catégorie professionnelle |
| 4\. Recherche par métier             |                                            |
| 5\. Sollicitation d'un groupe        |                                            |

> ***Cas d'usage —** une église souhaitant construire un local sollicite le groupe professionnel des ingénieurs et artisans (V) ; les réponses positives sont tracées et transmises au responsable du projet financier (XI).*

# **Module VI — Gestion des groupes de l'Église**

*Axe : Axe spirituel · Écrans mobile : 5 · Écrans Windows : 3*

### **Objectif fonctionnel**

Segmenter démographiquement et fonctionnellement l'assemblée (hommes, femmes, jeunesse, couples, célibataires, veuves, nouveaux convertis, missionnaires, pasteurs, anciens, diacres) afin de permettre un ciblage pastoral, communicationnel et statistique précis.

### **Règles de gestion**

- **RG-VI-01 —** L'appartenance à un groupe peut être automatique (calculée à partir de champs de la fiche fidèle : âge, sexe, statut civil) ou manuelle (affectation explicite), avec priorité à la règle automatique si les deux sont en conflit, sauf dérogation tracée.

- **RG-VI-02 —** Un fidèle peut appartenir simultanément à plusieurs groupes non exclusifs (ex. « femme » et « nouveau converti »).

- **RG-VI-03 —** Les groupes servent de critère de segmentation pour la communication ciblée (XVII) et les événements (XVIII) sans exposer directement les données personnelles du fidèle au module consommateur (accès par identifiant uniquement).

### **Modèle de données (entités clés)**

| **Entité de données** | **Champs clés**                                                       |
|-----------------------|-----------------------------------------------------------------------|
| GroupeEglise          | id · libelle · type_regle (auto/manuel) · criteres                    |
| AppartenanceGroupe    | id · fidele_id · groupe_id · date_affectation · origine (auto/manuel) |

### **Relations avec les autres modules**

- **• Module II —** rattaché au fidèle.

- **• Module XVII —** critère de ciblage.

- **• Module XVIII —** critère d'invitation.

- **• Module XXII —** analyse démographique.

### **Écrans par édition**

| **Édition mobile (5 écrans)**             | **Édition Windows (3 écrans)**          |
|-------------------------------------------|-----------------------------------------|
| 1\. Liste des groupes                     | 1\. Grille des groupes et effectifs     |
| 2\. Membres d'un groupe                   | 2\. Paramétrage des règles automatiques |
| 3\. Règles d'appartenance automatique     | 3\. Rapports démographiques consolidés  |
| 4\. Affectation manuelle                  |                                         |
| 5\. Statistiques démographiques du groupe |                                         |

> ***Cas d'usage —** une campagne de communication (XVII) cible automatiquement le groupe « nouveaux convertis » (VI) pour les inviter à un événement d'intégration (XVIII), sans qu'un administrateur n'ait à ressaisir la liste des destinataires.*

# **Module VII — Gestion du comité local**

*Axe : Axe spirituel · Écrans mobile : 7 · Écrans Windows : 6*

### **Objectif fonctionnel**

Identifier clairement les membres du comité (pasteur, bureau, conseillers, diacres, anciens) avec mandats, historique des nominations, décisions et procès-verbaux, en tant que sous-ensemble qualifié des fidèles qui porte la gouvernance de proximité.

### **Règles de gestion**

- **RG-VII-01 —** Un membre du comité est nécessairement un fidèle existant (module II) auquel est attribuée une fonction de comité datée (début / fin de mandat) ; il ne peut exister de membre de comité sans fiche fidèle sous-jacente.

- **RG-VII-02 —** Une décision de comité est enregistrée sous forme de procès-verbal structuré (ordre du jour, présents, décisions, votes) et devient immuable après validation — toute correction ultérieure prend la forme d'un erratum tracé, jamais d'une modification silencieuse.

- **RG-VII-03 —** Un procès-verbal validé déclenche automatiquement son archivage numéroté dans la gestion administrative (VIII) et peut générer des tâches de suivi assignées à des membres.

- **RG-VII-04 —** Les décisions à portée disciplinaire (proposition de sanction) alimentent formellement le module X sans que le comité ne puisse statuer seul sur l'issue finale, réservée à la commission disciplinaire.

- **RG-VII-05 —** Le quorum requis pour la validité d'une décision est paramétrable par nœud organisationnel et vérifié par le système avant le passage au statut « adopté ».

### **Modèle de données (entités clés)**

| **Entité de données** | **Champs clés**                                                           |
|-----------------------|---------------------------------------------------------------------------|
| MembreComite          | id · fidele_id · noeud_id · fonction · date_debut · date_fin              |
| SeanceComite          | id · noeud_id · date · ordre_du_jour · presents · quorum_atteint          |
| Decision              | id · seance_id · libelle · resultat_vote · statut (adopté/rejeté/ajourné) |
| ProcesVerbal          | id · seance_id · document_archive_id · statut (brouillon/validé)          |

### **Relations avec les autres modules**

- **• Module I —** rattaché à l'église locale ou au nœud concerné.

- **• Module II —** sous-ensemble qualifié des fidèles.

- **• Module VIII —** archivage automatique des PV.

- **• Module X —** source de propositions disciplinaires.

### **Écrans par édition**

| **Édition mobile (7 écrans)**             | **Édition Windows (6 écrans)**          |
|-------------------------------------------|-----------------------------------------|
| 1\. Liste des membres du comité           | 1\. Grille des membres et mandats       |
| 2\. Fiche membre (fonction, mandat)       | 2\. Gestion des séances                 |
| 3\. Convocation de séance                 | 3\. Rédaction et validation des PV      |
| 4\. Saisie de séance / ordre du jour      | 4\. Archivage et recherche de décisions |
| 5\. Enregistrement des décisions et votes | 5\. Rapports de gouvernance             |
| 6\. Historique des PV                     | 6\. Suivi des quorums                   |
| 7\. Suivi des tâches issues des décisions |                                         |

> ***Cas d'usage —** le comité local vote la création d'un nouveau ministère ; la décision est actée en PV, archivée automatiquement (VIII), et déclenche la création effective du ministère dans le module III.*

# **Module VIII — Gestion administrative (archivage documentaire)**

*Axe : Axe administratif et disciplinaire · Écrans mobile : 9 · Écrans Windows : 7*

### **Objectif fonctionnel**

Servir de greffe numérique transversal : archiver et numéroter automatiquement tout document officiel produit par un autre module (certificats, attestations, lettres de mutation ou disciplinaires, PV, budgets, contrats, statuts, règlements, rapports).

### **Règles de gestion**

- **RG-VIII-01 —** Tout document archivé reçoit un numéro unique et immuable selon une nomenclature paramétrable (type-nœud-année-séquence) attribué au moment de la validation, jamais en brouillon.

- **RG-VIII-02 —** Un document archivé est en lecture seule ; toute nouvelle version constitue un nouvel enregistrement lié au précédent par une chaîne de versions, l'original restant accessible.

- **RG-VIII-03 —** Les documents à caractère disciplinaire ou spirituel sensible (module X, module II) héritent d'un niveau de confidentialité renforcé, restreignant leur consultation aux rôles habilités (module XXIII).

- **RG-VIII-04 —** Chaque document conserve la trace de son module d'origine et de l'objet métier qui l'a généré (ex. fidèle, mutation, séance de comité), permettant une navigation croisée bidirectionnelle.

- **RG-VIII-05 —** La suppression d'un document archivé est interdite ; seule une mise en corbeille réversible par un administrateur habilité, avec délai de purge paramétrable, est autorisée.

- **RG-VIII-06 —** Les documents produits hors connexion sont mis en file d'attente d'archivage et ne reçoivent leur numéro définitif qu'à la synchronisation, pour garantir l'unicité de la séquence.

### **Modèle de données (entités clés)**

| **Entité de données** | **Champs clés**                                                                                                                                 |
|-----------------------|-------------------------------------------------------------------------------------------------------------------------------------------------|
| DocumentArchive       | id · numero_archive · type_document · module_origine · objet_id_origine · noeud_id · niveau_confidentialite · fichier · date_archivage · statut |
| VersionDocument       | id · document_id · numero_version · fichier · date                                                                                              |
| NomenclatureArchivage | id · type_document · modele_numerotation                                                                                                        |

### **Relations avec les autres modules**

- **• Module II —** certificats de baptême et attestations.

- **• Module VII —** PV du comité.

- **• Module IX —** lettres de mutation.

- **• Module X —** décisions disciplinaires.

- **• Module XIV/XIX —** diplômes et certificats de formation.

### **Écrans par édition**

| **Édition mobile (9 écrans)**                 | **Édition Windows (7 écrans)**                 |
|-----------------------------------------------|------------------------------------------------|
| 1\. Bibliothèque documentaire                 | 1\. Explorateur documentaire multi-critères    |
| 2\. Consultation d'un document                | 2\. Éditeur de modèles de documents            |
| 3\. Génération d'un document depuis un modèle | 3\. Paramétrage de la nomenclature d'archivage |
| 4\. Recherche documentaire                    | 4\. Gestion de la confidentialité par type     |
| 5\. File d'attente d'archivage hors ligne     | 5\. Rapports d'archivage                       |
| 6\. Corbeille documentaire                    | 6\. Corbeille et purge                         |
| 7\. Historique des versions                   | 7\. Export en lot                              |
| 8\. Partage sécurisé d'un document            |                                                |
| 9\. Signature / validation d'un document      |                                                |

> ***Cas d'usage —** une lettre de mutation générée par le module IX et un diplôme délivré par l'école biblique (XIX) sont archivés sous le même système de numérotation, consultables depuis la fiche du fidèle concerné (II).*

# **Module IX — Gestion des déplacements**

*Axe : Axe administratif et disciplinaire · Écrans mobile : 6 · Écrans Windows : 4*

### **Objectif fonctionnel**

Gérer les mutations de fidèles entre églises : église d'origine, église d'accueil, lettre de recommandation, validation pastorale, motif et historique, en reliant deux nœuds organisationnels via le fidèle concerné.

### **Règles de gestion**

- **RG-IX-01 —** Une mutation référence obligatoirement un nœud d'origine, un nœud de destination et le fidèle concerné ; elle ne modifie le rattachement effectif du fidèle qu'après validation pastorale des deux côtés (ou d'un seul si la politique du réseau l'autorise, paramétrable).

- **RG-IX-02 —** La validation d'une mutation génère automatiquement une lettre de recommandation archivée dans le module VIII, portant le matricule du fidèle et le motif du déplacement.

- **RG-IX-03 —** L'historique complet des rattachements successifs d'un fidèle est conservé et consultable depuis sa fiche (module II), garantissant la continuité du parcours spirituel malgré les mutations.

- **RG-IX-04 —** Une mutation en attente de validation ne modifie aucune statistique de consolidation tant qu'elle n'est pas actée, pour éviter tout comptage en double entre les deux nœuds.

### **Modèle de données (entités clés)**

| **Entité de données** | **Champs clés**                                                                                                                         |
|-----------------------|-----------------------------------------------------------------------------------------------------------------------------------------|
| Mutation              | id · fidele_id · noeud_origine_id · noeud_destination_id · motif · statut (en attente/validée/refusée) · date_demande · date_validation |
| LettreRecommandation  | id · mutation_id · document_archive_id                                                                                                  |

### **Relations avec les autres modules**

- **• Module I —** relie deux nœuds organisationnels.

- **• Module II —** conserve le matricule et l'historique du fidèle.

- **• Module VIII —** archivage automatique de la lettre.

### **Écrans par édition**

| **Édition mobile (6 écrans)**               | **Édition Windows (4 écrans)**           |
|---------------------------------------------|------------------------------------------|
| 1\. Liste des mutations                     | 1\. Grille des mutations (multi-nœuds)   |
| 2\. Demande de mutation                     | 2\. Traitement et validation en masse    |
| 3\. Validation pastorale (origine)          | 3\. Rapports de mobilité inter-nœuds     |
| 4\. Validation pastorale (destination)      | 4\. Modèles de lettres de recommandation |
| 5\. Lettre de recommandation générée        |                                          |
| 6\. Historique des déplacements d'un fidèle |                                          |

> ***Cas d'usage —** un fidèle déménageant vers une autre ville demande sa mutation ; la validation pastorale des deux églises génère automatiquement la lettre de recommandation archivée, et son historique de rattachement (II) est mis à jour sans perte de son parcours antérieur.*

# **Module X — Gestion disciplinaire**

*Axe : Axe administratif et disciplinaire · Écrans mobile : 6 · Écrans Windows : 5*

### **Objectif fonctionnel**

Assurer la traçabilité complète des procédures disciplinaires : nature de la faute, témoins, commission, décision, durée, réintégration et historique, dans le respect strict de la confidentialité.

### **Règles de gestion**

- **RG-X-01 —** L'ouverture d'un dossier disciplinaire ne peut être initiée que par un rôle habilité (pasteur référent ou membre de commission désigné) et bascule automatiquement le statut spirituel du fidèle concerné (module II) en « en discipline ».

- **RG-X-02 —** Un dossier disciplinaire comporte obligatoirement une nature de faute (référentiel fermé et extensible), une liste de témoins ou pièces, une commission instructrice et une décision motivée et datée.

- **RG-X-03 —** La décision de sanction peut suspendre automatiquement une ou plusieurs affectations ministérielles actives du fidèle (module III) pour la durée de la sanction.

- **RG-X-04 —** La durée de sanction, si déterminée, déclenche une alerte de fin de période au responsable de suivi pour statuer sur la réintégration ; si indéterminée, une revue périodique est planifiée automatiquement.

- **RG-X-05 —** L'accès aux dossiers disciplinaires est restreint aux rôles explicitement habilités (pasteur référent, commission, administrateur habilité) — la fiche fidèle grand public n'affiche jamais le détail, seulement un indicateur de statut.

- **RG-X-06 —** Toute pièce du dossier est archivée dans le module VIII avec le niveau de confidentialité maximal.

### **Modèle de données (entités clés)**

| **Entité de données**   | **Champs clés**                                                                                                                            |
|-------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| DossierDisciplinaire    | id · fidele_id · noeud_id · nature_faute · date_ouverture · commission_id · statut · decision · duree_sanction · date_reintegration_prevue |
| CommissionDisciplinaire | id · noeud_id · membres                                                                                                                    |
| PieceDossier            | id · dossier_id · document_archive_id · nature (témoignage/preuve)                                                                         |

### **Relations avec les autres modules**

- **• Module II —** bascule le statut spirituel du fidèle.

- **• Module III —** suspend les affectations ministérielles.

- **• Module VII —** la commission peut être issue du comité.

- **• Module VIII —** archivage confidentiel des pièces.

### **Écrans par édition**

| **Édition mobile (6 écrans)**            | **Édition Windows (5 écrans)**                     |
|------------------------------------------|----------------------------------------------------|
| 1\. Liste des dossiers (accès restreint) | 1\. Grille des dossiers disciplinaires (habilités) |
| 2\. Ouverture d'un dossier               | 2\. Instruction complète et pièces jointes         |
| 3\. Instruction / commission             | 3\. Gestion des commissions                        |
| 4\. Décision et sanction                 | 4\. Rapports de suivi disciplinaire                |
| 5\. Suivi de réintégration               | 5\. Alertes de fin de sanction                     |
| 6\. Historique confidentiel d'un fidèle  |                                                    |

> ***Cas d'usage —** une procédure disciplinaire est ouverte par le pasteur référent ; le statut spirituel du fidèle (II) bascule automatiquement, ses affectations ministérielles (III) sont suspendues, et la décision finale est archivée avec confidentialité renforcée (VIII).*

# **Module XI — Gestion financière**

*Axe : Axe financier et patrimonial · Écrans mobile : 8 · Écrans Windows : 10*

### **Objectif fonctionnel**

Piloter les offrandes (ordinaires, dîmes, prémices, missionnaires, construction), les contributions et engagements des fidèles, ainsi que les projets avec budget, dépenses et solde suivis individuellement, chaque mouvement étant rattaché à un fidèle et à un nœud.

### **Règles de gestion**

- **RG-XI-01 —** Chaque contribution est rattachée obligatoirement à un fidèle contributeur (ou à un donateur anonyme identifié techniquement), un type d'offrande (référentiel du module XXIII), un nœud organisationnel et, le cas échéant, un culte (XII) ou un projet.

- **RG-XI-02 —** La saisie d'une contribution est distincte de sa validation comptable : une contribution saisie sur le terrain (mobile, hors ligne) reste au statut « en attente » jusqu'à rapprochement et validation par un rôle trésorier, condition de séparation des tâches entre saisie et validation.

- **RG-XI-03 —** Un projet financier possède un budget prévisionnel, un solde en temps réel (recettes moins dépenses affectées) et ne peut engager de dépense au-delà du solde disponible sans dérogation tracée d'un rôle habilité.

- **RG-XI-04 —** Les engagements récurrents (dîme d'engagement, promesse de don) génèrent des échéances suivies avec relance automatique en cas de retard, sans jamais rendre publique l'information individuelle.

- **RG-XI-05 —** Toute contribution validée est irréversible en modification directe : une correction prend la forme d'une écriture de contre-passation tracée, jamais d'une édition du montant initial.

- **RG-XI-06 —** Les contributions saisies hors ligne sont horodatées localement, mises en file de synchronisation, et rapprochées à la reconnexion avec détection de doublons (même fidèle, même montant, même date à la minute près).

- **RG-XI-07 —** Les totaux par nœud remontent en consolidation vers le module XXI (Comptabilité) et alimentent en temps réel le tableau de bord (XXII) après validation, jamais avant.

### **Modèle de données (entités clés)**

| **Entité de données** | **Champs clés**                                                                                                                                                                                         |
|-----------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Contribution          | id · fidele_id · type_offrande_id · montant · devise_id (GSG Referential) · noeud_id · culte_id · projet_id · mode_paiement · statut (en attente/validée/rejetée) · origine (mobile/desktop/hors-ligne) |
| Engagement            | id · fidele_id · type · montant_prevu · periodicite · date_debut · statut                                                                                                                               |
| Projet                | id · noeud_id · nom · budget_previsionnel · solde_actuel · statut                                                                                                                                       |
| DepenseProjet         | id · projet_id · montant · libelle · date · valide_par                                                                                                                                                  |

### **Relations avec les autres modules**

- **• Module II —** contributeur.

- **• Module XII —** rattachement au culte.

- **• Module XXI —** consolidation comptable.

- **• Module XXII —** visualisation temps réel.

### **Écrans par édition**

| **Édition mobile (8 écrans)**                | **Édition Windows (10 écrans)**                   |
|----------------------------------------------|---------------------------------------------------|
| 1\. Saisie rapide d'offrande                 | 1\. Rapprochement et validation des contributions |
| 2\. Historique des contributions d'un fidèle | 2\. Grand livre des contributions                 |
| 3\. Liste des projets                        | 3\. Gestion des projets et budgets                |
| 4\. Fiche projet (budget / solde)            | 4\. Suivi des engagements et relances             |
| 5\. Engagements et échéances                 | 5\. Rapports financiers détaillés                 |
| 6\. File de synchronisation hors ligne       | 6\. Export comptable                              |
| 7\. Reçu de contribution                     | 7\. Gestion des types d'offrandes                 |
| 8\. Rapport rapide par type d'offrande       | 8\. Contre-passations et corrections              |
|                                              | 9\. Consolidation multi-nœuds                     |
|                                              | 10\. Détection de doublons post-synchronisation   |

> ***Cas d'usage —** un fidèle donne sa dîme via l'application mobile en zone rurale hors connexion ; la contribution est horodatée localement, mise en file de synchronisation, puis rapprochée et validée par le trésorier à la reconnexion, sans double comptage.*

# **Module XII — Gestion des cultes**

*Axe : Axe financier et patrimonial · Écrans mobile : 9 · Écrans Windows : 7*

### **Objectif fonctionnel**

Planifier et documenter le programme, la liturgie, les présences, les offrandes et les messages de chaque culte, avec publication post-culte du texte biblique, du thème, des notes, de l'audio, de la vidéo et du PDF.

### **Règles de gestion**

- **RG-XII-01 —** Un culte est rattaché à un nœud organisationnel et à une date/heure ; son programme (liturgie) est structuré en séquences ordonnées (louange, prédication, offrande, annonces).

- **RG-XII-02 —** La feuille de présence peut être saisie individuellement (pointage nominal) ou de façon agrégée (compte global) selon la taille de l'assemblée et la politique du nœud, les deux modes étant mutuellement exclusifs pour un même culte.

- **RG-XII-03 —** La publication post-culte (texte biblique, thème, notes, audio, vidéo, PDF) est optionnelle et déclenche automatiquement l'archivage du contenu dans la médiathèque (XIII) avec les métadonnées du culte.

- **RG-XII-04 —** Les offrandes perçues pendant le culte sont saisies via le module XI avec le culte comme référence obligatoire, permettant leur rapprochement lors de la clôture de caisse du jour.

- **RG-XII-05 —** Un culte peut être créé en mode récurrent (culte dominical hebdomadaire) générant automatiquement les occurrences futures avec possibilité d'exception ponctuelle.

- **RG-XII-06 —** Tout fidèle peut soumettre une proposition de thème de culte accompagnée d'une brève explication. Les autres fidèles votent (« j'aime » / « je n'aime pas ») sur chaque proposition. Avant publication, l'assistant IA (module XVI) analyse la proposition, la reformule si nécessaire pour en clarifier l'expression, puis la classe automatiquement dans une catégorie thématique cohérente avec les propositions déjà soumises, alimentant un répertoire structuré consultable par le pasteur pour la préparation du culte.

### **Modèle de données (entités clés)**

| **Entité de données** | **Champs clés**                                                                                      |
|-----------------------|------------------------------------------------------------------------------------------------------|
| Culte                 | id · noeud_id · date_heure · type_culte · theme · predicateur_id · statut                            |
| SequenceLiturgique    | id · culte_id · ordre · libelle · responsable_id · duree_prevue                                      |
| PresenceCulte         | id · culte_id · fidele_id_ou_compte_global · mode                                                    |
| PublicationCulte      | id · culte_id · texte_biblique · audio · video · pdf · date_publication                              |
| PropositionTheme      | id · fidele_id · titre · explication · categorie · nb_likes · nb_dislikes · statut · date_soumission |

### **Relations avec les autres modules**

- **• Module I —** rattaché à l'église locale.

- **• Module II —** présence des fidèles.

- **• Module XI —** offrandes du culte.

- **• Module XIII —** alimentation automatique de la médiathèque.

- **• Module XXIV —** préparation des prédications depuis la Bible numérique.

- **• Module XVI —** analyse, reformulation et classement automatique des propositions de thèmes de culte avant publication.

### **Écrans par édition**

| **Édition mobile (9 écrans)**                                   | **Édition Windows (7 écrans)**               |
|-----------------------------------------------------------------|----------------------------------------------|
| 1\. Calendrier des cultes                                       | 1\. Planification des cultes récurrents      |
| 2\. Fiche culte (programme)                                     | 2\. Gestion complète de la liturgie          |
| 3\. Feuille de présence (pointage)                              | 3\. Consolidation des présences              |
| 4\. Saisie liturgie                                             | 4\. Publication et archivage multimédia      |
| 5\. Publication post-culte                                      | 5\. Rapports de fréquentation                |
| 6\. Historique des cultes                                       | 6\. Clôture de caisse du culte               |
| 7\. Statistiques de fréquentation rapides                       |                                              |
| 8\. Soumission d'une proposition de thème                       | 7\. Validation pastorale des thèmes proposés |
| 9\. Vote sur les propositions de thème (j'aime / je n'aime pas) |                                              |

> ***Cas d'usage —** un pasteur préparant le culte du dimanche programme la liturgie, puis publie après le culte le texte biblique et l'audio de la prédication, automatiquement versés dans la médiathèque (XIII) et interrogeables par l'assistant IA (XVI).*

# **Module XIII — Médiathèque chrétienne (Global Service Groupe)**

*Axe : Axe numérique et pédagogique · Écrans mobile : 11 · Écrans Windows : 7*

### **Objectif fonctionnel**

Diffuser musiques, prédications audio et vidéo, podcasts, témoignages, e-books, magazines et documents produits par Global Service Groupe et par les nœuds locaux, avec téléchargement, écoute, favoris, commentaires modérés et recherche thématique.

### **Règles de gestion**

- **RG-XIII-01 —** Chaque contenu médiathèque possède un type fermé (audio, vidéo, podcast, e-book, magazine, document), une source (culte, formation, production éditoriale Global Service Groupe) et un statut de publication (brouillon, publié, retiré).

- **RG-XIII-02 —** Le téléchargement pour lecture hors ligne est autorisé par défaut sauf restriction explicite de droits sur le contenu (paramétrable par élément), avec gestion de l'espace de stockage local et purge des contenus les plus anciens non favoris en cas de saturation.

- **RG-XIII-03 —** Les commentaires sont soumis à modération a priori ou a posteriori selon la politique du nœud éditeur ; un commentaire signalé plusieurs fois est automatiquement masqué en attente de revue.

- **RG-XIII-04 —** La recherche thématique s'appuie sur des métadonnées obligatoires (thème, mots-clés, intervenant, date, module source) alimentées automatiquement lors de l'archivage automatique depuis les modules XII et XIV.

- **RG-XIII-05 —** Les statistiques d'écoute/visionnage/téléchargement sont agrégées de façon anonymisée pour le tableau de bord, sans exposer individuellement le comportement de consultation d'un fidèle.

### **Modèle de données (entités clés)**

| **Entité de données** | **Champs clés**                                                                                                |
|-----------------------|----------------------------------------------------------------------------------------------------------------|
| ContenuMediatheque    | id · type_contenu · titre · source_module · source_id · fichier · metadonnees · statut · droits_telechargement |
| Favori                | id · fidele_id · contenu_id                                                                                    |
| Commentaire           | id · contenu_id · fidele_id · texte · statut_moderation · date                                                 |

### **Relations avec les autres modules**

- **• Module XII —** réception automatique des contenus de culte.

- **• Module XIV —** réception des contenus de formation.

- **• Module XVI —** source consultée par l'assistant IA.

- **• Module XXIV —** sermons liés à la Bible numérique.

### **Écrans par édition**

| **Édition mobile (11 écrans)**                | **Édition Windows (7 écrans)**         |
|-----------------------------------------------|----------------------------------------|
| 1\. Catalogue médiathèque (grille/liste)      | 1\. Back-office de publication         |
| 2\. Lecteur audio/vidéo                       | 2\. Modération des commentaires        |
| 3\. Téléchargements hors ligne                | 3\. Gestion des métadonnées et droits  |
| 4\. Favoris                                   | 4\. Statistiques d'audience            |
| 5\. Commentaires                              | 5\. Import en masse de contenus        |
| 6\. Recherche thématique                      | 6\. Organisation par catégories/thèmes |
| 7\. Fiche contenu détaillée                   | 7\. Export catalogue                   |
| 8\. Bibliothèque e-books/magazines            |                                        |
| 9\. Gestion de l'espace de stockage local     |                                        |
| 10\. Partage d'un contenu                     |                                        |
| 11\. Statistiques de consultation personnelle |                                        |

> ***Cas d'usage —** un fidèle en zone à faible connectivité télécharge à l'avance la prédication du dimanche pour l'écouter hors ligne pendant la semaine, l'application gérant automatiquement l'espace de stockage disponible sur son appareil.*

# **Module XIV — Centre de formation en ligne**

*Axe : Axe numérique et pédagogique · Écrans mobile : 11 · Écrans Windows : 8*

### **Objectif fonctionnel**

Proposer des formations gratuites ou payantes avec vidéos, PDF, quiz, évaluations, certificats, suivi de progression, paiement sécurisé, classes virtuelles et suivi des inscriptions.

### **Règles de gestion**

- **RG-XIV-01 —** Une formation est composée de modules pédagogiques ordonnés (leçon vidéo, document, quiz) ; la progression d'un apprenant avance séquentiellement sauf configuration explicite en accès libre.

- **RG-XIV-02 —** Une formation payante requiert un paiement validé avant déblocage de l'accès complet ; un aperçu gratuit limité peut être configuré par formation.

- **RG-XIV-03 —** Un quiz possède un seuil de réussite paramétrable ; la délivrance du certificat final est conditionnée à l'atteinte du seuil sur l'ensemble des évaluations requises du parcours.

- **RG-XIV-04 —** Le certificat délivré est automatiquement archivé dans le module VIII avec numérotation unique et vérifiable.

- **RG-XIV-05 —** Une classe virtuelle (session en direct) possède une capacité maximale, une liste d'inscrits et un enregistrement optionnel automatiquement versé à la médiathèque (XIII) après la session.

- **RG-XIV-06 —** La progression pédagogique est synchronisée entre éditions mobile et Windows pour un même apprenant, avec résolution du conflit en faveur de la progression la plus avancée en cas de double usage hors ligne.

### **Modèle de données (entités clés)**

| **Entité de données** | **Champs clés**                                                                  |
|-----------------------|----------------------------------------------------------------------------------|
| Formation             | id · titre · editeur · type (gratuite/payante) · prix · statut                   |
| ModulePedagogique     | id · formation_id · ordre · type_contenu · fichier                               |
| Inscription           | id · formation_id · fidele_id · date_inscription · progression · statut_paiement |
| Evaluation            | id · module_id · fidele_id · score · seuil_reussite · reussi                     |
| Certificat            | id · inscription_id · document_archive_id · date_delivrance                      |
| ClasseVirtuelle       | id · formation_id · date_heure · capacite · lien_session · enregistrement_url    |

### **Relations avec les autres modules**

- **• Module V —** compétences requises/proposées.

- **• Module VIII —** archivage des certificats.

- **• Module XIII —** versement des enregistrements.

- **• Module XIX —** recoupement pédagogique avec l'école biblique.

### **Écrans par édition**

| **Édition mobile (11 écrans)**                 | **Édition Windows (8 écrans)**                        |
|------------------------------------------------|-------------------------------------------------------|
| 1\. Catalogue des formations                   | 1\. Back-office de création de formations             |
| 2\. Fiche formation                            | 2\. Gestion des modules pédagogiques                  |
| 3\. Lecteur de leçon                           | 3\. Gestion des inscriptions et paiements             |
| 4\. Passage de quiz                            | 4\. Suivi de progression des apprenants (vue globale) |
| 5\. Suivi de progression                       | 5\. Génération et vérification des certificats        |
| 6\. Mes certificats                            | 6\. Planification des classes virtuelles              |
| 7\. Paiement d'une formation                   | 7\. Rapports pédagogiques                             |
| 8\. Classes virtuelles (agenda, rejoindre)     | 8\. Import/export de contenus de formation            |
| 9\. Mes inscriptions                           |                                                       |
| 10\. Notifications de formation                |                                                       |
| 11\. Espace hors ligne des leçons téléchargées |                                                       |

> ***Cas d'usage —** un jeune de l'assemblée s'inscrit à une formation payante sur le leadership ; il règle en ligne, suit les leçons vidéo hors connexion, passe les quiz, et reçoit un certificat automatiquement archivé (VIII) à l'issue du parcours.*

# **Module XV — Espace de soutien à Global Service Groupe**

*Axe : Axe financier et patrimonial · Écrans mobile : 6 · Écrans Windows : 4*

### **Objectif fonctionnel**

Offrir un espace dédié aux dons libres, au soutien mensuel, au financement de projets, au partenariat missionnaire, aux campagnes de collecte et aux appels aux bénévoles, fonctionnant en miroir du module financier mais au niveau du siège Global Service Groupe.

### **Règles de gestion**

- **RG-XV-01 —** Une campagne de soutien possède un objectif cible (montant ou nombre de bénévoles), une date de début et de fin, un statut, et un compteur de progression mis à jour en temps réel.

- **RG-XV-02 —** Un don réalisé dans ce module suit les mêmes règles de séparation saisie/validation que le module XI (RG-XI-02) mais est imputé au nœud siège Global Service Groupe plutôt qu'à l'église locale du donateur.

- **RG-XV-03 —** Le soutien mensuel récurrent génère des prélèvements planifiés avec relance en cas d'échec de paiement et possibilité de suspension par le fidèle à tout moment, sans justification requise.

- **RG-XV-04 —** Un appel aux bénévoles référence les groupes professionnels (V) et les ministères (III) pertinents pour cibler les profils recherchés, sans affectation automatique.

### **Modèle de données (entités clés)**

| **Entité de données** | **Champs clés**                                                                             |
|-----------------------|---------------------------------------------------------------------------------------------|
| CampagneSoutien       | id · titre · type (don/bénévolat) · objectif · progression · date_debut · date_fin · statut |
| DonGSG                | id · fidele_id · campagne_id · montant · mode_paiement · statut · recurrence                |
| AppelBenevoles        | id · campagne_id · profils_recherches · reponses                                            |

### **Relations avec les autres modules**

- **• Module XI —** miroir fonctionnel au niveau Global Service Groupe.

- **• Module XVII —** relais des campagnes.

- **• Module III/V —** ciblage des profils bénévoles.

### **Écrans par édition**

| **Édition mobile (6 écrans)**         | **Édition Windows (4 écrans)**                |
|---------------------------------------|-----------------------------------------------|
| 1\. Liste des campagnes actives       | 1\. Création et pilotage des campagnes        |
| 2\. Fiche campagne (progression)      | 2\. Suivi des dons et prélèvements récurrents |
| 3\. Faire un don ponctuel             | 3\. Gestion des appels aux bénévoles          |
| 4\. Souscrire un soutien mensuel      | 4\. Rapports de collecte consolidés           |
| 5\. Répondre à un appel aux bénévoles |                                               |
| 6\. Historique de mes soutiens        |                                               |

> ***Cas d'usage —** Global Service Groupe lance une campagne de collecte pour un projet missionnaire ; les dons affluent depuis plusieurs pays, la progression de la campagne est visible en temps réel, et la communication (XVII) relaie l'appel aux audiences ciblées.*

# **Module XVI — Intelligence artificielle (assistant biblique et ecclésiastique)**

*Axe : Axe numérique et pédagogique · Écrans mobile : 4 · Écrans Windows : 3*

### **Objectif fonctionnel**

Fournir un assistant conversationnel capable d'expliquer les notions bibliques, les termes ecclésiastiques, les ministères et les dons spirituels, de retrouver des versets et d'assister les administrateurs dans leurs tâches courantes.

### **Règles de gestion**

- **RG-XVI-01 —** L'assistant interroge exclusivement les données auxquelles l'utilisateur connecté a lui-même accès (respect strict des permissions du module XXIII) — il n'accède jamais à des données disciplinaires ou financières hors habilitation de son utilisateur.

- **RG-XVI-02 —** Toute réponse générée à partir de la Bible numérique (XXIV) ou de la médiathèque (XIII) référence sa source consultée, affichée à l'utilisateur pour vérification.

- **RG-XVI-03 —** L'assistant fonctionne en mode dégradé hors connexion sur un sous-ensemble de connaissances embarquées localement (versets, définitions courantes) ; les requêtes nécessitant le cloud sont mises en file d'attente et traitées à la reconnexion.

- **RG-XVI-04 —** Les échanges avec l'assistant sont historisés par utilisateur (pour continuité de contexte) avec possibilité d'effacement par le fidèle à tout moment, conformément à la politique de confidentialité.

### **Modèle de données (entités clés)**

| **Entité de données** | **Champs clés**                                                                      |
|-----------------------|--------------------------------------------------------------------------------------|
| SessionAssistant      | id · utilisateur_id · date_debut                                                     |
| MessageAssistant      | id · session_id · role (utilisateur/assistant) · texte · sources_citees · horodatage |

### **Relations avec les autres modules**

- **• Module II —** peut renseigner sur les fidèles selon habilitation.

- **• Module XIII/XIX/XXIV —** sources de contenu interrogées.

- **• Transversal —** assiste les administrateurs dans la plupart des modules.

### **Écrans par édition**

| **Édition mobile (4 écrans)**                    | **Édition Windows (3 écrans)**          |
|--------------------------------------------------|-----------------------------------------|
| 1\. Fil de conversation avec l'assistant         | 1\. Console assistant (administrateurs) |
| 2\. Historique des échanges                      | 2\. Historique et audit des requêtes    |
| 3\. Recherche de verset via l'assistant          | 3\. Paramétrage des sources autorisées  |
| 4\. Suggestions contextuelles (aide à la saisie) |                                         |

> ***Cas d'usage —** un responsable de communication demande à l'assistant IA de lui rappeler la définition théologique d'un terme avant de rédiger une annonce ; l'assistant cite sa source dans la Bible numérique (XXIV) pour vérification.*

# **Module XVII — Communication**

*Axe : Axe numérique et pédagogique · Écrans mobile : 6 · Écrans Windows : 6*

### **Objectif fonctionnel**

Assurer la diffusion multicanale par SMS, WhatsApp, e-mail et notifications push, ainsi que la gestion du calendrier, des annonces et des invitations, en ciblant les fidèles selon leur ministère, leur groupe ou leur profession.

### **Règles de gestion**

- **RG-XVII-01 —** Un message ciblé définit une audience par combinaison de critères (nœud, groupe, ministère, profession) résolue dynamiquement au moment de l'envoi, jamais figée à la création si l'audience est déclarée « dynamique ».

- **RG-XVII-02 —** Le canal d'envoi (SMS, WhatsApp, e-mail, push) suit une politique de repli paramétrable (ex. WhatsApp puis SMS si échec) pour maximiser la délivrabilité dans les zones à connectivité limitée.

- **RG-XVII-03 —** Toute campagne de communication respecte le consentement déclaré du fidèle par canal (opt-in/opt-out), consultable et modifiable depuis sa fiche.

- **RG-XVII-04 —** Les envois sont mis en file d'attente et traités par lots pour respecter les quotas des opérateurs SMS/WhatsApp locaux, avec reprise automatique en cas d'échec temporaire.

- **RG-XVII-05 —** Les messages composés hors ligne sont conservés en brouillon local et transmis à la reconnexion, jamais perdus.

### **Modèle de données (entités clés)**

| **Entité de données** | **Champs clés**                                                                |
|-----------------------|--------------------------------------------------------------------------------|
| Message               | id · expediteur_id · canal · audience_criteres · contenu · date_envoi · statut |
| Annonce               | id · noeud_id · titre · corps · date_publication · date_expiration             |
| ConsentementCanal     | id · fidele_id · canal · opt_in                                                |

### **Relations avec les autres modules**

- **• Module II/III/V/VI —** critères de ciblage d'audience.

- **• Module XV —** relais des campagnes de soutien.

- **• Module XVIII —** notification des événements.

### **Écrans par édition**

| **Édition mobile (6 écrans)**             | **Édition Windows (6 écrans)**          |
|-------------------------------------------|-----------------------------------------|
| 1\. Boîte de réception des annonces       | 1\. Console d'envoi multicanal          |
| 2\. Calendrier des communications         | 2\. Segmentation d'audience avancée     |
| 3\. Composition d'un message ciblé        | 3\. Suivi des campagnes (statistiques)  |
| 4\. Suivi de délivrabilité                | 4\. Gestion des modèles de messages     |
| 5\. Préférences de consentement par canal | 5\. Gestion des quotas opérateurs       |
| 6\. Invitations reçues                    | 6\. File d'attente et reprise sur échec |

> ***Cas d'usage —** une annonce d'événement est envoyée par WhatsApp aux fidèles inscrits ; en cas d'échec de livraison, le système bascule automatiquement sur le canal SMS selon la politique de repli définie pour le nœud concerné.*

# **Module XVIII — Gestion des événements**

*Axe : Axe numérique et pédagogique · Écrans mobile : 7 · Écrans Windows : 5*

### **Objectif fonctionnel**

Planifier et suivre les cultes, baptêmes, mariages, présentations d'enfants, funérailles, conférences, séminaires, croisades, campagnes d'évangélisation et retraites spirituelles.

### **Règles de gestion**

- **RG-XVIII-01 —** Un événement possède un type fermé et extensible (référentiel module XXIII), un nœud organisateur, une ou plusieurs dates, un lieu, et un statut de cycle de vie (planifié, confirmé, en cours, clôturé, annulé).

- **RG-XVIII-02 —** Les événements à caractère de rite (baptême, mariage, présentation d'enfant, funérailles) référencent obligatoirement le ou les fidèles concernés et génèrent, à la clôture, un document archivé (module VIII) de type certificat correspondant.

- **RG-XVIII-03 —** Les inscriptions à un événement (conférence, séminaire, retraite) peuvent être plafonnées par une capacité maximale, avec liste d'attente automatique au-delà.

- **RG-XVIII-04 —** Un événement peut générer des offrandes spécifiques suivant les mêmes règles que le module XI, rattachées à l'événement plutôt qu'au culte.

- **RG-XVIII-05 —** La création d'un événement déclenche optionnellement une campagne de communication ciblée (module XVII) vers l'audience définie.

### **Modèle de données (entités clés)**

| **Entité de données** | **Champs clés**                                                                           |
|-----------------------|-------------------------------------------------------------------------------------------|
| Evenement             | id · noeud_id · type_evenement · titre · date_debut · date_fin · lieu · capacite · statut |
| InscriptionEvenement  | id · evenement_id · fidele_id · statut (inscrit/liste_attente)                            |
| RiteEvenement         | id · evenement_id · type_rite · fideles_concernes · document_archive_id                   |

### **Relations avec les autres modules**

- **• Module I —** rattaché au nœud organisateur.

- **• Module II —** fidèles concernés par les rites.

- **• Module VIII —** certificats de rites.

- **• Module XI —** offrandes liées à l'événement.

- **• Module XVII —** notification et invitation.

### **Écrans par édition**

| **Édition mobile (7 écrans)**               | **Édition Windows (5 écrans)**                 |
|---------------------------------------------|------------------------------------------------|
| 1\. Calendrier des événements               | 1\. Planification des événements (multi-nœuds) |
| 2\. Fiche événement                         | 2\. Gestion des rites et certificats           |
| 3\. Inscription à un événement              | 3\. Gestion des capacités et listes d'attente  |
| 4\. Gestion d'un rite (baptême, mariage...) | 4\. Rapports de participation                  |
| 5\. Liste d'attente                         | 5\. Budget et offrandes d'événement            |
| 6\. Présences à l'événement                 |                                                |
| 7\. Offrandes de l'événement                |                                                |

> ***Cas d'usage —** une église organise une campagne d'évangélisation ; les inscriptions sont plafonnées, une liste d'attente se constitue automatiquement, et les baptêmes qui en résultent génèrent chacun un certificat archivé (VIII) et une mise à jour du statut spirituel (II).*

# **Module XIX — École biblique**

*Axe : Axe numérique et pédagogique · Écrans mobile : 5 · Écrans Windows : 5*

### **Objectif fonctionnel**

Gérer les classes, enseignants, promotions, notes, diplômes et certificats de l'enseignement biblique structuré, rattachés aux fidèles inscrits.

### **Règles de gestion**

- **RG-XIX-01 —** Une promotion regroupe des classes successives sur un cursus pluriannuel ; un fidèle inscrit progresse de classe en classe selon des critères de passage paramétrables (note minimale, assiduité).

- **RG-XIX-02 —** Chaque classe est rattachée à un ou plusieurs enseignants désignés, eux-mêmes fidèles qualifiés (recoupement possible avec le module V pour la compétence pédagogique).

- **RG-XIX-03 —** Les notes et évaluations sont saisies par classe et par matière, agrégées en un bulletin par période, condition de délivrance du diplôme final.

- **RG-XIX-04 —** Le diplôme délivré en fin de cursus est archivé automatiquement dans le module VIII avec numérotation vérifiable, au même titre que les certificats du module XIV.

- **RG-XIX-05 —** Les contenus pédagogiques peuvent recouper ceux du centre de formation en ligne (XIV) par un lien de référence, évitant la duplication de supports identiques.

### **Modèle de données (entités clés)**

| **Entité de données** | **Champs clés**                                             |
|-----------------------|-------------------------------------------------------------|
| Promotion             | id · noeud_id · nom · annee_debut · duree_cursus            |
| Classe                | id · promotion_id · niveau · enseignant_id                  |
| InscriptionEcole      | id · fidele_id · classe_id · statut                         |
| Note                  | id · inscription_id · matiere · valeur · periode            |
| Diplome               | id · inscription_id · document_archive_id · date_delivrance |

### **Relations avec les autres modules**

- **• Module II —** fidèles inscrits.

- **• Module VIII —** archivage des diplômes.

- **• Module XIV —** recoupement pédagogique.

### **Écrans par édition**

| **Édition mobile (5 écrans)**        | **Édition Windows (5 écrans)**              |
|--------------------------------------|---------------------------------------------|
| 1\. Liste des promotions et classes  | 1\. Gestion des promotions et classes       |
| 2\. Fiche élève (notes, progression) | 2\. Saisie des notes en masse               |
| 3\. Saisie de présence en classe     | 3\. Génération des bulletins                |
| 4\. Consultation du bulletin         | 4\. Génération et vérification des diplômes |
| 5\. Mes diplômes                     | 5\. Rapports de réussite par promotion      |

> ***Cas d'usage —** un élève de l'école biblique termine son cursus de trois ans ; ses notes cumulées dépassent le seuil requis, son diplôme est généré et archivé (VIII), et son parcours pédagogique recoupe les formations déjà suivies sur le centre en ligne (XIV).*

# **Module XX — Gestion des biens**

*Axe : Axe financier et patrimonial · Écrans mobile : 6 · Écrans Windows : 6*

### **Objectif fonctionnel**

Tenir l'inventaire des terrains, bâtiments, véhicules, instruments de musique, caméras, sonorisation, ordinateurs, mobilier et stocks, rattachés à la structure organisationnelle et suivis financièrement.

### **Règles de gestion**

- **RG-XX-01 —** Chaque bien possède un identifiant d'inventaire unique, une catégorie fermée et extensible, un nœud de rattachement, un état (neuf, bon, à réparer, hors service, cédé) et une valeur d'acquisition et vénale estimée.

- **RG-XX-02 —** La sortie d'un bien du patrimoine (cession, don, mise au rebut) exige une validation d'un rôle habilité et génère un mouvement comptable de sortie dans le module XXI.

- **RG-XX-03 —** Un bien mobilisable (matériel de sonorisation, véhicule) peut faire l'objet d'une réservation datée pour un culte ou événement (XII, XVIII), empêchant les conflits de double réservation sur la même plage.

- **RG-XX-04 —** L'inventaire physique périodique (campagne de recensement) compare l'état déclaré au système avec un pointage terrain et signale les écarts pour investigation.

- **RG-XX-05 —** Les biens à gestion de stock (fournitures) suivent un seuil d'alerte de réapprovisionnement paramétrable par nœud.

### **Modèle de données (entités clés)**

| **Entité de données** | **Champs clés**                                                                                                   |
|-----------------------|-------------------------------------------------------------------------------------------------------------------|
| Bien                  | id_inventaire · categorie · noeud_id · designation · etat · valeur_acquisition · valeur_venale · date_acquisition |
| ReservationBien       | id · bien_id · objet_reservation (culte/evenement) · date_debut · date_fin                                        |
| MouvementStock        | id · bien_id · type (entrée/sortie) · quantite · date                                                             |

### **Relations avec les autres modules**

- **• Module I —** rattaché à un nœud.

- **• Module XII/XVIII —** mobilisation pour cultes et événements.

- **• Module XXI —** valorisation comptable.

### **Écrans par édition**

| **Édition mobile (6 écrans)**             | **Édition Windows (6 écrans)**                |
|-------------------------------------------|-----------------------------------------------|
| 1\. Inventaire des biens (liste)          | 1\. Registre patrimonial complet              |
| 2\. Fiche bien                            | 2\. Gestion des cessions et sorties           |
| 3\. Réservation d'un bien                 | 3\. Planning des réservations                 |
| 4\. Signalement d'état / panne            | 4\. Rapports de valorisation                  |
| 5\. Campagne d'inventaire physique (scan) | 5\. Gestion des campagnes d'inventaire        |
| 6\. Stocks et seuils d'alerte             | 6\. Gestion des stocks et réapprovisionnement |

> ***Cas d'usage —** un instrument de musique de l'église est réservé pour un culte extérieur (XII) puis pour un événement (XVIII) la même semaine ; le système empêche tout conflit de réservation sur la même plage horaire.*

# **Module XXI — Comptabilité**

*Axe : Axe financier et patrimonial · Écrans mobile : 4 · Écrans Windows : 8*

### **Objectif fonctionnel**

Tenir la caisse, la banque, le journal comptable, le grand livre, le budget, les rapports financiers, les états de trésorerie et l'historique complet des opérations, en consolidant les flux issus des finances et la valorisation des biens.

### **Règles de gestion**

- **RG-XXI-01 —** Chaque écriture comptable respecte la partie double (débit/crédit équilibrés) et référence un compte du plan comptable paramétrable et un nœud d'imputation.

- **RG-XXI-02 —** Les contributions validées (module XI) et les mouvements de biens (module XX) génèrent automatiquement leurs écritures comptables miroir, sans ressaisie manuelle.

- **RG-XXI-03 —** Une période comptable clôturée devient immuable ; toute correction postérieure exige une écriture de régularisation dans la période courante, jamais une réouverture silencieuse.

- **RG-XXI-04 —** Le budget prévisionnel par nœud et par exercice sert de référence de comparaison automatique aux dépenses engagées, avec alerte de dépassement paramétrable par seuil.

- **RG-XXI-05 —** Les états de trésorerie (caisse, banque) sont réconciliés périodiquement par rapprochement bancaire, avec écart signalé s'il subsiste après rapprochement automatique.

- **RG-XXI-06 —** La consolidation multi-niveaux suit strictement la hiérarchie organisationnelle (module I), sans double comptage entre un nœud et ses parents.

### **Modèle de données (entités clés)**

| **Entité de données** | **Champs clés**                                                                         |
|-----------------------|-----------------------------------------------------------------------------------------|
| PlanComptable         | id · code_compte · libelle · type (actif/passif/charge/produit)                         |
| EcritureComptable     | id · date · compte_id · debit · credit · noeud_id · piece_justificative_id · periode_id |
| PeriodeComptable      | id · exercice · date_debut · date_fin · statut (ouverte/clôturée)                       |
| Budget                | id · noeud_id · periode_id · compte_id · montant_prevu                                  |

### **Relations avec les autres modules**

- **• Module XI —** source des écritures de contributions.

- **• Module XX —** source des écritures de biens.

- **• Module I —** imputation par nœud.

- **• Module XXII —** alimentation du tableau de bord.

### **Écrans par édition**

| **Édition mobile (4 écrans)**              | **Édition Windows (8 écrans)**                   |
|--------------------------------------------|--------------------------------------------------|
| 1\. Consultation de caisse (solde du jour) | 1\. Journal comptable complet                    |
| 2\. Journal des écritures récentes         | 2\. Grand livre                                  |
| 3\. Rapport financier rapide               | 3\. Gestion du plan comptable                    |
| 4\. Justificatifs numérisés                | 4\. Rapprochement bancaire                       |
|                                            | 5\. Gestion budgétaire et alertes de dépassement |
|                                            | 6\. Clôture de période                           |
|                                            | 7\. États de trésorerie                          |
|                                            | 8\. Rapports financiers consolidés multi-nœuds   |

> ***Cas d'usage —** à la clôture du mois, le trésorier rapproche la caisse physique avec les écritures générées automatiquement par les contributions validées (XI) et les mouvements de biens (XX), avant de clôturer la période comptable.*

# **Module XXII — Tableau de bord**

*Axe : Pilier de gouvernance · Écrans mobile : 4 · Écrans Windows : 4*

### **Objectif fonctionnel**

Agréger en temps réel les statistiques de fidèles, nouveaux membres, baptêmes, mariages, décès, discipline, déplacements, offrandes, fréquentation, répartition des ministères, dons, professions, croissance, formations et médiathèque, pour chaque niveau de la hiérarchie.

### **Règles de gestion**

- **RG-XXII-01 —** Chaque indicateur affiché est calculé à partir de données validées uniquement (jamais de données « en attente » des modules XI, XII, etc.), garantissant la fiabilité du pilotage.

- **RG-XXII-02 —** L'utilisateur ne visualise que les indicateurs correspondant à son périmètre d'habilitation (nœud et rôle, module XXIII) — un pasteur local ne voit pas les données consolidées d'un autre district.

- **RG-XXII-03 —** Les indicateurs se recalculent à la demande (rafraîchissement) ou périodiquement en arrière-plan, avec horodatage de dernière mise à jour affiché pour éviter toute ambiguïté sur la fraîcheur des données.

- **RG-XXII-04 —** Un tableau de bord peut être personnalisé (widgets sélectionnés, période de comparaison) par utilisateur, sans affecter la configuration des autres utilisateurs.

- **RG-XXII-05 —** Les exports de tableau de bord (PDF, image) conservent le filtrage et le périmètre d'habilitation appliqués au moment de l'export.

### **Modèle de données (entités clés)**

| **Entité de données**    | **Champs clés**                                                  |
|--------------------------|------------------------------------------------------------------|
| IndicateurCalcule        | id · type_indicateur · noeud_id · periode · valeur · date_calcul |
| ConfigurationTableauBord | id · utilisateur_id · widgets_selectionnes · periode_comparaison |

### **Relations avec les autres modules**

- **• Transversal —** agrège les vingt-et-un autres modules opérationnels.

- **• Module I —** périmètre de consolidation.

- **• Module XXIII —** habilitations d'accès aux indicateurs.

### **Écrans par édition**

| **Édition mobile (4 écrans)**             | **Édition Windows (4 écrans)**                 |
|-------------------------------------------|------------------------------------------------|
| 1\. Tableau de bord synthétique (widgets) | 1\. Tableau de bord multi-niveaux complet      |
| 2\. Détail d'un indicateur                | 2\. Personnalisation des widgets               |
| 3\. Comparaison de périodes               | 3\. Comparaisons avancées et tendances         |
| 4\. Export rapide (PDF/image)             | 4\. Export et diffusion planifiée des rapports |

> ***Cas d'usage —** le responsable régional consulte en un coup d'œil la fréquentation, les nouvelles conversions et l'état des finances de son district, agrégés en temps réel depuis les données validées de toutes les églises locales rattachées.*

# **Module XXIII — Paramètres de l'application**

*Axe : Pilier de gouvernance · Écrans mobile : 5 · Écrans Windows : 9*

### **Objectif fonctionnel**

Configurer transversalement les informations de l'Église, l'identité visuelle, la hiérarchie, les départements, les fonctions, les groupes professionnels, les dons spirituels, les types d'offrandes, la catégorie confessionnelle des églises (Catholique / Autres), les zones géographiques, les langues, les rôles et permissions, les sauvegardes, l'IA et la médiathèque — module fondateur consommé par les vingt-trois autres.

### **Règles de gestion**

- **RG-XXIII-01 —** Toute modification d'un référentiel partagé (rôle, type d'offrande, don spirituel, zone géographique) est versionnée et propagée aux deux éditions (mobile et Windows) à la prochaine synchronisation, sans rupture des données déjà saisies avec l'ancienne valeur.

- **RG-XXIII-02 —** Le système de rôles et permissions est défini par croisement rôle × module × action (consulter, créer, modifier, valider, archiver, supprimer) et peut être affiné par niveau hiérarchique (module I).

- **RG-XXIII-03 —** La suppression d'une valeur de référentiel utilisée par des enregistrements existants est interdite ; seule sa désactivation (non proposée aux nouvelles saisies, conservée pour l'historique) est permise.

- **RG-XXIII-04 —** Les sauvegardes automatiques s'exécutent selon une politique paramétrable (fréquence, rétention, destination) et sont vérifiables par un test de restauration périodique tracé.

- **RG-XXIII-05 —** Le paramétrage multilingue permet de définir la ou les langues actives par nœud, avec langue de repli obligatoire si une traduction est manquante.

- **RG-XXIII-06 —** L'accès au module XXIII lui-même est réservé aux rôles d'administration les plus élevés, toute modification étant historisée avec auteur, date et valeur précédente.

### **Modèle de données (entités clés)**

| **Entité de données**   | **Champs clés**                                                             |
|-------------------------|-----------------------------------------------------------------------------|
| Role                    | id · libelle · niveau_hierarchique_applicable                               |
| Permission              | id · role_id · module · action · autorise                                   |
| Referentiel             | id · type_referentiel · code · libelle · statut (actif/désactivé) · version |
| ConfigurationSauvegarde | id · frequence · retention_jours · destination                              |
| ZoneGeographique        | id · libelle · niveau · parent_id                                           |

### **Relations avec les autres modules**

- **• Transversal —** fondateur, consommé par tous les autres modules.

- **• Module I —** types de nœuds et zones géographiques.

- **• Module XXII —** habilitations d'accès aux indicateurs.

### **Écrans par édition**

| **Édition mobile (5 écrans)**                                                   | **Édition Windows (9 écrans)**                                     |
|---------------------------------------------------------------------------------|--------------------------------------------------------------------|
| 1\. Profil et préférences utilisateur (complétion de la fiche fidèle, RG-II-10) | 1\. Informations de l'Église et identité visuelle                  |
| 2\. Choix de langue                                                             | 2\. Gestion de la hiérarchie et des types de nœuds                 |
| 3\. Notifications (paramètres)                                                  | 3\. Gestion des référentiels (dons, offrandes, professions, zones) |
| 4\. Consultation des rôles (lecture seule pour non-admin)                       | 4\. Gestion des rôles et permissions                               |
| 5\. Statut de synchronisation et sauvegarde                                     | 5\. Gestion multilingue                                            |
|                                                                                 | 6\. Politique de sauvegarde et restauration                        |
|                                                                                 | 7\. Paramétrage de l'assistant IA                                  |
|                                                                                 | 8\. Paramétrage de la médiathèque                                  |
|                                                                                 | 9\. Journal d'audit des modifications                              |

> ***Cas d'usage —** l'administrateur Global Service Groupe ajoute une nouvelle langue nationale à la plateforme ; elle devient immédiatement disponible dans le sélecteur de langue des deux éditions dès la synchronisation suivante.*

# **Module XXIV — Bible numérique et vie de l'Église**

*Axe : Axe numérique et pédagogique · Écrans mobile : 12 · Écrans Windows : 5*

### **Objectif fonctionnel**

Intégrer une Bible numérique structurée en Version / Livre / Chapitre / Verset, avec traductions libres de droits par défaut, recherche, comparaison de versions, favoris, surlignage, notes personnelles, historique, plans de lecture et lecture intégralement hors connexion.

### **Règles de gestion**

- **RG-XXIV-01 —** Les traductions libres de droits proposées par défaut sont la Louis Segond 1910, la Darby (1885) et la Crampon (**édition 1923**, seule édition disponible en données structurées ; l'édition 1904 n'est pas retenue). La Crampon remplace la King James Version initialement prévue : écart francophone et catholique assumé, la Crampon comprenant les livres deutérocanoniques. La Louis Segond 1910 est embarquée localement dès l'installation ; la Darby et la Crampon, également libres de droits, sont téléchargées à la demande (pour contenir la taille de l'application) puis lisibles intégralement hors connexion. Les traductions sous licence ou l'accès à une API biblique externe nécessitent une connexion et un contrôle de droits d'usage. La King James Version reste prévue pour le volet multilingue (version par défaut de la langue anglaise), à inscrire ici lors de sa construction. *(Amendement de reconstruction, 2026-09 : décision prise avant le sinistre et jamais reportée au Cahier.)*

- **RG-XXIV-02 —** Les notes personnelles, favoris et surlignages sont stockés localement en priorité (SQLite / Isar) et synchronisés au fidèle propriétaire dès qu'une connexion est disponible, jamais partagés par défaut avec d'autres utilisateurs.

- **RG-XXIV-03 —** Un plan de lecture définit une séquence de passages datés ; la progression est suivie individuellement et peut déclencher un rappel via le module XVII.

- **RG-XXIV-04 —** Une ressource de prédication (verset, notes, plan, chants associés) préparée par un pasteur peut être rattachée à un culte (XII) et versée automatiquement à la médiathèque (XIII) lors de sa publication.

- **RG-XXIV-05 —** La recherche par mot-clé s'exécute prioritairement sur l'index local hors ligne ; une recherche élargie (commentaires, ressources externes) nécessite une connexion et est clairement distinguée dans l'interface.

### **Modèle de données (entités clés)**

| **Entité de données** | **Champs clés**                                                                       |
|-----------------------|---------------------------------------------------------------------------------------|
| VersionBiblique       | id · code · nom · licence (libre/sous_licence)                                        |
| Verset                | id · version_id · livre · chapitre · numero_verset · texte                            |
| NotePersonnelle       | id · fidele_id · verset_id · texte · date                                             |
| PlanLecture           | id · fidele_id · nom · sequence_passages · progression                                |
| RessourcePredication  | id · auteur_id · culte_id · versets_lies · notes · plan_predication · chants_associes |

### **Relations avec les autres modules**

- **• Module XII —** préparation des prédications rattachées aux cultes.

- **• Module XIII —** archivage automatique des ressources publiées.

- **• Module XVI —** source textuelle interrogée par l'assistant IA.

- **• Module XIX —** recoupement des contenus pédagogiques.

### **Écrans par édition**

| **Édition mobile (12 écrans)**                       | **Édition Windows (5 écrans)**               |
|------------------------------------------------------|----------------------------------------------|
| 1\. Lecture biblique (Version/Livre/Chapitre/Verset) | 1\. Lecture biblique (vue bureau)            |
| 2\. Recherche par mot-clé                            | 2\. Recherche et comparaison avancées        |
| 3\. Comparaison de versions en parallèle             | 3\. Gestion des plans de lecture             |
| 4\. Favoris et surlignages                           | 4\. Préparation et archivage de prédications |
| 5\. Notes personnelles                               | 5\. Gestion des versions et licences         |
| 6\. Historique de lecture                            |                                              |
| 7\. Plans de lecture                                 |                                              |
| 8\. Préparation de prédication                       |                                              |
| 9\. Partage de verset                                |                                              |
| 10\. Mode sombre / lecture                           |                                              |
| 11\. Téléchargement de versions hors ligne           |                                              |
| 12\. Chants associés à un verset/prédication         |                                              |

> ***Cas d'usage —** un pasteur prépare sa prédication en comparant trois versions d'un même verset, y ajoute ses notes et un chant associé, puis publie l'ensemble après le culte (XII), automatiquement archivé dans la médiathèque (XIII).*

# **Chapitre 3 — Architecture technique globale : une base Flutter unique, offline-first**

Ecclesias 360 repose sur un code-source unique développé en Flutter et Dart, décliné en deux éditions natives — mobile (Android / iOS) et bureau (Windows) — partageant la même logique métier, les mêmes modèles de données et les mêmes règles de gestion décrites au chapitre 2. L'architecture est conçue « offline-first » dès sa fondation : chaque module fonctionne d'abord contre une base de données locale, la synchronisation réseau étant un mécanisme d'arrière-plan et non une condition d'usage.

## **3.1 Architecture logicielle en couches**

L'application applique une architecture en couches strictement séparées (Clean Architecture adaptée à Flutter), reproduite à l'identique dans les deux éditions pour garantir la cohérence des règles de gestion :

- **Couche présentation —** widgets Flutter organisés par module (un dossier par module I à XXIV, plus le socle transversal), gestion d'état via Riverpod (providers découplés, testables), navigation déclarative via GoRouter avec garde d'accès basée sur les permissions du module XXIII.

- **Couche domaine —** entités métier immuables et cas d'usage (use cases) qui implémentent chaque règle de gestion RG-xxx du chapitre 2 indépendamment de toute source de données ; c'est la couche testée unitairement en priorité.

- **Couche données —** dépôts (repositories) exposant une interface unique au domaine, masquant si la donnée provient du cache local ou de l'API distante ; chaque dépôt applique la politique de cache définie au chapitre 6.

- **Couche source de données locale —** base SQLite via Drift (ou Isar pour les collections documentaires telles que la Bible numérique et la médiathèque hors ligne), chiffrée au repos (chapitre 5).

- **Couche source de données distante —** client HTTP/REST ou GraphQL vers l'API centrale, avec file de synchronisation dédiée (chapitre 4).

## **3.2 Édition mobile**

L'édition mobile privilégie la rapidité de saisie, la consultation individuelle et les usages du terrain : présence aux cultes, saisie d'une offrande, consultation de la fiche d'un fidèle, écoute de la médiathèque, suivi d'une formation. Elle compte, module par module, un total de 212 écrans, socle transversal compris.

## **3.3 Édition Windows**

L'édition de bureau privilégie les vues denses, les tableaux, les exports et les traitements de masse propres à la gestion administrative et financière : grand livre comptable, tableaux de bord multi-niveaux, paramétrage des référentiels, gestion documentaire. Elle compte un total de 146 écrans.

## **3.4 Mutualisation et cohérence**

Le choix de Flutter pour les deux éditions garantit une cohérence totale des règles métier, des modèles de données et de la logique applicative entre le terrain et le bureau, tout en permettant à chaque édition d'adapter son ergonomie à son contexte d'usage. Les couches domaine et données décrites en 3.1 sont packagées dans un module Dart partagé (package interne \`ecclesias_core\`), importé par les deux applications ; seule la couche présentation diffère, ce qui réduit la dette technique et assure que toute évolution d'un référentiel du module XXIII se répercute instantanément sur les deux éditions.

# **Chapitre 4 — Gestion hors ligne (offline-first)**

Le mode hors ligne n'est pas une fonctionnalité annexe d'Ecclesias 360 : c'est une exigence de conception qui conditionne l'utilisabilité réelle de la plateforme dans la majorité des contextes d'implantation de Global Service Groupe, où la connectivité est intermittente, coûteuse ou simplement absente lors des cultes, croisades et visites pastorales en zone rurale. Chaque module du chapitre 2 doit être consultable et, pour ses opérations de saisie courantes, utilisable sans connexion active.

## **4.1 Principes directeurs**

- **RG-OFF-01 — Écriture locale d'abord —** toute création ou modification est d'abord persistée dans la base locale (Drift/SQLite) et considérée comme réussie du point de vue de l'utilisateur, indépendamment de l'état du réseau ; l'échec de synchronisation ne doit jamais annuler une saisie déjà effectuée sur l'appareil.

- **RG-OFF-02 — File de synchronisation persistante —** chaque opération hors ligne (créer, modifier, supprimer logiquement) est enregistrée comme un événement horodaté dans une file locale (outbox), rejouée dans l'ordre chronologique dès qu'une connexion redevient disponible.

- **RG-OFF-03 — Identifiants générés localement —** toute nouvelle entité créée hors ligne reçoit un identifiant local unique (UUID v4) qui devient l'identifiant définitif après synchronisation, évitant toute renumérotation qui casserait les relations déjà établies localement (ex. une contribution liée à un fidèle créé hors ligne le même jour).

- **RG-OFF-04 — Numérotations différées —** les séquences qui exigent une unicité globale strictement croissante (numéros d'archivage du module VIII, numéros de reçu financier) ne sont attribuées définitivement qu'à la synchronisation, l'appareil affichant en attendant un numéro provisoire clairement identifié comme tel.

- **RG-OFF-05 — Résolution de conflits déterministe —** en cas de modification concurrente du même enregistrement par deux appareils avant synchronisation, la règle par défaut est « dernière écriture validée gagne » sur les champs simples, complétée par une fusion de champs pour les entités à forte valeur (fiche fidèle, progression de formation) et par une file de résolution manuelle pour les cas sensibles (statut disciplinaire, validation financière), jamais de perte silencieuse de données.

- **RG-OFF-06 — Contenu consultable hors ligne par défaut —** les référentiels du module XXIII, la fiche des fidèles du nœud de l'utilisateur, la Bible numérique (XXIV), les contenus médiathèque téléchargés (XIII) et les leçons de formation en cours (XIV) sont mis en cache local systématiquement, sans action explicite de l'utilisateur.

- **RG-OFF-07 — Indicateur d'état transparent —** chaque écran affecté par la synchronisation affiche un indicateur d'état (synchronisé / en attente / conflit) et un compteur d'éléments en file, jamais une simple icône ambiguë de connectivité réseau générique.

- **RG-OFF-08 — Dégradation progressive plutôt que blocage —** lorsqu'une opération requiert impérativement une connexion (paiement en ligne module XIV/XV, appel à l'assistant IA cloud module XVI, envoi immédiat d'une communication module XVII), l'interface le signale explicitement et propose la mise en file d'attente plutôt qu'un simple message d'erreur bloquant.

## **4.2 Stratégie de synchronisation**

La synchronisation suit un modèle de réplication incrémentale fondé sur des marqueurs de version (vecteurs de synchronisation par module et par nœud), et non sur une réplication complète de la base à chaque cycle, afin de limiter la consommation de données — critère décisif dans le contexte de connectivité mobile africaine développé au chapitre 5.

- **Synchronisation montante (device → serveur) —** envoi par lots des événements de la file locale, avec accusé de réception atomique par lot ; en cas de coupure en cours d'envoi, le lot est rejoué sans double application grâce à un identifiant d'idempotence par événement.

- **Synchronisation descendante (serveur → device) —** téléchargement différentiel limité aux enregistrements modifiés depuis le dernier marqueur de version connu de l'appareil, filtré par le périmètre d'habilitation de l'utilisateur (nœud et rôle, module XXIII) pour ne jamais rapatrier des données hors permission.

- **Synchronisation planifiée et opportuniste —** déclenchement automatique sur détection de connectivité Wi-Fi, déclenchement manuel disponible à tout moment, et option de synchronisation planifiée en heures creuses pour économiser les forfaits de données mobiles limités.

- **Priorisation des flux —** en connexion limitée, la synchronisation priorise les données financières et administratives (modules XI, VIII, XXI) et les référentiels (XXIII) avant les contenus volumineux de la médiathèque (XIII), reportables à une connexion Wi-Fi.

## **4.3 Modules à criticité hors ligne renforcée**

| **Module**             | **Exigence hors ligne spécifique**                                                                                                  |
|------------------------|-------------------------------------------------------------------------------------------------------------------------------------|
| II — Fidèles           | Consultation et création complètes hors ligne ; la fiche du nœud de l'utilisateur est intégralement mise en cache.                  |
| XI — Finances          | Saisie d'offrande hors ligne intégrale avec statut « en attente » jusqu'à rapprochement, conformément à RG-XI-06.                   |
| XII — Cultes           | Programme, présence et publication saisissables sans connexion, y compris l'enregistrement audio local en attente de téléversement. |
| XXIV — Bible numérique | Lecture, recherche, notes et plans de lecture intégralement fonctionnels hors ligne (traductions libres embarquées).                |
| XIII — Médiathèque     | Contenus téléchargés à l'avance restent accessibles sans connexion, avec gestion locale de l'espace de stockage.                    |
| XVI — Assistant IA     | Mode dégradé sur base de connaissances embarquée (versets, définitions courantes) ; requêtes avancées mises en file d'attente.      |

# **Chapitre 5 — Intégration progressive africaine**

Ecclesias 360 est destiné à équiper des églises locales et des réseaux allant d'une petite assemblée rurale à une direction internationale. Cette amplitude impose une stratégie de déploiement par paliers, adaptée aux réalités africaines d'infrastructure réseau, de parc d'appareils, de moyens de paiement et de diversité linguistique, plutôt qu'un déploiement uniforme calibré sur les conditions les plus favorables.

## **5.1 Réalités de terrain adressées**

- **Connectivité intermittente et coûteuse —** réseaux 2G/3G dominants dans de nombreuses zones rurales, forfaits de données limités facturés au mégaoctet ; d'où la conception offline-first du chapitre 4 et la priorisation des flux de synchronisation.

- **Parc d'appareils hétérogène —** téléphones Android d'entrée de gamme à mémoire vive et stockage limités, largement majoritaires devant les appareils iOS ; l'application cible un minimum technique bas (Android 8+, 2 Go de RAM) et surveille la taille de son cache (chapitre 6).

- **Coût de la donnée —** chaque octet transféré a un coût réel pour l'utilisateur final ; les échanges réseau privilégient des formats compacts (JSON minifié, pagination stricte, compression des médias) et affichent une estimation de volume avant tout téléchargement volumineux (médiathèque, mise à jour applicative).

- **Moyens de paiement locaux —** les modules XI, XIV et XV intègrent nativement les passerelles de mobile money dominantes par pays (Mobile Money Orange, MTN Mobile Money, Moov Money, Wave, M-Pesa selon les territoires) en complément des cartes bancaires, avec une couche d'abstraction de paiement permettant l'ajout d'un nouvel opérateur sans modification du cœur applicatif.

- **Diversité linguistique —** au-delà du français et de l'anglais, le module XXIII permet l'ajout de langues nationales et locales par simple configuration de référentiel (RG-XXIII-05), sans nouvelle version applicative, avec langue de repli garantie.

- **Alimentation électrique irrégulière —** l'application minimise la consommation batterie (synchronisation groupée plutôt que continue, désactivation des animations lourdes en mode économie) et tolère les interruptions brutales grâce à l'écriture locale transactionnelle (chapitre 4).

## **5.2 Canaux de repli en absence de smartphone ou de connexion internet**

Pour les fidèles ne disposant pas de smartphone ou d'accès internet, la plateforme prévoit des canaux de repli garantissant que la valeur du système ne se limite pas aux utilisateurs les mieux équipés :

- **Communication (XVII) —** envoi et réception via SMS simple, sans nécessité de l'application, pour les annonces, rappels et notifications critiques.

- **Finances (XI) —** possibilité de saisie déléguée par un trésorier ou secrétaire équipé, au nom d'un fidèle contributeur non connecté, avec traçabilité de la saisie déléguée.

- **Bible numérique (XXIV) —** un mode audio léger (fichiers compressés) permet l'écoute de passages bibliques sur des appareils à très faible capacité de stockage.

## **5.3 Feuille de route de déploiement par paliers**

| **Palier**                            | **Portée fonctionnelle**                                        | **Cible de déploiement**                                          |
|---------------------------------------|-----------------------------------------------------------------|-------------------------------------------------------------------|
| Palier 0 — Socle                      | Modules I, II, XXIII, authentification, mode hors ligne de base | Église pilote, connectivité même faible                           |
| Palier 1 — Vie communautaire          | Modules III, IV, V, VI, VII, XII                                | Église locale en croissance                                       |
| Palier 2 — Administration et finances | Modules VIII, IX, X, XI, XX, XXI                                | Église structurée, premier niveau hiérarchique                    |
| Palier 3 — Numérique et pédagogie     | Modules XIII, XIV, XVI, XVII, XIX, XXIV                         | Zones à connectivité suffisante, contenu à forte valeur           |
| Palier 4 — Réseau et gouvernance      | Modules XV, XVIII, XXII, consolidation multi-niveaux            | Union, mission, réseau international, siège Global Service Groupe |

Ce séquencement n'est pas une contrainte technique imposée par le système — l'architecture modulaire du chapitre 1 permet d'activer les modules dans n'importe quel ordre par nœud organisationnel — mais une recommandation de mise en œuvre calibrée sur la maturité numérique et administrative croissante d'une église, du niveau local au niveau international.

# **Chapitre 6 — Sécurité**

La richesse relationnelle de la plateforme et la sensibilité de certaines données — spirituelles, disciplinaires, financières — imposent une architecture de sécurité rigoureuse, appliquée uniformément aux deux éditions et à l'ensemble des vingt-quatre modules.

## **6.1 Authentification et gestion des identités**

- **RG-SEC-01 — Authentification native Supabase Auth, sans mot de passe —** l'utilisateur choisit d'abord son identifiant (numéro de téléphone ou adresse e-mail), puis sa méthode de réception : SMS, WhatsApp ou code OTP email (branche téléphone), Magic Link ou code OTP email (branche e-mail), conformément au modèle d'authentification GSG (signInWithOtp / verifyOtp). Aucun mot de passe n'est stocké ni géré par Ecclesias 360. L'authentification à deux facteurs, portée nativement par ce même mécanisme OTP, est de fait systématique et non une brique séparée à activer pour les rôles d'administration (module XXIII).

- **RG-SEC-01bis — Identité fédérée via GSG ID —** le jeton de session Supabase déjà authentifiée est vérifié par GSG ID (signature JWKS du projet Supabase concerné, liste blanche stricte de projets autorisés) avant d'être relié à un profil GSG ID existant ou d'en créer un, conformément à KER-ID-02 et KER-ID-07 du GSG Platform Kernel. Un fidèle déjà connu d'un autre produit du portefeuille GSG n'a donc pas à ressaisir son identité dans Ecclesias 360 ; le numéro de téléphone est stocké et validé au format international E.164 dès la saisie côté client, avant tout appel à Supabase, conformément à KER-ID-06.

- **RG-SEC-02 — Jetons de session à durée limitée —** jetons d'accès courts (access token) émis par Supabase Auth, renouvelés par un jeton de rafraîchissement (refresh token) révocable à distance, permettant la déconnexion forcée d'un appareil perdu ou compromis.

- **RG-SEC-03 — Verrouillage local —** l'édition mobile propose un verrouillage applicatif par code PIN ou biométrie, indépendant de la session serveur, protégeant les données déjà synchronisées sur l'appareil en cas de perte physique.

## **6.2 Rôles, permissions et cloisonnement des données**

- RG-SEC-04 — Contrôle d'accès par croisement rôle × module × action, défini au module XXIII (RG-XXIII-02) et appliqué à la fois côté serveur (source de vérité) et côté client (expérience utilisateur cohérente), sans jamais faire reposer la sécurité sur le seul client.

- **RG-SEC-05 — Cloisonnement hiérarchique —** un utilisateur n'accède qu'aux données de son nœud organisationnel et, le cas échéant, des nœuds descendants, jamais des nœuds pairs ou parents sans habilitation explicite.

- **RG-SEC-06 — Confidentialité renforcée pour les modules II (données spirituelles sensibles), X (discipline) et XI/XV/XXI (finances) —** accès restreint aux rôles nommément habilités, journalisation systématique de toute consultation d'un dossier disciplinaire (étendue, par analogie, à toute ouverture d'une note pastorale privée — RG-II-11), séparation stricte des tâches saisie/validation en matière financière (RG-XI-02).

- **RG-SEC-06bis — Rôle « utilisateur simple » —** tout utilisateur non rattaché à une église comme fidèle enregistré accède uniquement au module XIII (médiathèque chrétienne) en lecture seule, sans aucun autre droit de consultation ou de saisie, jusqu'à ce qu'il complète une affiliation à une église pour devenir fidèle enregistré.

## **6.2bis Page d'accueil et personnalisation**

- **RG-SEC-06ter — Personnalisation de l'accueil —** la page d'accueil réunit, pour chaque utilisateur authentifié, les widgets essentiels de son activité (cultes à venir, actualités, contributions récentes, contenus recommandés). Sous ces widgets, un espace de préférences personnalisables (contenus favoris, thématiques suivies, canaux de notification) permet d'ajuster l'expérience proposée, selon un principe de personnalisation par widgets déjà appliqué au tableau de bord de pilotage (module XXII, RG-XXII-04) et repris ici au niveau de l'accueil général.

## **6.3 Protection des données**

- **RG-SEC-07 — Chiffrement en transit —** toutes les communications entre les applications et l'API centrale s'effectuent exclusivement en TLS 1.2 ou supérieur ; aucun échange en clair n'est toléré, y compris pour la synchronisation d'arrière-plan.

- **RG-SEC-08 — Chiffrement au repos —** la base locale (SQLite/Isar) est chiffrée sur l'appareil, et les sauvegardes serveur (module XXIII) sont chiffrées avec gestion des clés séparée de l'hébergement des données.

- **RG-SEC-09 — Minimisation et anonymisation —** les statistiques agrégées du tableau de bord (XXII) et de la médiathèque (XIII) ne doivent jamais permettre de ré-identifier un fidèle individuel à partir d'un comportement de consultation.

- **RG-SEC-10 — Conformité aux données personnelles —** consentement explicite recueilli et modifiable par le fidèle pour les canaux de communication (module XVII) et pour tout traitement de données à caractère personnel excédant la gestion administrative courante, avec droit d'accès et de rectification exercé depuis la fiche fidèle (II).

## **6.4 Traçabilité et intégrité**

- **RG-SEC-11 — Journal d'audit —** toute création, modification ou suppression logique d'un enregistrement sensible (fiche fidèle, dossier disciplinaire, écriture comptable, paramétrage du module XXIII) est journalisée avec auteur, date, ancienne et nouvelle valeur, journal lui-même non modifiable par les utilisateurs standards.

- **RG-SEC-12 — Intégrité des documents archivés —** tout document du module VIII est signé numériquement (empreinte cryptographique) au moment de son archivage, permettant de détecter toute altération ultérieure.

- **RG-SEC-13 — Sauvegardes vérifiées —** la politique de sauvegarde du module XXIII (RG-XXIII-04) inclut un test de restauration périodique tracé, condition de la valeur réelle d'une sauvegarde.

# **Chapitre 7 — Gestion des caches**

La gestion des caches arbitre, module par module, entre deux exigences en tension : la fraîcheur des données consultées et la disponibilité immédiate hors connexion. Ecclesias 360 applique une politique de cache différenciée, documentée ci-dessous, plutôt qu'une stratégie unique appliquée uniformément à des données de nature très différente.

## **7.1 Niveaux de cache**

- **Cache mémoire (niveau 1) —** données de la session en cours (profil utilisateur, permissions résolues, filtres actifs d'un écran), volatile, réinitialisé à la fermeture de l'application, priorité à la vitesse d'affichage.

- **Cache local persistant (niveau 2) —** base SQLite/Isar chiffrée, contenant les données métier des modules consultés récemment ou explicitement épinglés (référentiels, fiche du nœud de l'utilisateur, contenus médiathèque téléchargés), survit aux redémarrages de l'application.

- **Cache serveur (niveau 3) —** couche de cache applicatif côté API (type Redis) pour les agrégations coûteuses du tableau de bord (XXII) et les recherches fréquentes de la médiathèque (XIII), invalidée événementiellement à chaque écriture affectant l'agrégat concerné.

## **7.2 Politiques d'invalidation par type de donnée**

| **Type de donnée**                    | **Politique de cache**                                                                                                                                                                                                       |
|---------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Référentiels (module XXIII)           | Cache persistant de longue durée, invalidation par version (RG-XXIII-01) : le client compare son numéro de version local au numéro serveur et ne retélécharge qu'en cas d'écart.                                             |
| Fiche fidèle (module II)              | Cache persistant avec synchronisation incrémentale ; invalidation immédiate sur modification par l'utilisateur lui-même, invalidation différée (prochaine synchronisation) pour les modifications d'un tiers.                |
| Indicateurs du tableau de bord (XXII) | Cache serveur à durée de vie courte (quelques minutes) reconstruit à la demande, avec horodatage de fraîcheur affiché (RG-XXII-03) plutôt qu'un recalcul systématique coûteux.                                               |
| Contenus médiathèque (XIII)           | Cache persistant volumineux à gestion explicite par l'utilisateur (téléchargement / suppression manuelle), purge automatique des contenus les plus anciens non favoris en cas de saturation de l'espace disque (RG-XIII-02). |
| Bible numérique (XXIV)                | Cache persistant permanent pour les traductions libres de droits, embarqué dès l'installation, jamais purgé automatiquement.                                                                                                 |
| File de synchronisation (outbox)      | Cache persistant transactionnel, jamais purgé avant confirmation serveur de bonne application, conformément au chapitre 4.                                                                                                   |

## **7.3 Cohérence entre cache et source de vérité**

- **Le cache n'est jamais la source de vérité —** en cas de conflit détecté entre une valeur en cache et la valeur serveur reçue à la synchronisation, la résolution suit les règles RG-OFF-05 du chapitre 4, jamais un écrasement silencieux et non tracé.

- Chaque dépôt (repository, couche données du chapitre 3) applique la politique de cache de son domaine et expose un indicateur de fraîcheur consommé par l'interface, condition du principe de transparence RG-OFF-07.

- La taille totale du cache local est plafonnée par configuration (module XXIII, adaptable par contexte de déploiement africain, chapitre 5) avec alerte à l'utilisateur avant purge automatique des éléments les plus anciens non protégés.

# **Chapitre 8 — Programmation : pile technologique, standards et organisation du code**

Ce chapitre fixe les choix technologiques et les conventions de programmation communes aux deux éditions, condition de la cohérence décrite au chapitre 3 et de la vélocité de l'équipe de développement sur la durée du projet.

## **8.1 Pile technologique**

| **Couche**                   | **Choix technologique**                                                                                                                                           | **Justification**                                                                                                                                                                        |
|------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Client mobile et bureau      | Flutter (Dart), une seule base de code                                                                                                                            | Cohérence totale mobile/Windows, écosystème mature, performance native.                                                                                                                  |
| Gestion d'état               | Riverpod                                                                                                                                                          | Providers testables, découplage strict présentation/domaine, compatible offline-first.                                                                                                   |
| Navigation                   | GoRouter                                                                                                                                                          | Navigation déclarative, gardes d'accès basées sur les permissions (module XXIII).                                                                                                        |
| Base locale                  | Drift (SQLite) + Isar pour collections documentaires                                                                                                              | Requêtes typées, chiffrement au repos, performant sur appareils d'entrée de gamme.                                                                                                       |
| API centrale                 | REST/JSON, versionnée, ou GraphQL pour les agrégations complexes du tableau de bord                                                                               | Formats compacts adaptés au contexte de connectivité limitée (chapitre 5).                                                                                                               |
| Backend applicatif           | Architecture par services autour de Supabase (PostgreSQL), backend standard du portefeuille GSG (KER-DEC-01), file de messages pour la synchronisation asynchrone | Cohérence transactionnelle, scalabilité horizontale, consolidation multi-niveaux (module I), alignement natif sur le reste du portefeuille GSG.                                          |
| Identité et authentification | Supabase Auth (signInWithOtp/verifyOtp — SMS, WhatsApp via Twilio, Magic Link, code OTP email), jeton vérifié par GSG ID                                          | Modèle d'authentification GSG standard (chapitre 6.1), identité fédérée avec les autres produits du portefeuille sans mot de passe ni backend d'authentification propre à Ecclesias 360. |
| Cache serveur                | Redis                                                                                                                                                             | Invalidation événementielle des agrégats coûteux (module XXII).                                                                                                                          |
| Paiement                     | Couche d'abstraction multi-fournisseurs (mobile money régionaux, cartes)                                                                                          | Ajout d'un opérateur de paiement sans modification du cœur applicatif (chapitre 5).                                                                                                      |
| Notifications                | Service multicanal (push, SMS, WhatsApp Business API, e-mail) avec politique de repli                                                                             | Délivrabilité maximale en connectivité limitée (module XVII, RG-XVII-02).                                                                                                                |
| Observabilité                | Journalisation centralisée, suivi d'erreurs, tableaux de bord d'exploitation                                                                                      | Diagnostic à distance sans accès physique aux appareils de terrain.                                                                                                                      |

## **8.2 Organisation du code partagé**

Le code est organisé en paquets Dart internes reflétant l'architecture en couches du chapitre 3, avec un découpage par module fonctionnel plutôt que par type technique, pour que chaque équipe puisse travailler sur un module (I à XXIV) de façon quasi indépendante :

- **\`ecclesias_core\` —** entités de domaine, cas d'usage, interfaces de dépôts — partagé à l'identique par les deux éditions, sans aucune dépendance à Flutter.

- **\`ecclesias_data\` —** implémentations des dépôts, sources de données locale et distante, logique de synchronisation et de cache (chapitres 4 et 6).

- **\`ecclesias_mobile\` et \`ecclesias_desktop\` —** uniquement la couche présentation (écrans, widgets), consommant \`ecclesias_core\` et \`ecclesias_data\`.

- Un dossier par module (\`module_02_fideles/\`, \`module_11_finances/\`, …) à l'intérieur de chaque paquet, garantissant que la structure du code reflète directement la structure fonctionnelle du chapitre 2.

## **8.3 Standards de développement**

- **Convention de nommage —** chaque règle de gestion implémentée est référencée dans le code par son identifiant RG-xxx (commentaire ou nom de test), assurant la traçabilité entre le cahier de conception et le code source.

- **Tests —** couverture obligatoire de la couche domaine (cas d'usage) par des tests unitaires ; tests d'intégration pour la synchronisation et la résolution de conflits (chapitre 4) ; tests de bout en bout sur les parcours critiques (saisie d'offrande hors ligne, validation disciplinaire, consolidation multi-niveaux).

- **Revue de code —** toute évolution touchant un référentiel du module XXIII ou une règle de gestion financière (module XI, XXI) exige une double revue, conformément à l'exigence de séparation des tâches du chapitre 6.

- **Internationalisation —** tous les libellés d'interface passent par le système de traduction du module XXIII dès l'écriture initiale, aucune chaîne de caractères codée en dur, condition de l'intégration progressive africaine (chapitre 5).

- **Accessibilité et sobriété —** composants d'interface testés sur des résolutions et densités d'écran basses, mode économie de données activable globalement, respect des contrastes pour une lisibilité en plein soleil (usage extérieur fréquent lors des cultes et événements).

## **8.4 Intégration et livraison continues**

- **Pipeline automatisé —** compilation, exécution des tests, analyse statique et packaging des deux éditions à chaque intégration sur la branche principale.

- **Déploiement progressif —** diffusion des nouvelles versions mobiles par vagues (pourcentage croissant d'utilisateurs) afin de détecter une régression avant diffusion complète, particulièrement critique compte tenu de l'hétérogénéité du parc d'appareils décrite au chapitre 5.

- **Compatibilité ascendante des synchronisations —** toute évolution du schéma de données côté serveur reste compatible avec les versions clientes antérieures encore en circulation sur le terrain, le renouvellement du parc d'appareils n'étant pas instantané.

## **8.5 Intégration au GSG Platform Kernel**

Cette section applique le gabarit standard fixé à la section 19 du cahier GSG Platform Kernel (v3.0). Elle documente, sous la forme systématique retenue pour l'ensemble des produits du portefeuille, la relation d'Ecclesias 360 au socle transversal Global Service Groupe (identité, référentiel, événements, audit).

- **Briques du noyau consommées —** GSG ID (oui — authentification fédérée sans mot de passe, chapitre 6.1) ; Org Registry (oui — le nœud racine de la hiérarchie du module I, pour toute organisation cliente abonnée, porte une référence gsg_org_id) ; GSG Referential (oui — pays, devise, langue, voir cartographie ci-dessous) ; Referential Engine (non applicable en l'état, voir ci-dessous) ; Bus d'événements (non à ce stade, voir événements candidats ci-dessous) ; Audit (oui — la journalisation centralisée du noyau, section 12 du cahier Kernel, sert de socle à la traçabilité déjà exigée par RG-SEC-06 pour les dossiers disciplinaires et les mouvements financiers) ; Billing Core (non, par défaut — Ecclesias 360 conserve son propre modèle de facturation, chapitre 10, conformément à la section 13 du cahier Kernel qui laisse cette brique différée) ; Design System (non, par défaut, brique cosmétique non généralisée à ce stade — section 14 du cahier Kernel).

- **Cartographie des champs hérités du référentiel —** Contribution.devise_id et FactureAbonnement.devise_id (chapitre 2, module XI ; chapitre 10.5) référencent le référentiel devise du noyau, plutôt qu'un champ devise en texte libre ; l'adresse d'un nœud organisationnel du module I référence pays_id, unite_administrative_id et ville_id du GSG Referential plutôt que d'être saisie en texte libre ; ce champ d'adresse est distinct du référentiel interne des zones géographiques (zone pastorale, module XXIII), qui n'est pas remplacé par le GSG Referential ; le nœud racine d'une organisation cliente (réseau, union ou mission abonnée) référence gsg_org_id vers l'Org Registry ; les préférences linguistiques du module XXIII référencent langue_id.

- **Instanciation du Referential Engine —** non applicable en l'état. Les référentiels internes d'Ecclesias 360 — dons spirituels du module IV, catégories de métiers du module V, natures de faute du module X, **zones géographiques (zones pastorales internes : zone, district, secteur...) du module XXIII** — restent portés en propre par le module XXIII : ce sont des taxonomies métier fixes, communes à l'ensemble des déploiements, et non des variations structurelles par pays au sens du méta-modèle générique du noyau (chapitre 8 du cahier Kernel). Cette position sera réévaluée si une variation par pays de l'un de ces référentiels s'avère nécessaire.

- **Événements publiés et consommés —** Ecclesias 360 ne publie ni ne consomme, à ce stade, d'événement du bus inter-produits. Deux candidats sont identifiés pour une intégration ultérieure : fidele.affilie (publié vers GSG ID, pour recouper un fidèle déjà connu d'un autre produit du portefeuille) et contribution.enregistree (candidat à une consommation par un futur module financier transversal du portefeuille).

- **État au moment de la rédaction —** Ecclesias 360 n'a pas encore été entamé en développement : il est donc conçu nativement avec le noyau dès l'origine, conformément à KER-VIS-06, sans document de migration séparé. Cette section 8.5 constitue la référence unique de la relation d'Ecclesias 360 au GSG Platform Kernel v3.0 et prime sur toute description antérieure du backend ou de l'authentification figurant ailleurs dans ce cahier.

# **Chapitre 9 — Récapitulatif quantitatif des écrans**

Le tableau ci-dessous consolide, pour chacun des vingt-quatre modules et pour le socle transversal (authentification, onboarding, profil, notifications, aide, mode hors ligne, recherche globale, page d'accueil et préférences), le nombre d'écrans nommés requis dans l'édition mobile et dans l'édition Windows, tels que détaillés module par module au chapitre 2.

| **N°** | **Module**                                                                                                                                  | **Écrans mobile** | **Écrans Windows** |
|--------|---------------------------------------------------------------------------------------------------------------------------------------------|-------------------|--------------------|
| I      | Gestion de l'organisation ecclésiastique                                                                                                    | 9                 | 7                  |
| II     | Gestion complète des fidèles                                                                                                                | 14                | 10                 |
| III    | Gestion des ministères et départements                                                                                                      | 9                 | 6                  |
| IV     | Gestion des dons spirituels                                                                                                                 | 6                 | 4                  |
| V      | Gestion des groupes professionnels                                                                                                          | 5                 | 3                  |
| VI     | Gestion des groupes de l'Église                                                                                                             | 5                 | 3                  |
| VII    | Gestion du comité local                                                                                                                     | 7                 | 6                  |
| VIII   | Gestion administrative (archivage documentaire)                                                                                             | 9                 | 7                  |
| IX     | Gestion des déplacements                                                                                                                    | 6                 | 4                  |
| X      | Gestion disciplinaire                                                                                                                       | 6                 | 5                  |
| XI     | Gestion financière                                                                                                                          | 8                 | 10                 |
| XII    | Gestion des cultes                                                                                                                          | 9                 | 7                  |
| XIII   | Médiathèque chrétienne (Global Service Groupe)                                                                                              | 11                | 7                  |
| XIV    | Centre de formation en ligne                                                                                                                | 11                | 8                  |
| XV     | Espace de soutien à Global Service Groupe                                                                                                   | 6                 | 4                  |
| XVI    | Intelligence artificielle (assistant biblique et ecclésiastique)                                                                            | 4                 | 3                  |
| XVII   | Communication                                                                                                                               | 6                 | 6                  |
| XVIII  | Gestion des événements                                                                                                                      | 7                 | 5                  |
| XIX    | École biblique                                                                                                                              | 5                 | 5                  |
| XX     | Gestion des biens                                                                                                                           | 6                 | 6                  |
| XXI    | Comptabilité                                                                                                                                | 4                 | 8                  |
| XXII   | Tableau de bord                                                                                                                             | 4                 | 4                  |
| XXIII  | Paramètres de l'application                                                                                                                 | 5                 | 9                  |
| XXIV   | Bible numérique et vie de l'Église                                                                                                          | 12                | 5                  |
| —      | Socle transversal (authentification, onboarding, profil, notifications, aide, hors ligne, recherche globale, page d'accueil et préférences) | 15                | 8                  |
|        | TOTAL GÉNÉRAL                                                                                                                               | 189               | 150                |

Ecclesias 360 représente ainsi 339 écrans à concevoir et développer sur une base Flutter unique : 189 pour l'édition mobile et 150 pour l'édition Windows, répartis sur vingt-quatre modules fonctionnels et un socle transversal, avec pour chacun des règles de gestion, un modèle de données et des relations inter-modules intégralement documentés au chapitre 2.

# **Chapitre 10 — Modèle économique et monétisation**

Ecclesias 360 est développé et opéré par Global Service Groupe : au-delà de sa vocation à servir la gouvernance ecclésiastique, la plateforme doit financer durablement son propre développement, son hébergement, son support et l'accompagnement des églises qui l'adoptent. Ce chapitre définit les sources de revenus retenues, leur logique tarifaire, les règles de gestion qui les encadrent et leur intégration précise dans l'architecture modulaire des chapitres précédents — aucune source de revenu n'existe isolément : chacune s'appuie sur un ou plusieurs modules déjà spécifiés.

## **10.1 Principes directeurs du modèle économique**

- **RG-ECO-01 — Gratuité du socle communautaire —** les fonctions essentielles à la vie spirituelle et administrative d'une église locale (modules I, II, III, IV, VI, VII, XII, XXIV) restent accessibles gratuitement à toute église, quelle que soit sa taille, afin de ne jamais subordonner la gouvernance pastorale à un paiement.

- **RG-ECO-02 — Monétisation par la valeur ajoutée, non par la donnée —** aucune donnée spirituelle, disciplinaire ou financière d'un fidèle n'est vendue, louée ou exploitée à des fins commerciales ; les revenus proviennent exclusivement de services rendus (abonnement, transaction, formation, accompagnement), jamais de la monétisation indirecte des données personnelles.

- **RG-ECO-03 — Tarification proportionnée à la taille et au niveau hiérarchique —** le montant dû par un nœud organisationnel (module I) est fonction de son niveau (église locale, district, union, réseau…) et de son nombre de fidèles actifs, jamais d'un tarif unique indifférencié qui pénaliserait les petites assemblées.

- **RG-ECO-04 — Transparence et traçabilité —** chaque flux de revenu (abonnement, commission, vente) génère une écriture dans la comptabilité de Global Service Groupe (module XXI, périmètre siège), consultable par les organes de gouvernance de Global Service Groupe.

- **RG-ECO-05 — Aucune dégradation punitive —** à l'expiration d'un abonnement payant, l'église repasse au socle gratuit (RG-ECO-01) sans suppression de données ni interruption de la gestion des fidèles ; seules les fonctionnalités avancées deviennent inaccessibles, avec préavis notifié (module XVII).

## **10.2 Sources de revenus**

| **Source de revenu**                             | **Modules mobilisés**                                                                | **Logique tarifaire**                                                                                                                                                                                                             |
|--------------------------------------------------|--------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Abonnement plateforme par palier                 | XXIII (référentiel d'abonnement), XXII (fonctionnalités avancées du tableau de bord) | Quatre formules (10.3) facturées mensuellement ou annuellement par nœud, selon niveau hiérarchique et nombre de fidèles actifs.                                                                                                   |
| Commission sur transactions financières          | XI, XV, XXI                                                                          | Pourcentage faible et plafonné prélevé sur les paiements traités par passerelle numérique (mobile money, carte) ; aucune commission sur les offrandes saisies manuellement hors ligne ou en espèces.                              |
| Formations et certifications payantes            | XIV, VIII                                                                            | Part reversée à Global Service Groupe sur chaque formation payante publiée sur le centre de formation en ligne, le solde revenant à l'église ou à l'intervenant éditeur du contenu.                                               |
| Médiathèque premium                              | XIII                                                                                 | Contenus exclusifs (production éditoriale Global Service Groupe) accessibles par abonnement médiathèque distinct de l'abonnement plateforme, ou inclus dans les paliers Croissance et supérieurs.                                 |
| Services professionnels d'accompagnement         | Transversal, VIII (documentation), XXIII (paramétrage)                               | Prestations facturées à l'acte : migration de données depuis un système existant, formation des équipes, paramétrage initial d'un réseau multi-niveaux, développement de connecteurs spécifiques.                                 |
| Licence réseau et marque blanche                 | Transversal                                                                          | Accord de licence pour les réseaux ecclésiastiques et dénominations tierces souhaitant déployer la plateforme sous leur propre identité visuelle, avec redevance annuelle et part sur les abonnements de leurs églises affiliées. |
| Campagnes de soutien et partenariat missionnaire | XV                                                                                   | Dons volontaires des fidèles et partenaires, sans commission prélevée par Global Service Groupe au-delà des frais réels de la passerelle de paiement, pour préserver la confiance de l'assemblée.                                 |

## **10.3 Paliers d'abonnement**

L'abonnement plateforme est le socle du modèle économique récurrent. Il est structuré en quatre paliers cumulatifs, alignés sur les niveaux de la hiérarchie organisationnelle (module I) et sur la feuille de route de déploiement progressif du chapitre 5, afin qu'une église grandisse dans l'usage de la plateforme au même rythme qu'elle grandit dans son organisation.

| **Palier**            | **Public visé**                                                                              | **Fonctionnalités incluses au-delà du socle gratuit**                                                                 |
|-----------------------|----------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| Essentiel (gratuit)   | Église locale naissante                                                                      | Modules I, II, III, IV, VI, VII, XII, XXIV en intégralité ; tableau de bord de base (XXII) ; mode hors ligne complet. |
| Croissance            | Église locale structurée                                                                     | Ajoute VIII, IX, X, XI, XX, XXI ; médiathèque standard (XIII) ; communication multicanale (XVII) avec quotas étendus. |
| Réseau                | District, zone, région, union, mission                                                       | Ajoute XIV, XVI, XVIII, XIX ; consolidation multi-niveaux complète (XXII) ; support prioritaire ; API de connecteurs. |
| International / Siège | Réseau d'Églises, direction nationale, direction internationale, siège Global Service Groupe | Ajoute XV ; gouvernance multi-organisations ; marque blanche partielle ; interlocuteur dédié Global Service Groupe.   |

## **10.4 Règles de gestion de la facturation et des paiements**

- **RG-ECO-06 — Facturation au nœud, consolidation possible —** chaque nœud organisationnel peut être facturé individuellement, ou un nœud parent peut choisir de prendre en charge l'abonnement de ses nœuds descendants (facturation consolidée), option paramétrée dans le module XXIII sans dupliquer la logique de consolidation déjà décrite pour les statistiques et les finances.

- **RG-ECO-07 — Paiement multi-fournisseur —** le règlement des abonnements et commissions s'appuie sur la même couche d'abstraction de paiement que les modules XI, XIV et XV (chapitre 5), incluant les opérateurs de mobile money régionaux, condition indispensable à un modèle économique réellement viable en contexte africain.

- **RG-ECO-08 — Essai et transition sans rupture —** le passage d'un palier à un autre est immédiat et réversible ; un essai gratuit du palier Croissance est proposé une fois par nœud, sans engagement de paiement automatique à l'issue de la période d'essai.

- **RG-ECO-09 — Défaut de paiement géré avec préavis —** un abonnement impayé bascule automatiquement, après relances via le module XVII et un délai de grâce paramétrable, au palier Essentiel plutôt qu'à une suspension brutale du service, conformément au principe RG-ECO-05.

- **RG-ECO-10 — Séparation des flux financiers —** les revenus de Global Service Groupe (abonnements, commissions, licences) transitent par une comptabilité dédiée au nœud siège (module XXI), strictement distincte des comptes financiers de chaque église locale, sans jamais mélanger les offrandes des fidèles avec les recettes d'exploitation de la plateforme.

## **10.5 Entités de données du modèle économique**

| **Entité**            | **Champs clés**                                                                                                                |
|-----------------------|--------------------------------------------------------------------------------------------------------------------------------|
| AbonnementNoeud       | id · noeud_id · palier · date_debut · date_fin · statut (actif/essai/impayé/résilié) · mode_facturation (individuel/consolidé) |
| FactureAbonnement     | id · abonnement_id · periode · montant · devise_id (GSG Referential) · statut_paiement · date_echeance                         |
| CommissionTransaction | id · transaction_source (contribution_id/inscription_id) · module_origine · taux_applique · montant_preleve                    |
| LicenceReseau         | id · organisation_tierce · date_debut · redevance_annuelle · pourcentage_reversement                                           |

## **10.6 Relations avec les modules existants**

- **Module XXIII (Paramètres) —** porte le référentiel des paliers, des tarifs et des taux de commission, consommé par ce chapitre au même titre que les autres référentiels de la plateforme.

- **Modules XI, XIV, XV (Finances, Formations, Soutien Global Service Groupe) —** sources des transactions sur lesquelles une commission peut s'appliquer (RG-ECO-07).

- **Module XXI (Comptabilité) —** reçoit les écritures de revenus de Global Service Groupe selon la même mécanique de génération automatique que les écritures d'offrandes et de biens (RG-XXI-02).

- **Module XVII (Communication) —** porte les notifications de facturation, de relance et de changement de palier.

- **Module XXII (Tableau de bord) —** le palier d'abonnement conditionne l'accès à certains indicateurs et niveaux de consolidation, sans jamais restreindre l'accès aux données déjà saisies par l'église.

> ***Cas d'usage —** un district passe du palier Essentiel au palier Réseau pour bénéficier de la consolidation multi-niveaux et du centre de formation en ligne ; le changement est immédiat, facturé au prorata, réglé par mobile money, et une écriture correspondante apparaît automatiquement dans la comptabilité du siège Global Service Groupe (XXI) sans jamais transiter par les comptes de l'église elle-même.*

# **Résumé détaillé**

Ecclesias 360 est une plateforme intégrée de gestion ecclésiastique développée en Flutter, déclinée en une édition mobile (Android/iOS) et une édition de bureau (Windows) partageant un cœur logiciel unique. Le présent cahier de conception documente, module par module, une architecture strictement modulaire de vingt-quatre domaines de gestion organisés en sept axes fonctionnels autour de trois entités pivots : la structure organisationnelle hiérarchique (module I), le fidèle (module II), et le flux financier (modules XI, XXI).

## **Ce que ce document livre**

- Une cartographie complète des relations inter-modules (chapitre 1), garantissant qu'aucune donnée n'est saisie deux fois et qu'aucun module ne fonctionne en silo.

- **Pour chacun des vingt-quatre modules (chapitre 2) —** un objectif fonctionnel, entre quatre et neuf règles de gestion numérotées et directement traduisibles en cas d'usage testables, un modèle de données synthétique, les relations explicites avec les autres modules, et l'inventaire nommé de ses écrans mobile et Windows.

- Une architecture technique en couches (chapitre 3), offline-first par conception, packagée en modules Dart partagés entre les deux éditions.

- **Une politique de gestion hors ligne complète (chapitre 4) —** écriture locale prioritaire, file de synchronisation persistante, résolution de conflits déterministe, priorisation des flux réseau.

- **Une stratégie d'intégration progressive africaine (chapitre 5) —** adaptation aux réalités de connectivité, de parc d'appareils, de paiement mobile et de diversité linguistique du continent, avec feuille de route de déploiement en quatre paliers fonctionnels.

- Une architecture de sécurité (chapitre 6) couvrant authentification, contrôle d'accès par rôle, chiffrement en transit et au repos, traçabilité et intégrité documentaire.

- Une politique de gestion des caches à trois niveaux (chapitre 7), différenciée par type de donnée, arbitrant fraîcheur et disponibilité hors connexion.

- Une pile technologique et des standards de programmation (chapitre 8) garantissant la cohérence du code entre les deux éditions et la traçabilité entre règles de gestion et code source.

- **Un récapitulatif quantitatif (chapitre 9) —** 24 modules fonctionnels et un socle transversal, dont le détail complet figure dans le tableau du chapitre 9.

- **Un modèle économique complet (chapitre 10) —** sources de revenus de Global Service Groupe (abonnements par palier, commissions de transaction, formations payantes, médiathèque premium, services professionnels, licence réseau), règles de gestion RG-ECO numérotées, et intégration précise dans les modules XI, XIV, XV, XVII, XXI, XXII et XXIII déjà spécifiés — sans jamais monétiser les données personnelles ni restreindre le socle communautaire gratuit.

## **Principes de conception à retenir**

- **Source unique de vérité —** chaque information n'existe qu'une fois, dans le module qui en est propriétaire fonctionnel.

- Fonctionnement garanti hors connexion pour les opérations critiques de terrain (fiche fidèle, offrande, présence au culte, lecture biblique).

- Séparation stricte des tâches sur les données financières et disciplinaires (saisie ≠ validation ≠ consultation).

- Consolidation multi-niveaux sans re-saisie, de l'église locale au siège de Global Service Groupe.

- Architecture pensée pour un déploiement progressif, module par module et palier par palier, plutôt qu'un tout-ou-rien.

## **Pour qui**

Ce document s'adresse conjointement aux décideurs de Global Service Groupe, qui y trouvent la vision d'ensemble et la feuille de route ; aux équipes de développement, qui y trouvent les règles de gestion, le modèle de données et les standards techniques nécessaires pour coder sans ambiguïté ; et aux responsables ecclésiastiques, qui y retrouvent la traduction fidèle de leurs pratiques de gouvernance, de finances et de vie communautaire dans un système numérique cohérent.

# **Annexes**

## **Annexe A — Glossaire**

| **Terme**                        | **Définition**                                                                                                                                            |
|----------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|
| Nœud organisationnel             | Entité de la hiérarchie du module I (église locale, secteur, district, zone, région, préfecture, union, mission, réseau, direction, siège).               |
| Fidèle                           | Entité centrale du module II identifiant toute personne rattachée à l'Église, quel que soit son statut spirituel.                                         |
| RG-xxx                           | Identifiant unique d'une règle de gestion, référencé à la fois dans ce cahier et dans le code source (chapitre 8).                                        |
| Offline-first                    | Principe d'architecture selon lequel une application est d'abord conçue pour fonctionner sans connexion réseau active (chapitre 4).                       |
| Outbox / file de synchronisation | Journal local des opérations effectuées hors ligne, rejouées vers le serveur à la reconnexion.                                                            |
| Consolidation multi-niveaux      | Agrégation récursive des données d'un nœud et de ses nœuds descendants dans la hiérarchie organisationnelle.                                              |
| Référentiel                      | Donnée de paramétrage partagée (rôle, type d'offrande, don spirituel, zone géographique…) définie au module XXIII et consommée par les autres modules.    |
| Séparation des tâches            | Principe de contrôle interne imposant que la saisie, la validation et la consultation d'une opération sensible soient effectuées par des rôles distincts. |
| Mobile money                     | Service de paiement mobile (Orange Money, MTN Mobile Money, Moov Money, Wave, M-Pesa, etc.) intégré aux modules financiers pour le contexte africain.     |
| Cache serveur / cache local      | Couches de mise en cache décrites au chapitre 7, respectivement côté API centrale et côté appareil de l'utilisateur.                                      |

## **Annexe B — Matrice synthétique des rôles types**

Cette matrice complète les permissions détaillées du module XXIII (RG-XXIII-02) par une lecture par profil, utile aux équipes de recette fonctionnelle.

| **Rôle**                                    | **Périmètre d'accès principal**                                                                                                                  |
|---------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| Utilisateur simple (non affilié)            | Accès exclusif à la médiathèque chrétienne (XIII) depuis la page d'accueil commune, en lecture seule, sans saisie ni autre droit (RG-SEC-06bis). |
| Fidèle (utilisateur standard)               | Consultation de sa fiche, saisie d'offrande personnelle, lecture biblique et médiathèque, inscriptions aux formations et événements.             |
| Responsable de ministère                    | Gestion de son ministère (III), affectations, journal d'activités ; consultation des dons spirituels (IV) de ses membres.                        |
| Membre du comité                            | Accès aux séances et décisions du comité (VII) ; visibilité étendue selon fonction occupée.                                                      |
| Secrétaire administratif                    | Gestion documentaire (VIII), mutations (IX), soutien à la saisie déléguée (XI) pour les fidèles non connectés.                                   |
| Trésorier                                   | Validation des contributions (XI), tenue de la comptabilité (XXI), accès aux rapports financiers de son nœud.                                    |
| Pasteur référent / commission disciplinaire | Ouverture et instruction des dossiers disciplinaires (X), accès confidentiel restreint.                                                          |
| Administrateur de nœud                      | Paramétrage local, gestion des responsables (I), consultation du tableau de bord (XXII) de son périmètre.                                        |
| Administrateur Global Service Groupe        | Accès complet au module XXIII, gestion des référentiels globaux, consolidation au niveau international, gestion des campagnes de soutien (XV).   |

## **Annexe C — Dictionnaire de données consolidé**

Le dictionnaire complet, entité par entité et module par module, est détaillé dans les tableaux « Modèle de données » du chapitre 2 ; cette annexe en rappelle la convention commune : chaque entité porte un identifiant unique (UUID), une référence à son nœud organisationnel lorsque pertinent, un statut de cycle de vie, et les métadonnées d'audit (auteur, date de création, date de dernière modification) requises par le chapitre 6.

## **Annexe D — Feuille de route de mise en œuvre**

Le tableau ci-dessous fixe un ordre de mise en œuvre recommandé, non une estimation de durée : la dépendance fonctionnelle entre modules (chapitre 1.2) justifie ce séquencement, indépendamment de la taille de l'équipe de développement qui y sera affectée.

| **Phase**                             | **Contenu**                                                                                                                     |
|---------------------------------------|---------------------------------------------------------------------------------------------------------------------------------|
| Phase 1 — Fondations                  | Socle transversal, module I, module II, module XXIII, architecture offline-first (chapitres 3-4), sécurité de base (chapitre 6) |
| Phase 2 — Vie communautaire           | Modules III, IV, V, VI, VII, XII                                                                                                |
| Phase 3 — Administration et finances  | Modules VIII, IX, X, XI, XX, XXI, intégration mobile money (chapitre 5)                                                         |
| Phase 4 — Numérique et pédagogie      | Modules XIII, XIV, XVI, XVII, XIX, XXIV                                                                                         |
| Phase 5 — Réseau et gouvernance       | Modules XV, XVIII, XXII, consolidation multi-niveaux, édition Windows complète                                                  |
| Phase 6 — Durcissement et déploiement | Sécurité avancée, tests de charge, déploiement progressif par paliers africains (chapitre 5)                                    |

## **Annexe E — Index des règles de gestion transversales**

Au-delà des règles de gestion propres à chaque module (préfixe RG-I à RG-XXIV, chapitre 2), ce cahier définit cinq familles de règles transversales, applicables à l'ensemble de la plateforme : RG-OFF (gestion hors ligne, chapitre 4), RG-SEC (sécurité, chapitre 6), les principes de cache du chapitre 7, et RG-ECO (modèle économique et monétisation, chapitre 10). Les règles RG-OFF et RG-SEC priment sur toute règle de module en cas de conflit d'interprétation, car elles conditionnent l'intégrité et la disponibilité de l'ensemble du système ; les règles RG-ECO priment sur toute logique tarifaire locale non documentée, afin de garantir un modèle économique unique et transparent à l'échelle de Global Service Groupe.

## **Annexe F — Synthèse des paliers d'abonnement et sources de revenus**

Le détail complet des quatre paliers d'abonnement (Essentiel, Croissance, Réseau, International/Siège) et des sept sources de revenus de Global Service Groupe est présenté au chapitre 10 ; cette annexe en rappelle le principe cardinal : le socle communautaire (modules I, II, III, IV, VI, VII, XII, XXIV) reste gratuit pour toute église, quelle que soit sa taille, la monétisation portant exclusivement sur les fonctionnalités avancées, les transactions numériques, les formations et l'accompagnement professionnel.

# **Conclusion**

*« Toutes choses doivent se faire avec bienséance et avec ordre. » — 1 Corinthiens 14.40*

Ecclesias 360 traduit en architecture numérique une conviction simple : une Église bien organisée sert mieux sa vocation spirituelle. La reconstruction modulaire présentée dans ce cahier relie la structure organisationnelle, le fidèle et les flux financiers autour de sept axes fonctionnels cohérents, et complète le périmètre fonctionnel initial par les quatre dimensions sans lesquelles aucun déploiement réel n'est possible : le fonctionnement hors connexion, l'adaptation aux réalités africaines, la sécurité des données les plus sensibles, et une gestion des caches qui concilie performance et disponibilité.

Chaque module documenté au chapitre 2 porte désormais ses règles de gestion numérotées, son modèle de données, ses relations explicites et l'inventaire nommé de ses écrans : la base est posée pour que les équipes de développement puissent avancer module par module, palier par palier, sans ambiguïté sur ce qui doit être construit ni sur la manière dont chaque pièce s'articule avec les autres.

Ce cahier de conception constitue le socle de référence à partir duquel les équipes de développement, de design et de gouvernance pastorale pourront désormais avancer avec une vision commune, précise et partagée — de l'église locale naissante au réseau international structuré, avec la même exigence d'ordre qui inspire ce projet.
