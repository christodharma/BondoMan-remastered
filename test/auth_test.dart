import 'package:flutter_project_1/data/authorization/authorization_credential.dart';
import 'package:flutter_project_1/data/authorization/repository/auth_repo.dart';
import 'package:flutter_project_1/data/authorization/service/mock_auth.dart';
import 'package:flutter_project_1/data/authorization/service/supabase_auth.dart';
import 'package:flutter_project_1/data/authorization/session.dart' as local;
import 'package:flutter_project_1/data/external_service/supabase_adaptor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("mocks", () {
    test("testing mock sign in", () {
      IAuthorizationRepository repo = AuthorizationRepository(
        MockAuthorization(),
      );
      AuthCredential testUser = AuthCredential("Christo", "Test!123");
      repo.authorize(testUser).then((value) {
        expect(repo.getSession.state, local.AuthState.authenticated);
      });
    });
    test("testing state change event", () async {
      IAuthorizationRepository repo = AuthorizationRepository(
        MockAuthorization(),
      );

      void checkState(local.AuthState state) {
        expect(state, local.AuthState.authenticated);
      }

      repo.onStateChange.listen(checkState);

      AuthCredential testUser = AuthCredential("Christo", "Test!123");
      await repo.authorize(testUser);
    });
  });
  group("supabase", () {
    // FIXME SharedPreferences isn't available in tests
    test("supabase signin", () async {
      await SupabaseEnvironment.initialize();

      IAuthorizationRepository repo = AuthorizationRepository(
        SupabaseAuth(SupabaseEnvironment.client),
      );

      AuthCredential cred = AuthCredential(
        "vio@dev.yup",
        "ThisIsForViosEyesOnly",
      );
      await repo.authorize(cred);
      expect(repo.getSession.state, local.AuthState.authenticated);
    });
  });
}
