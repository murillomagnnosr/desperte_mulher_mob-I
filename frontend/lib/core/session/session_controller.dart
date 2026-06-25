import 'package:flutter/foundation.dart';

/// Estado de sessão da aplicação (área Acolhe).
///
/// É um [ChangeNotifier] simples e global: o GoRouter o escuta
/// (`refreshListenable`) para reavaliar os redirects assim que a usuária faz
/// login/logout. Na Etapa 10, `signIn` passará a guardar o JWT real; a
/// interface pública (isLoggedIn/signIn/signOut) permanece a mesma.
class SessionController extends ChangeNotifier {
  bool _loggedIn = false;
  String? _userName;

  bool get isLoggedIn => _loggedIn;
  String? get userName => _userName;

  void signIn(String userName) {
    _loggedIn = true;
    _userName = userName;
    notifyListeners();
  }

  void signOut() {
    _loggedIn = false;
    _userName = null;
    notifyListeners();
  }
}
