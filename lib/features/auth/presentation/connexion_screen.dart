import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../application/session_controller.dart';
import '../domain/models/identifiant_connexion.dart';
import '../domain/models/methode_otp.dart';
import '../domain/rules/identifiant_rules.dart';

/// RG-SEC-01 — connexion sans mot de passe : l'utilisateur choisit d'abord
/// son identifiant (téléphone ou e-mail), puis sa méthode de réception. Le
/// téléphone est validé au format E.164 avant tout appel au serveur
/// (KER-ID-06).
class ConnexionScreen extends StatefulWidget {
  const ConnexionScreen({super.key});

  @override
  State<ConnexionScreen> createState() => _ConnexionScreenState();
}

class _ConnexionScreenState extends State<ConnexionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _champ = TextEditingController();
  bool _telephone = true;
  MethodeOtp _methode = MethodeOtp.sms;

  @override
  void dispose() {
    _champ.dispose();
    super.dispose();
  }

  void _choisirBranche(bool telephone) {
    setState(() {
      _telephone = telephone;
      _methode = MethodeOtp.pour(telephone: telephone).first;
      _champ.clear();
    });
  }

  String _libelleMethode(AppLocalizations l10n, MethodeOtp methode) => switch (methode) {
        MethodeOtp.sms => l10n.authMethodeSms,
        MethodeOtp.whatsapp => l10n.authMethodeWhatsapp,
        MethodeOtp.magicLink => l10n.authMethodeMagicLink,
        MethodeOtp.codeEmail => l10n.authMethodeCodeEmail,
      };

  Future<void> _envoyer(SessionController session) async {
    if (!_formKey.currentState!.validate()) return;
    final IdentifiantConnexion identifiant =
        _telephone ? IdentifiantRules.telephone(_champ.text)! : IdentifiantRules.email(_champ.text)!;
    final envoye = await session.envoyerCode(identifiant, _methode);
    if (!mounted || !envoye) return;
    context.push(AppRoutes.connexionVerification);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final session = context.watch<SessionController>();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.authConnexionTitre)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppDimensions.spacingLg),
          children: [
            Text(l10n.authConnexionIntro),
            const SizedBox(height: AppDimensions.spacingLg),
            SegmentedButton<bool>(
              segments: [
                ButtonSegment(
                  value: true,
                  icon: const Icon(Icons.phone_outlined),
                  label: Text(l10n.authIdentifiantTelephone),
                ),
                ButtonSegment(
                  value: false,
                  icon: const Icon(Icons.alternate_email),
                  label: Text(l10n.authIdentifiantEmail),
                ),
              ],
              selected: {_telephone},
              onSelectionChanged: (choix) => _choisirBranche(choix.single),
            ),
            const SizedBox(height: AppDimensions.spacingLg),
            TextFormField(
              key: const ValueKey('champIdentifiant'),
              controller: _champ,
              keyboardType: _telephone ? TextInputType.phone : TextInputType.emailAddress,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: _telephone ? l10n.authChampTelephone : l10n.authChampEmail,
                helperText: _telephone ? l10n.authChampTelephoneAide : null,
              ),
              validator: (valeur) {
                final saisie = valeur ?? '';
                if (_telephone) {
                  return IdentifiantRules.telephone(saisie) == null ? l10n.authTelephoneInvalide : null;
                }
                return IdentifiantRules.email(saisie) == null ? l10n.authEmailInvalide : null;
              },
            ),
            const SizedBox(height: AppDimensions.spacingLg),
            Text(l10n.authMethodeTitre, style: Theme.of(context).textTheme.titleSmall),
            RadioGroup<MethodeOtp>(
              groupValue: _methode,
              onChanged: (valeur) => setState(() => _methode = valeur ?? _methode),
              child: Column(
                children: [
                  for (final methode in MethodeOtp.pour(telephone: _telephone))
                    RadioListTile<MethodeOtp>(
                      value: methode,
                      title: Text(_libelleMethode(l10n, methode)),
                    ),
                ],
              ),
            ),
            if (_telephone)
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton(
                  onPressed: () => _choisirBranche(false),
                  child: Text(l10n.authBasculerVersEmail),
                ),
              ),
            if (session.erreur != null)
              Padding(
                padding: const EdgeInsets.only(top: AppDimensions.spacingSm),
                child: Text(session.erreur!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
              ),
            const SizedBox(height: AppDimensions.spacingLg),
            FilledButton(
              onPressed: session.enCours ? null : () => _envoyer(session),
              child: Text(l10n.authEnvoyerCode),
            ),
          ],
        ),
      ),
    );
  }
}
