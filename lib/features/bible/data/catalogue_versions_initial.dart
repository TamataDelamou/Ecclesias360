// GÉNÉRÉ par tool/bible/construire_corpus.dart — ne pas modifier à la main.
//
// Catalogue initial des versions bibliques (RG-XXIV-01), inséré dans le
// référentiel `versions_bibliques` : un référentiel en données, jamais un
// enum figé (AGENTS.md §12 point 4).

import '../domain/models/version_biblique.dart';

/// Format des bases produites ; son changement redéclenche la décompression.
const formatCorpusBiblique = 1;

const catalogueVersionsInitial = <VersionBiblique>[
  VersionBiblique(
    code: 'lsg1910',
    nom: 'Louis Segond 1910',
    langue: 'fr',
    edition: 'Louis Segond, édition de 1910',
    licence: 'Domaine public (ebible.org : « Cette Bible est dans le domaine public »)',
    source: 'https://ebible.org/Scriptures/fraLSG_vpl.zip',
    embarquee: true,
    fichier: 'lsg1910.db.gz',
    taille: 3489488,
    sha256: 'bc25e3b3f46600f61b93e24158b69b36ec989163665d87aac0792ab1b4537657',
    nbLivres: 66,
    nbVersets: 31170,
  ),
  VersionBiblique(
    code: 'darby',
    nom: 'Darby',
    langue: 'fr',
    edition: 'J.N. Darby, révision JND v2.0 (Bibles et Publications Chrétiennes, 2024) du texte de 1885',
    licence: 'Domaine public (déclaré par Bibles et Publications Chrétiennes, ebible.org)',
    source: 'https://ebible.org/Scriptures/frajnd_vpl.zip',
    embarquee: false,
    fichier: 'darby.db.gz',
    taille: 3533464,
    sha256: '20a26574fd7d45ee762095b7918aa6f2c39e6acc7e93e9c4e0228c04b2dbd9fb',
    nbLivres: 66,
    nbVersets: 31167,
  ),
  VersionBiblique(
    code: 'crampon',
    nom: 'Crampon',
    langue: 'fr',
    edition: 'Augustin Crampon, édition de 1923',
    licence: 'Domaine public (scrollmapper/bible_databases, FreCrampon ; dépôt sous licence MIT)',
    source: 'https://raw.githubusercontent.com/scrollmapper/bible_databases/master/sources/fr/FreCrampon/FreCrampon.json',
    embarquee: false,
    fichier: 'crampon.db.gz',
    taille: 4065142,
    sha256: 'c34b6a38bb9ec70c0d0d80e3f635c84fd1a0d8e1dc25fe8a3659aa0489dc15f1',
    nbLivres: 73,
    nbVersets: 35486,
  ),
];
