import 'package:common/common.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shop_cake/auth/AuthServiceImpl.dart';
import 'package:shop_cake/firebase/default_firebase_config.dart';
import 'package:shop_cake/firebase/setup_firebase.dart';
import 'package:shop_cake/generated/l10n.dart';
import 'package:shop_cake/network/config.dart';
import 'package:shop_cake/src/app_home.dart';
import 'package:shop_cake/src/login/ui/login.dart';

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
SharedPreferences? shared;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BuildConfig(FlavorConfig.release);
  configure();
  shared = await SharedPreferences.getInstance();
  Translate.delegate.setShared(shared);
  Log.init();
  // await Firebase.initializeApp(name: DefaultFirebaseConfig.platformOptions.projectId, options: DefaultFirebaseConfig.platformOptions);
  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  // Set the background messaging handler early on, as a named top-level function
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  runApp(
    WrapperApplication(
      authService: AuthServiceImpl(shared),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with MaterialAppMixin, LocalizationMixin, ThemeMixin {
  @override
  String get title => Translate.current.app_title;

  @override
  Widget get home => AuthConsumer(
        isAuth: true,
        home: () => const AppHome(),
        login: () => const Login(
          openLogin: AuthenticationStatus.authenticated,
        ),
      );

  @override
  LocalizationsDelegate get delegate => Translate.delegate;

  @override
  Iterable<Locale> get supportedLocales => Translate.delegate.supportedLocales;
}
