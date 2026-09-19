import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:math';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'splash_screen_model.dart';
export 'splash_screen_model.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({super.key});

  static String routeName = 'SplashScreen';
  static String routePath = '/splashScreen';

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget>
    with TickerProviderStateMixin {
  late SplashScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SplashScreenModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'SplashScreen'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('SPLASH_SCREEN_SplashScreen_ON_INIT_STATE');
      logFirebaseEvent('SplashScreen_custom_action');
      unawaited(
        () async {
          await actions.checkForceUpdate(
            context,
          );
        }(),
      );
      logFirebaseEvent('SplashScreen_custom_action');
      unawaited(
        () async {
          await actions.recordUserActivity();
        }(),
      );
      logFirebaseEvent('SplashScreen_wait__delay');
      await Future.delayed(
        Duration(
          milliseconds: 1500,
        ),
      );
      if (valueOrDefault<bool>(currentUserDocument?.woman, false) == true) {
        if (valueOrDefault<bool>(currentUserDocument?.signup001Done, false) ==
            true) {
          if ((currentUserDisplayName != null &&
                  currentUserDisplayName != '') &&
              (valueOrDefault(currentUserDocument?.secondName, '') != null &&
                  valueOrDefault(currentUserDocument?.secondName, '') != '')) {
            if (currentUserDocument?.dateOfBirth != null) {
              if (valueOrDefault(currentUserDocument?.city, '') != null &&
                  valueOrDefault(currentUserDocument?.city, '') != '') {
                if (valueOrDefault(
                            currentUserDocument?.relationshipStatus, '') !=
                        null &&
                    valueOrDefault(
                            currentUserDocument?.relationshipStatus, '') !=
                        '') {
                  if (valueOrDefault<bool>(
                          currentUserDocument?.childrenDone, false) ==
                      true) {
                    if (valueOrDefault(currentUserDocument?.displayImage, '') !=
                            null &&
                        valueOrDefault(currentUserDocument?.displayImage, '') !=
                            '') {
                      if (valueOrDefault<bool>(
                          currentUserDocument?.privacyPolicy, false)) {
                        if (valueOrDefault(
                                    currentUserDocument?.personalityType, '') !=
                                null &&
                            valueOrDefault(
                                    currentUserDocument?.personalityType, '') !=
                                '') {
                          logFirebaseEvent('SplashScreen_backend_call');

                          await currentUserReference!.update({
                            ...mapToFirestore(
                              {
                                'offline_user_time': FieldValue.delete(),
                              },
                            ),
                          });
                          logFirebaseEvent('SplashScreen_navigate_to');

                          context.goNamed(
                            PotentialConnectionsWidget.routeName,
                            extra: <String, dynamic>{
                              '__transition_info__': TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.fade,
                                duration: Duration(milliseconds: 0),
                              ),
                            },
                          );
                        } else {
                          logFirebaseEvent('SplashScreen_navigate_to');

                          context.goNamed(SignUp009Widget.routeName);
                        }
                      } else {
                        logFirebaseEvent('SplashScreen_navigate_to');

                        context.goNamed(SignUp008PrivacyWidget.routeName);
                      }
                    } else {
                      logFirebaseEvent('SplashScreen_navigate_to');

                      context.goNamed(SignUp007Widget.routeName);
                    }
                  } else {
                    logFirebaseEvent('SplashScreen_navigate_to');

                    context.goNamed(SignUp006Widget.routeName);
                  }
                } else {
                  logFirebaseEvent('SplashScreen_navigate_to');

                  context.goNamed(SignUp005Widget.routeName);
                }
              } else {
                logFirebaseEvent('SplashScreen_navigate_to');

                context.goNamed(SignUp004Widget.routeName);
              }
            } else {
              logFirebaseEvent('SplashScreen_navigate_to');

              context.goNamed(SignUp003Widget.routeName);
            }
          } else {
            logFirebaseEvent('SplashScreen_navigate_to');

            context.goNamed(SignUp002Widget.routeName);
          }
        } else {
          logFirebaseEvent('SplashScreen_navigate_to');

          context.goNamed(SignUp001Widget.routeName);
        }

        logFirebaseEvent('SplashScreen_backend_call');

        await currentUserReference!.update({
          ...mapToFirestore(
            {
              'offline_user_time': FieldValue.delete(),
            },
          ),
        });
      } else {
        logFirebaseEvent('SplashScreen_navigate_to');

        context.pushNamed(
          SignUp001aWidget.routeName,
          extra: <String, dynamic>{
            '__transition_info__': TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.leftToRight,
              duration: Duration(milliseconds: 300),
            ),
          },
        );
      }
    });

    animationsMap.addAll({
      'imageOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF7CDD0),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/images/flutterflow_logo.png',
                width: 250.0,
                fit: BoxFit.cover,
              ),
            ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation']!),
          ),
        ),
      ),
    );
  }
}
