import 'package:flutter_project_1/data/authorization/authorization_credential.dart';
import 'package:flutter_project_1/data/authorization/session.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("equating two sessions", () {
    var session = Session(id: "xyz",
        cred: AuthCredential("Christo", "key"),
        state: .authenticated);
    var session2 = Session.changeState(session, .authenticated);
    expect(session == session2, false); // different instance
  });
  test("equating with null object singleton", () {
    var session = Session(id: "xyz",
        cred: AuthCredential("Christo", "key"),
        state: .authenticated);
    session = .nullSession;
    expect(session == .nullSession, true); // same instance
  });
}
