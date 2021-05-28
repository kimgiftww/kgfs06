import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Kgfs06FirebaseUser {
  Kgfs06FirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

Kgfs06FirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<Kgfs06FirebaseUser> kgfs06FirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<Kgfs06FirebaseUser>((user) => currentUser = Kgfs06FirebaseUser(user));
