import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/poll_result_item_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'poll_screen_model.dart';
export 'poll_screen_model.dart';

class PollScreenWidget extends StatefulWidget {
  const PollScreenWidget({super.key});

  static String routeName = 'pollScreen';
  static String routePath = '/pollScreen';

  @override
  State<PollScreenWidget> createState() => _PollScreenWidgetState();
}

class _PollScreenWidgetState extends State<PollScreenWidget> {
  late PollScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PollScreenModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'pollScreen'});
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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              buttonSize: 40.0,
              icon: Icon(
                Icons.arrow_back_ios,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 30.0,
              ),
              onPressed: () async {
                logFirebaseEvent('POLL_SCREEN_arrow_back_ios_ICN_ON_TAP');
                logFirebaseEvent('IconButton_navigate_back');
                context.safePop();
              },
            ),
          ),
          title: Text(
            'yes gurl',
            style: FlutterFlowTheme.of(context).displaySmall.override(
                  fontFamily: FlutterFlowTheme.of(context).displaySmallFamily,
                  fontSize: 25.0,
                  letterSpacing: 0.0,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).displaySmallIsCustom,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(-1.0, 0.0),
                      child: Container(
                        width: 48.0,
                        height: 48.0,
                        decoration: BoxDecoration(
                          color: Color(0x1AFE99AB),
                          borderRadius: BorderRadius.circular(24.0),
                          shape: BoxShape.rectangle,
                        ),
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Icon(
                          Icons.poll_rounded,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 28.0,
                        ),
                      ),
                    ),
                    StreamBuilder<List<PollsRecord>>(
                      stream: queryPollsRecord(
                        queryBuilder: (pollsRecord) => pollsRecord
                            .where(
                              'active',
                              isEqualTo: true,
                            )
                            .orderBy('createdAt', descending: true),
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: LinearProgressIndicator(
                              color: Color(0xFFFE99AB),
                            ),
                          );
                        }
                        List<PollsRecord> listViewPollsRecordList =
                            snapshot.data!;

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewPollsRecordList.length,
                          itemBuilder: (context, listViewIndex) {
                            final listViewPollsRecord =
                                listViewPollsRecordList[listViewIndex];
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment:
                                  (FFCrossAxisAlignment.start).flutterValue,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  listViewPollsRecord.question,
                                  style: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .headlineSmallFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        lineHeight: 1.3,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .headlineSmallIsCustom,
                                      ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(16.0),
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Builder(
                                      builder: (context) {
                                        final options = listViewPollsRecord
                                            .options
                                            .toList();

                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: List.generate(
                                              options.length, (optionsIndex) {
                                            final optionsItem =
                                                options[optionsIndex];
                                            return InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                logFirebaseEvent(
                                                    'POLL_SCREEN_PAGE_PollResultItem_ON_TAP');
                                                if ((listViewPollsRecord
                                                        .voteDetails
                                                        .where((e) =>
                                                            e.userRef ==
                                                            currentUserReference)
                                                        .toList()
                                                        .isNotEmpty) ==
                                                    false) {
                                                  logFirebaseEvent(
                                                      'PollResultItem_backend_call');

                                                  await listViewPollsRecord
                                                      .reference
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'totalVotes': FieldValue
                                                            .increment(1),
                                                        'voteDetails':
                                                            FieldValue
                                                                .arrayUnion([
                                                          getVoteDataFirestoreData(
                                                            createVoteDataStruct(
                                                              userRef:
                                                                  currentUserReference,
                                                              selectedOptionIndex:
                                                                  listViewPollsRecord
                                                                      .optionVotes
                                                                      .elementAtOrNull(
                                                                          optionsIndex),
                                                              selectedOption:
                                                                  optionsItem,
                                                              votedAt:
                                                                  getCurrentTimestamp,
                                                              clearUnsetFields:
                                                                  false,
                                                            ),
                                                            true,
                                                          )
                                                        ]),
                                                      },
                                                    ),
                                                  });
                                                  logFirebaseEvent(
                                                      'PollResultItem_update_page_state');
                                                  _model.vote = true;
                                                  safeSetState(() {});
                                                  logFirebaseEvent(
                                                      'PollResultItem_wait__delay');
                                                  await Future.delayed(
                                                    Duration(
                                                      milliseconds: 4000,
                                                    ),
                                                  );
                                                  logFirebaseEvent(
                                                      'PollResultItem_update_page_state');
                                                  _model.vote = false;
                                                  safeSetState(() {});
                                                } else {
                                                  logFirebaseEvent(
                                                      'PollResultItem_show_snack_bar');
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'You already voted',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                        ),
                                                      ),
                                                      duration: Duration(
                                                          milliseconds: 4000),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                    ),
                                                  );
                                                }
                                              },
                                              child: wrapWithModel(
                                                model: _model
                                                    .pollResultItemModels
                                                    .getModel(
                                                  optionsItem,
                                                  optionsIndex,
                                                ),
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                updateOnChange: true,
                                                child: PollResultItemWidget(
                                                  key: Key(
                                                    'Key2o5_${optionsItem}',
                                                  ),
                                                  label: optionsItem,
                                                  isHighest: true,
                                                  percentage: '42%',
                                                  progressValue:
                                                      functions.getPollProgress(
                                                          listViewPollsRecord
                                                              .voteDetails
                                                              .toList(),
                                                          optionsItem),
                                                  selected: listViewPollsRecord
                                                      .voteDetails
                                                      .where((e) =>
                                                          (e.userRef ==
                                                              currentUserReference) &&
                                                          (e.selectedOption ==
                                                              optionsItem))
                                                      .toList()
                                                      .isNotEmpty,
                                                ),
                                              ),
                                            );
                                          }).divide(SizedBox(height: 16.0)),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(height: 32.0)),
                            );
                          },
                        );
                      },
                    ),
                  ].divide(SizedBox(height: 32.0)),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 1.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 2.0,
                    sigmaY: 2.0,
                  ),
                  child: Visibility(
                    visible: _model.vote,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0x1BFE99AB),
                          borderRadius: BorderRadius.circular(16.0),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'you voted! thanks for having your say 💕',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: FlutterFlowTheme.of(context).primary,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  lineHeight: 1.47,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .bodyMediumIsCustom,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
