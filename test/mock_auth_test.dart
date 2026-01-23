import 'package:flutter_project_1/data/authorization/authorization_credential.dart';
import 'package:flutter_project_1/data/authorization/repository/auth_repo.dart';
import 'package:flutter_project_1/data/authorization/service/mock_auth.dart';
import 'package:flutter_project_1/data/authorization/session.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("repo", () {
    test("testing mock sign in", () {
      IAuthorizationRepository repo = AuthorizationRepository(
        MockAuthorization(),
      );
      AuthCredential testUser = AuthCredential("Christo", "Test!123");
      repo.authorize(testUser).then((value) {
        expect(repo.getSession.state, AuthState.authenticated);
      });
    });
    test("testing state change event", () async {
      IAuthorizationRepository repo = AuthorizationRepository(
        MockAuthorization(),
      );

      void checkState(AuthState state) {
        expect(state, AuthState.authenticated);
      }

      repo.onStateChange.listen(checkState);

      AuthCredential testUser = AuthCredential("Christo", "Test!123");
      await repo.authorize(testUser);
    });
  });
}
