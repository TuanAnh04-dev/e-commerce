import 'package:auto_route/auto_route.dart';
import 'package:e_commerce/Util/route.gr.dart';
import 'appInfo.dart' as global;

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (global.isAuth == true) {
      router.push(
        LoginView(
          onLoginresult: (_) {
            global.isAuth = true;
            router.markUrlStateForReplace();
            router.removeLast();
            resolver.next();
          },
        ),
      );
    } else {
      resolver.next(true);
    }
  }
}
