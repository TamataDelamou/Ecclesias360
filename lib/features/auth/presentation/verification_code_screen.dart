import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../l10n/app_localizations.dart';
import '../application/session_controller.dart';
import '../domain/models/methode_otp.dart';

/// RG-SEC-01 — saisie du code à usage unique (`verifyOtp`). Une fois la
/// session établie, la garde du routeur redirige vers l'accueil.
class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final _code = TextEditingController();

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  void _modifierIdentifiant(SessionController session) {
    session.abandonnerVerification();
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final session = context.watch<SessionController>();
    final identifiant = session.identifiantEnCours;
    final methode = session.methodeEnCours;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.authVerificationTitre)),
      body: identifiant == null || methode == null
          ? const SizedBox.shrink()
          : ListView(
              padding: const EdgeInsets.all(AppDimensions.spacingLg),
              children: [
                Text(l10n.authVerificationIntro(identifiant.valeur)),
                if (methode == MethodeOtp.magicLink) ...[
                  const SizedBox(height: AppDimensions.spacingSm),
                  Text(l10n.authVerificationMagicLink),
                ],
                const SizedBox(height: AppDimensions.spacingLg),
                TextField(
                  key: const ValueKey('champCode'),
                  controller: _code,
                  keyboardType: TextInputType.number,
                  autofillHints: const [AutofillHints.oneTimeCode],
                  maxLength: 6,
                  decoration: InputDecoration(labelText: l10n.authChampCode),
                  onSubmitted: (_) => session.verifierCode(_code.text),
                ),
                if (session.erreur != null)
                  Text(session.erreur!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                const SizedBox(height: AppDimensions.spacingLg),
                FilledButton(
                  onPressed: session.enCours ? null : () => session.verifierCode(_code.text),
                  child: Text(l10n.authVerifier),
                ),
                const SizedBox(height: AppDimensions.spacingSm),
                TextButton(
                  onPressed: session.enCours ? null : () => session.envoyerCode(identifiant, methode),
                  child: Text(l10n.authRenvoyerCode),
                ),
                TextButton(
                  onPressed: session.enCours ? null : () => _modifierIdentifiant(session),
                  child: Text(l10n.authModifierIdentifiant),
                ),
              ],
            ),
    );
  }
}
