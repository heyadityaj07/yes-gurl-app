import '/backend/backend.dart';
import '/club/event_card/event_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'event_model.dart';
export 'event_model.dart';

/// Create a FlutterFlow mobile screen named `FreeOnlineEventsPage` that
/// **matches the attached reference image as closely as possible**.
///
/// Use the image as the exact visual reference. Do not redesign the layout or
/// add extra UI elements.
///
/// ### Design and Layout
///
/// * Use my existing app theme colors, typography, buttons, and component
/// styles only. Do not introduce custom or hardcoded colors.
/// * Create a clean, feminine, minimal mobile screen with a light background,
/// subtle rounded border, and spacing matching the reference.
/// * Add a compact header with a back arrow on the left and the centered
/// title “Free Online Events”.
/// * Display a vertically scrollable list of event cards beneath the header.
/// * Each event card should have a white or existing theme-surface
/// background, rounded corners, and subtle elevation or borders consistent
/// with the app theme.
/// * Place a small rectangular event image with rounded corners on the left
/// and event information on the right.
/// * Each card must contain:
///
///   * Event title in bold text.
///   * Event date and time on one line, such as “Tue, 22 Apr · 7:00 PM”.
///   * A small video-call icon and the text “Live on Zoom”.
///   * A short event description in smaller text.
///   * A prominent rounded button labeled “Save My Spot”.
/// * Match the image sizes, card dimensions, content alignment, button
/// height, text hierarchy, and spacing shown in the reference.
/// * Use the following as static preview examples:
///
///   1. **Online Yoga & Mindset** — Tue, 22 Apr · 7:00 PM — Live on Zoom — “A
/// calming session to help you relax, recharge and feel your best.”
///   2. **Career Confidence Workshop** — Wed, 30 Apr · 6:00 PM — Live on Zoom
/// — “Build your confidence and take your next step.”
/// * In the working app, load actual event information and images dynamically
/// from the existing backend instead of hardcoding these examples.
///
/// ### Functionality
///
/// * The back arrow navigates to the previous screen.
/// * The “Save My Spot” button should perform the configured
/// event-registration action using the existing app architecture.
/// * Prevent duplicate registrations where applicable and provide feedback
/// after a successful action.
/// * Load events dynamically and display only eligible upcoming events.
/// * Format dates and times using the app's existing date/time conventions.
/// * Handle missing images and empty event lists gracefully.
/// * If no events are available, display a simple message such as “new events
/// coming soon”.
///
/// ### Strict FlutterFlow Widget Rules
///
/// * Do not add a bottom navigation bar, search bar, filters, tabs, or
/// unrelated widgets.
/// * Use existing app theme colors only.
/// * Do not create separate padding widgets; apply padding directly to
/// widgets that support padding.
/// * Do not add extra `Center` or `Align` widgets when the existing widget's
/// alignment property can achieve the same result.
/// * Avoid unnecessary `Container`, `SizedBox`, `Row`, and `Column` wrappers.
/// * Use a `ListView` or equivalent scrollable list with dynamically
/// generated event cards.
/// * Use existing icons, buttons, and components.
/// * Do not add new packages unless necessary and not already available.
///
/// **Important:** Reproduce the attached screenshot as closely as possible:
/// compact header, vertically stacked event cards, image on the left, event
/// details on the right, and a pink-themed full-width “Save My Spot” button
/// within each card. Keep the widget tree minimal and use the existing app
/// theme throughout.
class EventWidget extends StatefulWidget {
  const EventWidget({super.key});

  static String routeName = 'event';
  static String routePath = '/event';

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  late EventModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'event'});
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
                logFirebaseEvent('EVENT_PAGE_arrow_back_ios_ICN_ON_TAP');
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
        body: StreamBuilder<List<OnlineEventsRecord>>(
          stream: queryOnlineEventsRecord(
            queryBuilder: (onlineEventsRecord) => onlineEventsRecord
                .where(
                  'starts_at',
                  isGreaterThanOrEqualTo: getCurrentTimestamp,
                )
                .orderBy('starts_at'),
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
            List<OnlineEventsRecord> columnOnlineEventsRecordList =
                snapshot.data!;

            return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              scrollDirection: Axis.vertical,
              itemCount: columnOnlineEventsRecordList.length,
              separatorBuilder: (_, __) => SizedBox(height: 16.0),
              itemBuilder: (context, columnIndex) {
                final columnOnlineEventsRecord =
                    columnOnlineEventsRecordList[columnIndex];
                return Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: EventCardWidget(
                    key: Key(
                        'Key7ds_${columnIndex}_of_${columnOnlineEventsRecordList.length}'),
                    imageDesc: columnOnlineEventsRecord.image,
                    title: columnOnlineEventsRecord.name,
                    datetime:
                        '${dateTimeFormat("MMMEd", columnOnlineEventsRecord.startsAt)} · ${dateTimeFormat("jm", columnOnlineEventsRecord.startsAt)}',
                    description: columnOnlineEventsRecord.description,
                    url: columnOnlineEventsRecord.externalUrl,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
