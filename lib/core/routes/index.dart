import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:promdifarm_app/core/const/strings.dart';
import 'package:promdifarm_app/core/services/index.dart';
import 'package:promdifarm_app/view/bloc/index.dart';
import 'package:promdifarm_app/core/di/index.dart';
import 'package:promdifarm_app/view/bloc/rider-profile/rider.cubit.dart';
import 'package:promdifarm_app/view/pages/index.dart';
import 'package:promdifarm_app/view/pages/terms_conditions_privacy/page.dart';
import 'package:promdifarm_app/view/pages/edit_profile.page.dart';
import 'package:promdifarm_app/view/widgets/page_transitions.dart';
import 'package:promdifarm_app/view/widgets/shared.dart';

class Routes {
  final LoginService loginService;

  Routes({required this.loginService});

  GoRouter getRouter(String token) {
    if (token.isNotEmpty) loginService.login();

    return GoRouter(
      initialLocation: "/${ROUTE.LOGIN}",
      routes: Routes.routes,
      redirect: (GoRouterState state) {
        final isLogging = state.location == "/${ROUTE.LOGIN}";
        if (!loginService.isLoggedIn && !isLogging) return "/${ROUTE.LOGIN}";
        if (loginService.isLoggedIn && isLogging) return "/${ROUTE.HOME}";
        return null;
      },
      refreshListenable: loginService,
      errorPageBuilder: Routes.errorPage,
    );
  }

  static List<GoRoute> routes = [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/${ROUTE.HOME_BACK}',
      name: ROUTE.HOME_BACK,
      pageBuilder: (context, state) => PushToLeft(
        child: HomePage(),
      ),
    ),
    createBlocRoute<LoginPage, UserCubit>(
      path: ROUTE.LOGIN,
      page: LoginPage(sl<LoginService>()),
    ),
    createBlocRoute<PasswordPage, DeliveriesCubit>(
      path: ROUTE.RIDER_PASSWORD,
      page: PasswordPage(),
    ),
    createBlocRoute<HelpCentre, DeliveriesCubit>(
      path: ROUTE.HELP_CENTER,
      page: HelpCentre(),
    ),
    createBlocRoute<PageFeedback, DeliveriesCubit>(
      path: ROUTE.FEEDBACK,
      page: PageFeedback(),
    ),
    createBlocRoute<HistoryPage, DeliveriesCubit>(
      path: ROUTE.TRANSACTION,
      page: HistoryPage(),
    ),
    GoRoute(
      path: '/${ROUTE.SETTINGS}',
      name: ROUTE.SETTINGS,
      pageBuilder: (context, state) => SlideRightExitLeft(
        child: BlocProvider(
          create: (BuildContext context) => sl<DeliveriesCubit>(),
          child: SettingsPage(),
        ),
      ),
    ),
    GoRoute(
      path: '/${ROUTE.PROFILE}',
      name: ROUTE.PROFILE,
      pageBuilder: (context, state) => SlideRightExitLeft(
        child: BlocProvider(
          create: (BuildContext context) => sl<RiderCubit>(),
          child: ProfilePage(),
        ),
      ),
    ),
    GoRoute(
      path: '/${ROUTE.EDITPROFILE}',
      name: ROUTE.EDITPROFILE,
      pageBuilder: (context, state) => SlideRightExitLeft(
        child: BlocProvider(
          create: (BuildContext context) => sl<RiderCubit>(),
          child: EditProfile(),
        ),
      ),
    ),
    GoRoute(
      path: '/${ROUTE.TERMS_PRIVACY}',
      name: ROUTE.TERMS_PRIVACY,
      pageBuilder: (context, state) => SlideRightExitLeft(
        child: BlocProvider(
          create: (BuildContext context) => sl<DeliveriesCubit>(),
          child: TermsConditionPrivacy(),
        ),
      ),
    ),
    GoRoute(
      path: '/${ROUTE.TERMS_PRIVACY_BACK}',
      name: ROUTE.TERMS_PRIVACY_BACK,
      pageBuilder: (context, state) => SlideLeftExitLeft(
        child: BlocProvider(
          create: (BuildContext context) => sl<DeliveriesCubit>(),
          child: TermsConditionPrivacy(),
        ),
      ),
    ),
    GoRoute(
      path: '/${ROUTE.TERMS_CONDITION}',
      name: ROUTE.TERMS_CONDITION,
      pageBuilder: (context, state) => SlideRightExitRight(
        child: BlocProvider(
          create: (BuildContext context) => sl<DeliveriesCubit>(),
          child: TermsConditions(),
        ),
      ),
    ),
    GoRoute(
      path: '/${ROUTE.PRIVACY}',
      name: ROUTE.PRIVACY,
      pageBuilder: (context, state) => SlideRightExitRight(
        child: BlocProvider(
          create: (BuildContext context) => sl<DeliveriesCubit>(),
          child: Privacy(),
        ),
      ),
    ),
    GoRoute(
      path: '/${ROUTE.HISTORY}',
      name: ROUTE.HISTORY,
      pageBuilder: (context, state) => SlideRightExitLeft(
        child: BlocProvider(
          create: (BuildContext context) => sl<DeliveriesCubit>(),
          child: HistoryPage(),
        ),
      ),
    ),
    GoRoute(
      path: '/${ROUTE.RIDER_DELIVERIES}',
      name: ROUTE.RIDER_DELIVERIES,
      pageBuilder: (context, state) => SlideRightExitLeft(
        child: BlocProvider(
          create: (BuildContext context) => sl<DeliveriesCubit>(),
          child: RiderDeliveries(),
        ),
      ),
    ),
    GoRoute(
      path: '/${ROUTE.MAP}/:id',
      name: ROUTE.MAP,
      builder: (context, state) => BlocProvider(
        create: (BuildContext context) => sl<DeliveriesCubit>(),
        child: Shared.template(
          context: context,
          body: MapPage(id: state.params['id']!),
          title: "Map",
        ),
      ),
    ),
    createRoute<InviteFriendsPage>(
        path: ROUTE.INVITE, page: InviteFriendsPage()),
    createRoute(path: ROUTE.HOME, page: HomePage()),
    createRoute(path: ROUTE.WALLET, page: WalletPage()),
    createRoute(path: ROUTE.FORGET_PW, page: ForgetPasswordPage()),
  ];

  static GoRoute createRoute<T extends Widget>({
    required String path,
    required T page,
  }) {
    return GoRoute(
      path: '/$path',
      name: path,
      pageBuilder: (context, state) => MaterialPage<T>(
        key: state.pageKey,
        child: page,
      ),
    );
  }

  static GoRoute createBlocRouteWithParams<T extends Widget>({
    required String path,
    required String param,
    required Widget Function(
      BuildContext,
      GoRouterState,
    )
        builder,
  }) {
    return GoRoute(path: '/$path$param', name: path, builder: builder);
  }

  static GoRoute createBlocRoute<T extends Widget, K extends Cubit>({
    required String path,
    required T page,
  }) {
    return GoRoute(
      path: '/$path',
      name: path,
      builder: (context, state) => BlocProvider(
        create: (BuildContext context) => sl<K>(),
        child: page,
      ),
    );
  }

  static MaterialPage<void> Function(
    BuildContext,
    GoRouterState,
  ) errorPage = (
    context,
    state,
  ) =>
      MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Text(state.error.toString()),
          ),
        ),
      );
}
