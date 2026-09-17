import 'package:uuid/uuid.dart';

/// Génère les identifiants locaux (RG-OFF-03) : UUID v4, définitif dès la
/// création — jamais renuméroté après synchronisation.
abstract final class IdGenerator {
  static const Uuid _uuid = Uuid();

  static String newId() => _uuid.v4();
}
