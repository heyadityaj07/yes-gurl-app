import '/backend/backend.dart';
import '/chat/pausealert/pausealert_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';
import 'spotlight_card_model.dart';
export 'spotlight_card_model.dart';

class SpotlightCardWidget extends StatefulWidget {
  const SpotlightCardWidget({
    super.key,
    required this.spotlight,
  });

  final SpotlightRecord? spotlight;

  @override
  State<SpotlightCardWidget> createState() => _SpotlightCardWidgetState();
}

class _SpotlightCardWidgetState extends State<SpotlightCardWidget> {
  late SpotlightCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SpotlightCardModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(24.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Builder(
              builder: (context) => StreamBuilder<List<UserRecord>>(
                stream: queryUserRecord(
                  queryBuilder: (userRecord) => userRecord.where(
                    'uid',
                    isEqualTo: widget!.spotlight?.user?.id,
                  ),
                  singleRecord: true,
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.transparent,
                          ),
                        ),
                      ),
                    );
                  }
                  List<UserRecord> rowUserRecordList = snapshot.data!;
                  final rowUserRecord = rowUserRecordList.isNotEmpty
                      ? rowUserRecordList.first
                      : null;

                  return InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      logFirebaseEvent(
                          'SPOTLIGHT_CARD_COMP_Row_qepu4hbw_ON_TAP');
                      if (rowUserRecord!.isDeactivated) {
                        logFirebaseEvent('Row_alert_dialog');
                        await showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return Dialog(
                              elevation: 0,
                              insetPadding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              alignment: AlignmentDirectional(0.0, 0.0)
                                  .resolve(Directionality.of(context)),
                              child: PausealertWidget(
                                name: rowUserRecord!.displayName,
                              ),
                            );
                          },
                        );
                      } else {
                        logFirebaseEvent('Row_navigate_to');

                        context.pushNamed(
                          PotentialMatchesProfileWidget.routeName,
                          queryParameters: {
                            'userRef': serializeParam(
                              rowUserRecord?.reference,
                              ParamType.DocumentReference,
                            ),
                            'throughUserProfile': serializeParam(
                              'yes',
                              ParamType.String,
                            ),
                          }.withoutNulls,
                        );
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60.0),
                            child: OctoImage(
                              placeholderBuilder: (_) {
                                final blurHash = 'LEHV6nWB2yk8pyo0adR*.7kCMdnj';

                                if (!validateBlurhash(blurHash)) {
                                  return const SizedBox.shrink();
                                }
                                return SizedBox.expand(
                                  child: Image(
                                    image: BlurHashImage(blurHash),
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                              image: CachedNetworkImageProvider(
                                rowUserRecord!.displayImage,
                              ),
                              width: 70.0,
                              height: 60.0,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                'assets/images/error_image.png',
                                width: 70.0,
                                height: 60.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          valueOrDefault<String>(
                            rowUserRecord?.displayName,
                            'User',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleSmallIsCustom,
                              ),
                        ),
                      ].divide(SizedBox(width: 8.0)),
                    ),
                  );
                },
              ),
            ),
            Text(
              widget!.spotlight!.spotlight,
              maxLines: 3,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    color: FlutterFlowTheme.of(context).primaryText,
                    letterSpacing: 0.0,
                    lineHeight: 1.47,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
          ].divide(SizedBox(height: 4.0)),
        ),
      ),
    );
  }
}
