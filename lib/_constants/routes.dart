import 'package:Emporium/home.dart';
import 'package:Emporium/views/view_settings.dart';
import 'package:sailor/sailor.dart';

class Routes {
  static final sailor = Sailor(
    options: SailorOptions(handleNameNotFoundUI: true),
  );

  static void createRoutes() {
    sailor.addRoutes([
      SailorRoute(name: Paths.home, builder: (_, __, ___) => ViewHome()),
      SailorRoute(name: Paths.settings, builder: (_, __, ___) => ViewSettings()),
    ]);
  }

  // static void goOffTo(String path) => Routes.sailor.navigate(path,
  //     navigationType: NavigationType.pushAndRemoveUntil, removeUntilPredicate: (_) => false);
}

class Paths {
  static final String home = 'home';
  static final String settings = 'settings';
}
