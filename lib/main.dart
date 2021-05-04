import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libraria_news_application/injection_container.dart' as injection;
import 'package:libraria_news_application/injection_container.dart';

import 'core/features/news/presentation/bloc/articles_bloc.dart';
import 'core/features/news/presentation/pages/news_home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection.init();
  runApp(News());
}

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primaryColor: Color(0xFF1e1e22),
        accentColor: Color(0xFFe82822),
        textTheme: GoogleFonts.interTextTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (_) => service_locator<ArticlesBloc>(),
        child: NewsHomePage(),
      ),
    );
  }
}
