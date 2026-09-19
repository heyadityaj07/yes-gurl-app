import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'no_match_model.dart';
export 'no_match_model.dart';

class NoMatchWidget extends StatefulWidget {
  const NoMatchWidget({super.key});

  @override
  State<NoMatchWidget> createState() => _NoMatchWidgetState();
}

class _NoMatchWidgetState extends State<NoMatchWidget> {
  late NoMatchModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoMatchModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('NO_MATCH_COMP_noMatch_ON_INIT_STATE');
      logFirebaseEvent('noMatch_wait__delay');
      await Future.delayed(
        Duration(
          milliseconds: 3000,
        ),
      );
      logFirebaseEvent('noMatch_update_component_state');
      _model.isloading = false;
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Builder(
        builder: (context) {
          if (_model.isloading == false) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 135.0, 20.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Stack(
                                alignment: AlignmentDirectional(0.0, 0.1),
                                children: [
                                  Opacity(
                                    opacity: 0.6,
                                    child: Align(
                                      alignment:
                                          AlignmentDirectional(0.49, 1.25),
                                      child: FaIcon(
                                        FontAwesomeIcons.solidCircle,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 55.0,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.filter_list_sharp,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 50.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'that\'s everyone',
                        textAlign: TextAlign.center,
                        style:
                            FlutterFlowTheme.of(context).displaySmall.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .displaySmallFamily,
                                  fontSize: 27.0,
                                  letterSpacing: 1.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .displaySmallIsCustom,
                                ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 10.0, 20.0, 0.0),
                        child: Text(
                          'you might need to change your preferences or check back in tomorrow',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodyMediumIsCustom,
                              ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                        child: StreamBuilder<UserRecord>(
                          stream: UserRecord.getDocument(currentUserReference!),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: LinearProgressIndicator(
                                  color: Color(0xFFFE99AB),
                                ),
                              );
                            }

                            final changeFiltersUserRecord = snapshot.data!;

                            return FFButtonWidget(
                              onPressed: () async {
                                logFirebaseEvent(
                                    'NO_MATCH_COMP_changeFilters_ON_TAP');
                                logFirebaseEvent('changeFilters_navigate_to');

                                context.pushNamed(
                                    ProfilePreferencesWidget.routeName);
                              },
                              text: 'change my preferences',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 45.0,
                                padding: EdgeInsets.all(0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleSmallFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .titleSmallIsCustom,
                                    ),
                                elevation: 0.0,
                                borderSide: BorderSide(
                                  width: 0.0,
                                ),
                                borderRadius: BorderRadius.circular(40.0),
                                hoverColor: Color(0xC6FE99AB),
                                hoverBorderSide: BorderSide(
                                  color: Color(0xC6FE99AB),
                                  width: 0.0,
                                ),
                                hoverTextColor:
                                    FlutterFlowTheme.of(context).accent1,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Container(
                width: 30.0,
                height: 30.0,
                child: custom_widgets.Circularprogressindicatorwidget(
                  width: 30.0,
                  height: 30.0,
                  color: FlutterFlowTheme.of(context).primary,
                  strokeWidth: 4.0,
                  size: 30.0,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
