/// RG-SEC-01 — méthode de réception du code à usage unique, choisie après
/// l'identifiant. Branche téléphone : SMS ou WhatsApp. Branche e-mail :
/// Magic Link ou code OTP — Supabase n'émet qu'un seul message pour la
/// branche e-mail (`signInWithOtp`), qui porte à la fois le lien et le code
/// (gabarit `supabase/templates/magic_link.html`) : le choix ne change que
/// ce que l'écran de vérification met en avant.
///
/// Le « code OTP email » de la branche téléphone du Cahier est traité comme
/// une bascule vers la branche e-mail (Supabase ne peut pas envoyer d'e-mail
/// à partir d'un numéro de téléphone seul) : l'identité authentifiée est
/// alors l'adresse e-mail.
enum MethodeOtp {
  sms('sms', estTelephone: true),
  whatsapp('whatsapp', estTelephone: true),
  magicLink('magic_link', estTelephone: false),
  codeEmail('code_email', estTelephone: false);

  const MethodeOtp(this.code, {required this.estTelephone});

  final String code;
  final bool estTelephone;

  static List<MethodeOtp> pour({required bool telephone}) =>
      values.where((m) => m.estTelephone == telephone).toList(growable: false);
}
