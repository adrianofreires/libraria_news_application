import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:libraria_news_application/core/features/news/presentation/bloc/search_articles_bloc/search_articles_bloc.dart';
import 'package:libraria_news_application/core/features/news/presentation/widgets/custom_search_delegate.dart';
import 'package:libraria_news_application/injection_container.dart' as injection;
import 'package:libraria_news_application/injection_container.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'core/features/news/presentation/bloc/articles_bloc/articles_bloc.dart';
import 'core/features/news/presentation/pages/news_home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection.init();
  initializeDateFormatting('pt_BR', null).then((_) => runApp(News()));
}

class News extends StatefulWidget {
  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  static final String oneSignalAppID = "54efcec4-7eb0-4ee9-a23a-12712ee1e11c";
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => service_locator<SearchArticlesBloc>(),
        ),
        BlocProvider(
          create: (BuildContext context) => service_locator<ArticlesBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News',
        theme: ThemeData(
            textTheme: GoogleFonts.interTextTheme().copyWith(headline6: TextStyle(color: Colors.white)),
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: TextStyle(color: Colors.white),
            ),
            colorScheme: ColorScheme.dark().copyWith(
                background: Color(0xFF1e1e22),
                primaryVariant: Color(0xFF1e1e22),
                secondary: Color(0xFFe82822),
                onSecondary: Color(0xFFe82822)),
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: NewsHomePage(),
      ),
    );
  }

  Future<void> initPlatformState() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setRequiresUserPrivacyConsent(true);
    OneSignal.shared.consentGranted(true);
    OneSignal.shared.setAppId(oneSignalAppID);
    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) => print('Permissão Concessida: $accepted'));
  }
}
