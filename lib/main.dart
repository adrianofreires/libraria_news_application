import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:libraria_news_application/injection_container.dart' as injection;
import 'package:libraria_news_application/injection_container.dart';

import 'core/features/news/presentation/bloc/articles_bloc.dart';
import 'core/features/news/presentation/pages/news_home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection.init();
  initializeDateFormatting('pt_BR', null).then((_) => runApp(News()));
}

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News',
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
        colorScheme: ColorScheme.dark().copyWith(
            background: Color(0xFF1e1e22), primaryVariant: const Color(0xFF1e1e22), secondary: const Color(0xffe82822)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (_) => service_locator<ArticlesBloc>(),
        child: NewsHomePage(),
      ),
    );
  }
}
