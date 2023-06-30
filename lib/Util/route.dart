import 'package:auto_route/auto_route.dart';
import 'package:e_commerce/Util/route.gr.dart';
import 'AuthGuard.dart';
import 'appInfo.dart' as global;

@AutoRouterConfig()
class RootRoute extends $RootRoute implements AutoRouteGuard {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: Home.page,
          initial: true,
          children: [
            AutoRoute(
              page: ProductDetail.page,
              guards: [AuthGuard()],
            ),
            AutoRoute(
              page: LoginView.page,
              path: '/login',
            ),
          ],
        ),
        // RedirectRoute(path: '*', redirectTo: '/login'),
      ];

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // TODO: implement onNavigation
  }
}
