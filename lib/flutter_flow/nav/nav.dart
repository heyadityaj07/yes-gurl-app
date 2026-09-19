import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';

import '/auth/base_auth_user_provider.dart';

import '/backend/push_notifications/push_notifications_handler.dart'
    show PushNotificationsHandler;
import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'serialization_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? SplashScreenWidget() : LoginWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? SplashScreenWidget() : LoginWidget(),
        ),
        FFRoute(
          name: ChatWidget.routeName,
          path: ChatWidget.routePath,
          builder: (context, params) => ChatWidget(
            initialTab: params.getParam(
              'initialTab',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: ProfileWidget.routeName,
          path: ProfileWidget.routePath,
          builder: (context, params) => ProfileWidget(),
        ),
        FFRoute(
          name: SignUp002Widget.routeName,
          path: SignUp002Widget.routePath,
          builder: (context, params) => SignUp002Widget(),
        ),
        FFRoute(
          name: SignUp003Widget.routeName,
          path: SignUp003Widget.routePath,
          builder: (context, params) => SignUp003Widget(),
        ),
        FFRoute(
          name: SignUp004Widget.routeName,
          path: SignUp004Widget.routePath,
          builder: (context, params) => SignUp004Widget(),
        ),
        FFRoute(
          name: SignUp005Widget.routeName,
          path: SignUp005Widget.routePath,
          builder: (context, params) => SignUp005Widget(),
        ),
        FFRoute(
          name: SignUp009Widget.routeName,
          path: SignUp009Widget.routePath,
          builder: (context, params) => SignUp009Widget(),
        ),
        FFRoute(
          name: SignUp010Widget.routeName,
          path: SignUp010Widget.routePath,
          builder: (context, params) => SignUp010Widget(),
        ),
        FFRoute(
          name: TestWidget.routeName,
          path: TestWidget.routePath,
          builder: (context, params) => TestWidget(),
        ),
        FFRoute(
          name: TestStartWidget.routeName,
          path: TestStartWidget.routePath,
          builder: (context, params) => TestStartWidget(),
        ),
        FFRoute(
          name: ProfileEditWidget.routeName,
          path: ProfileEditWidget.routePath,
          builder: (context, params) => ProfileEditWidget(),
        ),
        FFRoute(
          name: ProfilePreferencesWidget.routeName,
          path: ProfilePreferencesWidget.routePath,
          builder: (context, params) => ProfilePreferencesWidget(),
        ),
        FFRoute(
          name: ProfileSettingsWidget.routeName,
          path: ProfileSettingsWidget.routePath,
          builder: (context, params) => ProfileSettingsWidget(),
        ),
        FFRoute(
          name: ProfilePreferencesRelationshipWidget.routeName,
          path: ProfilePreferencesRelationshipWidget.routePath,
          builder: (context, params) => ProfilePreferencesRelationshipWidget(),
        ),
        FFRoute(
          name: ProfilePreferencesChildrenWidget.routeName,
          path: ProfilePreferencesChildrenWidget.routePath,
          builder: (context, params) => ProfilePreferencesChildrenWidget(),
        ),
        FFRoute(
          name: ProfilePreferencesAgeWidget.routeName,
          path: ProfilePreferencesAgeWidget.routePath,
          builder: (context, params) => ProfilePreferencesAgeWidget(),
        ),
        FFRoute(
          name: ProfilePreferencesLocationWidget.routeName,
          path: ProfilePreferencesLocationWidget.routePath,
          builder: (context, params) => ProfilePreferencesLocationWidget(),
        ),
        FFRoute(
          name: ProfileEditAdditionalRelationshipWidget.routeName,
          path: ProfileEditAdditionalRelationshipWidget.routePath,
          builder: (context, params) =>
              ProfileEditAdditionalRelationshipWidget(),
        ),
        FFRoute(
          name: ProfileEditAdditionalChildrenWidget.routeName,
          path: ProfileEditAdditionalChildrenWidget.routePath,
          builder: (context, params) => ProfileEditAdditionalChildrenWidget(),
        ),
        FFRoute(
          name: ProfileEditAdditionalNameWidget.routeName,
          path: ProfileEditAdditionalNameWidget.routePath,
          builder: (context, params) => ProfileEditAdditionalNameWidget(),
        ),
        FFRoute(
          name: ProfileEditAdditionalLocationWidget.routeName,
          path: ProfileEditAdditionalLocationWidget.routePath,
          builder: (context, params) => ProfileEditAdditionalLocationWidget(),
        ),
        FFRoute(
          name: SignUp001Widget.routeName,
          path: SignUp001Widget.routePath,
          builder: (context, params) => SignUp001Widget(),
        ),
        FFRoute(
          name: SignUp006Widget.routeName,
          path: SignUp006Widget.routePath,
          builder: (context, params) => SignUp006Widget(),
        ),
        FFRoute(
          name: SignUp008PrivacyWidget.routeName,
          path: SignUp008PrivacyWidget.routePath,
          builder: (context, params) => SignUp008PrivacyWidget(),
        ),
        FFRoute(
          name: LoginEmailWidget.routeName,
          path: LoginEmailWidget.routePath,
          builder: (context, params) => LoginEmailWidget(),
        ),
        FFRoute(
          name: LoginEmailSignUpWidget.routeName,
          path: LoginEmailSignUpWidget.routePath,
          builder: (context, params) => LoginEmailSignUpWidget(),
        ),
        FFRoute(
          name: SignUp001aWidget.routeName,
          path: SignUp001aWidget.routePath,
          builder: (context, params) => SignUp001aWidget(),
        ),
        FFRoute(
          name: SignUp007Widget.routeName,
          path: SignUp007Widget.routePath,
          builder: (context, params) => SignUp007Widget(),
        ),
        FFRoute(
          name: LoginWidget.routeName,
          path: LoginWidget.routePath,
          builder: (context, params) => LoginWidget(),
        ),
        FFRoute(
          name: ForgotPasswordWidget.routeName,
          path: ForgotPasswordWidget.routePath,
          builder: (context, params) => ForgotPasswordWidget(),
        ),
        FFRoute(
          name: TestSummaryWidget.routeName,
          path: TestSummaryWidget.routePath,
          builder: (context, params) => TestSummaryWidget(
            isFromProfile: params.getParam(
              'isFromProfile',
              ParamType.bool,
            ),
            personalityParms: params.getParam(
              'personalityParms',
              ParamType.String,
            ),
            anotherUserProfile: params.getParam(
              'anotherUserProfile',
              ParamType.String,
            ),
            userRef: params.getParam(
              'userRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['user'],
            ),
          ),
        ),
        FFRoute(
          name: ProfileEditMyPhotoWidget.routeName,
          path: ProfileEditMyPhotoWidget.routePath,
          builder: (context, params) => ProfileEditMyPhotoWidget(),
        ),
        FFRoute(
          name: PotentialMatchesProfileWidget.routeName,
          path: PotentialMatchesProfileWidget.routePath,
          builder: (context, params) => PotentialMatchesProfileWidget(
            userRef: params.getParam(
              'userRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['user'],
            ),
            throughUserProfile: params.getParam(
              'throughUserProfile',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ProfileSettingsEmailWidget.routeName,
          path: ProfileSettingsEmailWidget.routePath,
          builder: (context, params) => ProfileSettingsEmailWidget(),
        ),
        FFRoute(
          name: LinkUpWidget.routeName,
          path: LinkUpWidget.routePath,
          builder: (context, params) => LinkUpWidget(
            tabIndex: params.getParam(
              'tabIndex',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: LinkUpDetailsWidget.routeName,
          path: LinkUpDetailsWidget.routePath,
          asyncParams: {
            'eventRef': getDoc(['events'], EventsRecord.fromSnapshot),
          },
          builder: (context, params) => LinkUpDetailsWidget(
            eventRef: params.getParam(
              'eventRef',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: LinkUpCreateWidget.routeName,
          path: LinkUpCreateWidget.routePath,
          builder: (context, params) => LinkUpCreateWidget(),
        ),
        FFRoute(
          name: ProfileEditPromptsWidget.routeName,
          path: ProfileEditPromptsWidget.routePath,
          builder: (context, params) => ProfileEditPromptsWidget(),
        ),
        FFRoute(
          name: ProfileEditletsGoOfflineWidget.routeName,
          path: ProfileEditletsGoOfflineWidget.routePath,
          builder: (context, params) => ProfileEditletsGoOfflineWidget(),
        ),
        FFRoute(
          name: ChatRequestWidget.routeName,
          path: ChatRequestWidget.routePath,
          builder: (context, params) => ChatRequestWidget(
            chatRef: params.getParam(
              'chatRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['chat'],
            ),
          ),
        ),
        FFRoute(
          name: ChatConnectionsWidget.routeName,
          path: ChatConnectionsWidget.routePath,
          builder: (context, params) => ChatConnectionsWidget(
            chatRef: params.getParam(
              'chatRef',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['chat'],
            ),
          ),
        ),
        FFRoute(
          name: ProfileSettingsFeedbackWidget.routeName,
          path: ProfileSettingsFeedbackWidget.routePath,
          builder: (context, params) => ProfileSettingsFeedbackWidget(),
        ),
        FFRoute(
          name: ProfileSettingsSuccessStoriesWidget.routeName,
          path: ProfileSettingsSuccessStoriesWidget.routePath,
          builder: (context, params) => ProfileSettingsSuccessStoriesWidget(),
        ),
        FFRoute(
          name: ShareWidget.routeName,
          path: ShareWidget.routePath,
          builder: (context, params) => ShareWidget(
            initialTab: params.getParam(
              'initialTab',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: LinkUpEditWidget.routeName,
          path: LinkUpEditWidget.routePath,
          asyncParams: {
            'event': getDoc(['events'], EventsRecord.fromSnapshot),
          },
          builder: (context, params) => LinkUpEditWidget(
            event: params.getParam(
              'event',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: OnboardingWidget.routeName,
          path: OnboardingWidget.routePath,
          builder: (context, params) => OnboardingWidget(),
        ),
        FFRoute(
          name: Onboarding2Widget.routeName,
          path: Onboarding2Widget.routePath,
          builder: (context, params) => Onboarding2Widget(),
        ),
        FFRoute(
          name: Onboarding3Widget.routeName,
          path: Onboarding3Widget.routePath,
          builder: (context, params) => Onboarding3Widget(),
        ),
        FFRoute(
          name: Onboarding4Widget.routeName,
          path: Onboarding4Widget.routePath,
          builder: (context, params) => Onboarding4Widget(),
        ),
        FFRoute(
          name: NotificationWidget.routeName,
          path: NotificationWidget.routePath,
          requireAuth: true,
          builder: (context, params) => NotificationWidget(),
        ),
        FFRoute(
          name: AdminLinkUpDetailsWidget.routeName,
          path: AdminLinkUpDetailsWidget.routePath,
          asyncParams: {
            'eventDoc': getDoc(['events'], EventsRecord.fromSnapshot),
          },
          builder: (context, params) => AdminLinkUpDetailsWidget(
            eventDoc: params.getParam(
              'eventDoc',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: Onboarding1Widget.routeName,
          path: Onboarding1Widget.routePath,
          builder: (context, params) => Onboarding1Widget(),
        ),
        FFRoute(
          name: ProfileSettingsReportWidget.routeName,
          path: ProfileSettingsReportWidget.routePath,
          builder: (context, params) => ProfileSettingsReportWidget(),
        ),
        FFRoute(
          name: PotentialConnectionsWidget.routeName,
          path: PotentialConnectionsWidget.routePath,
          builder: (context, params) => PotentialConnectionsWidget(),
        ),
        FFRoute(
          name: SplashScreenWidget.routeName,
          path: SplashScreenWidget.routePath,
          builder: (context, params) => SplashScreenWidget(),
        ),
        FFRoute(
          name: CommunitiesWidget.routeName,
          path: CommunitiesWidget.routePath,
          builder: (context, params) => CommunitiesWidget(),
        ),
        FFRoute(
          name: CommunitiesSeeAllWidget.routeName,
          path: CommunitiesSeeAllWidget.routePath,
          builder: (context, params) => CommunitiesSeeAllWidget(
            initialTab: params.getParam(
              'initialTab',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: CommunitiesCreateWidget.routeName,
          path: CommunitiesCreateWidget.routePath,
          builder: (context, params) => CommunitiesCreateWidget(),
        ),
        FFRoute(
          name: CommunityOpenWidget.routeName,
          path: CommunityOpenWidget.routePath,
          asyncParams: {
            'eventRef': getDoc(['events'], EventsRecord.fromSnapshot),
          },
          builder: (context, params) => CommunityOpenWidget(
            eventRef: params.getParam(
              'eventRef',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: CommunityClosedInviteWidget.routeName,
          path: CommunityClosedInviteWidget.routePath,
          asyncParams: {
            'eventRef': getDoc(['events'], EventsRecord.fromSnapshot),
          },
          builder: (context, params) => CommunityClosedInviteWidget(
            eventRef: params.getParam(
              'eventRef',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: CommunityOpenClosedInviteJoinedWidget.routeName,
          path: CommunityOpenClosedInviteJoinedWidget.routePath,
          asyncParams: {
            'eventRef': getDoc(['events'], EventsRecord.fromSnapshot),
          },
          builder: (context, params) => CommunityOpenClosedInviteJoinedWidget(
            eventRef: params.getParam(
              'eventRef',
              ParamType.Document,
            ),
          ),
        ),
        FFRoute(
          name: CommunityOpenClosedInviteJoinedAdminWidget.routeName,
          path: CommunityOpenClosedInviteJoinedAdminWidget.routePath,
          asyncParams: {
            'eventRef': getDoc(['events'], EventsRecord.fromSnapshot),
          },
          builder: (context, params) =>
              CommunityOpenClosedInviteJoinedAdminWidget(
            eventRef: params.getParam(
              'eventRef',
              ParamType.Document,
            ),
          ),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/login';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: Color(0xFFF7CDD0),
                  child: Image.asset(
                    'assets/images/flutterflow_google_app_icon.png',
                    fit: BoxFit.contain,
                  ),
                )
              : PushNotificationsHandler(child: page);

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  name: state.name,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(
                  key: state.pageKey, name: state.name, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
