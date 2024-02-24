import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/androidenterprise/v1.dart';
import 'package:googleapis/vmwareengine/v1.dart';
import 'package:googleapis/websecurityscanner/v1.dart';
import 'package:googleapis/oauth2/v2.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

class Google {
  static GoogleSignIn google = GoogleSignIn(
      // clientId:
      //     '484095062673-bubg4k1m93h9n0va5q3299rd0ol33kto.apps.googleusercontent.com',
      scopes: [
        drive.DriveApi.driveScriptsScope,
        sheets.SheetsApi.spreadsheetsScope
      ],
      
      );
  // ClientId
  // final authenticateClient = Googlec;

  Future<GoogleSignInAccount?> signIn() async {
    try {
      var data = await google.signIn();
      return data;
    } catch (e) {
      throw ('${e}');
    }
  }

  Future<GoogleSignInAccount?> signOut() async {
    try {
      var data = await google.signOut();
      return data;
    } catch (e) {
      throw ('${e}');
    }
  }

  GoogleSignIn anyMethod() {
    return google;
  }
}
