-- Module XXIV (RG-XXIV-01, RG-SEC-06bis amendé) — bucket des versions
-- bibliques téléchargées à la demande (Darby, Crampon).
--
-- Exception nommée à la règle « rien sans compte » : le bucket est **public
-- en lecture** — un fichier s'y télécharge par son URL publique, avec ou sans
-- compte, comme la lecture biblique elle-même. Il ne contient que des textes
-- du domaine public, produits par tool/bible/construire_corpus.dart.
--
-- Aucune écriture n'est ouverte à un client, anonyme ou authentifié : aucune
-- policy sur storage.objects ne vise ce bucket (RLS de storage.objects :
-- refus par défaut). Le dépôt des fichiers se fait avec la clé de service.
-- Taille maximale et type de contenu bornés : le bucket ne peut héberger
-- rien d'autre qu'un corpus compressé.

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('corpus-bibliques', 'corpus-bibliques', true, 20971520, array['application/gzip'])
on conflict (id) do update
  set public = excluded.public,
      file_size_limit = excluded.file_size_limit,
      allowed_mime_types = excluded.allowed_mime_types;
