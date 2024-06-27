/// Helper to get environment variables
///
/// It relies on:
/// - existing .env file where the values are stored
/// - dev app is run with --dart-define-from-file=.env option
/// ```
/// flutter run --dart-define-from-file=.env
/// ```
/// ```
/// // vscode launch.json
/// {
///   "version": "0.2.0",
///   "configurations": [
///     {
///       "name": "five_on_4_mobile",
///       "request": "launch",
///       "type": "dart",
///       "program": "lib/main.dart",
///       "toolArgs": [
///         "--dart-define-from-file",
///         ".env" // for env files // make sure prod has its own env file when building
///       ]
///     },
///   ]
/// }

/// ```
///
/// - prod app is built with --dart-define-from-file=.env option
/// ```
/// 	flutter build appbundle --release --dart-define-from-file=.env
/// ```

// TODO test this somehow
class EnvVarsWrapper {
  // TODO create constants for this
  // auth
  String get googleAuthServerId =>
      const String.fromEnvironment('GOOGLE_AUTH_SERVER_ID');

  // dev
  bool get shouldUseLocalServer => const bool.fromEnvironment(
        'SHOULD_USE_LOCAL_SERVER',
        defaultValue: false,
      );
}

// more info at 
/* 
// more here: https://itnext.io/secure-your-flutter-project-the-right-way-to-set-environment-variables-with-compile-time-variables-67c3163ff9f4
// https://medium.com/flutter-community/how-to-setup-dart-define-for-keys-and-secrets-on-android-and-ios-in-flutter-apps-4f28a10c4b6c
// https://itnext.io/secure-your-flutter-project-the-right-way-to-set-environment-variables-with-compile-time-variables-67c3163ff9f4
// https://itnext.io/flutter-3-7-and-a-new-way-of-defining-compile-time-variables-f63db8a4f6e2
// TODO still left to do native layers thing - not sure if it is needed
 */