import 'package:flutter/material.dart';
import 'package:sppamaik/page/kediaman_list.dart';
import 'package:sppamaik/page/mainpage.dart';
import 'package:sppamaik/page/tabmenu.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    const String HomeRoute = '/';
    const String DaftarRoute = '/daftar';
    const String ListRoute = '/senarai';
    const String SearchRoute =
        '/carian'; /*
    final Object? args = settings.arguments;*/

    final args = settings.arguments;
    switch (settings.name) {
      case HomeRoute:
        return MaterialPageRoute(builder: (_) => MainPage());
      case ListRoute:
        return MaterialPageRoute(builder: (_) => KediamanList());
      case DaftarRoute:
        return MaterialPageRoute(builder: (_) => TabMenu(nokp_text: null));
      case SearchRoute:
      //final args = settings.arguments;

      /* final event = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => KediamanTest());*/
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
