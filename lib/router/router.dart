import 'package:auto_route/auto_route.dart';
import 'package:bookly_app/helpers/context_extension.dart';
import 'package:bookly_app/router/router.gr.dart';
import 'package:flutter/cupertino.dart';

final router = AppRouter(NavigationContext.navigatorKey);

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter([
    GlobalKey<NavigatorState>? navigationKey,
  ]) : super(navigatorKey: navigationKey);
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
        ),
        AutoRoute(
          page: LoginRoute.page,
        ),
        AutoRoute(
          page: RegisterRoute.page,
        ),
        AutoRoute(
          page: MainRoute.page,
          initial: true,
        ),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(
          page: SelectionRoute.page,
        ),
        AutoRoute(
          page: BookDetailsRoute.page,
        ),
        AutoRoute(page: SearchRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: AllBooksRoute.page),
        AutoRoute(page: AllCategoriesRoute.page),
        AutoRoute(page: CategoryBooksRoute.page),
        AutoRoute(page: ChatWithAdminRoute.page),
        AutoRoute(page: ProfileRoute.page),
        AutoRoute(page: PrivacyPolicyRoute.page),
        AutoRoute(page: TermsAndConditionsRoute.page),
        AutoRoute(
          page: AdminHomeRoute.page,
        ),
        AutoRoute(page: AdminAddBookRoute.page),
        AutoRoute(page: AdminCategoriesRoute.page),
      ];
}
