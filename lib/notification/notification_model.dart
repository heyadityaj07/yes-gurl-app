import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/delete_notifications_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/link_up/no_data_copy/no_data_copy_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'notification_widget.dart' show NotificationWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotificationModel extends FlutterFlowModel<NotificationWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for noDataCopy component.
  late NoDataCopyModel noDataCopyModel;

  @override
  void initState(BuildContext context) {
    noDataCopyModel = createModel(context, () => NoDataCopyModel());
  }

  @override
  void dispose() {
    noDataCopyModel.dispose();
  }

  /// Action blocks.
  Future notificationActionBlock(
    BuildContext context, {
    required NotificationRecord? notification,
  }) async {
    ChatRecord? chat;
    EventsRecord? eventCopy;

    logFirebaseEvent('notificationActionBlock_custom_action');
    await actions.markNotificationAsSeen(
      notification,
      currentUserReference,
    );
    if (notification?.notificationType == 'chat') {
      logFirebaseEvent('notificationActionBlock_navigate_to');

      context.pushNamed(
        ChatConnectionsWidget.routeName,
        queryParameters: {
          'chatRef': serializeParam(
            notification?.chat,
            ParamType.DocumentReference,
          ),
        }.withoutNulls,
      );
    } else if (notification?.notificationType == 'request') {
      logFirebaseEvent('notificationActionBlock_backend_call');
      chat = await ChatRecord.getDocumentOnce(notification!.chat!);
      if (chat != null) {
        if (chat!.isRequested) {
          logFirebaseEvent('notificationActionBlock_navigate_to');

          context.pushNamed(
            ChatRequestWidget.routeName,
            queryParameters: {
              'chatRef': serializeParam(
                notification?.chat,
                ParamType.DocumentReference,
              ),
            }.withoutNulls,
          );
        } else {
          logFirebaseEvent('notificationActionBlock_navigate_to');

          context.pushNamed(
            ChatConnectionsWidget.routeName,
            queryParameters: {
              'chatRef': serializeParam(
                notification?.chat,
                ParamType.DocumentReference,
              ),
            }.withoutNulls,
          );
        }
      } else {
        logFirebaseEvent('notificationActionBlock_show_snack_bar');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'You declined this chat request',
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).secondary,
          ),
        );
      }
    } else if (notification?.notificationType == 'delete Linkup') {
      logFirebaseEvent('notificationActionBlock_navigate_to');

      context.pushNamed(LinkUpWidget.routeName);
    } else if (notification?.linkup != null) {
      logFirebaseEvent('notificationActionBlock_backend_call');
      eventCopy = await EventsRecord.getDocumentOnce(notification!.linkup!);
      if (eventCopy?.role == 'admin') {
        logFirebaseEvent('notificationActionBlock_navigate_to');

        context.pushNamed(
          AdminLinkUpDetailsWidget.routeName,
          queryParameters: {
            'eventDoc': serializeParam(
              eventCopy,
              ParamType.Document,
            ),
          }.withoutNulls,
          extra: <String, dynamic>{
            'eventDoc': eventCopy,
          },
        );
      } else {
        logFirebaseEvent('notificationActionBlock_navigate_to');

        context.pushNamed(
          LinkUpDetailsWidget.routeName,
          queryParameters: {
            'eventRef': serializeParam(
              eventCopy,
              ParamType.Document,
            ),
          }.withoutNulls,
          extra: <String, dynamic>{
            'eventRef': eventCopy,
          },
        );
      }
    } else if (notification?.notificationType == 'admin') {
      if (!notification!.seenList.contains(currentUserReference)) {
        logFirebaseEvent('notificationActionBlock_backend_call');

        await notification!.reference.update({
          ...mapToFirestore(
            {
              'seen_list': FieldValue.arrayUnion([currentUserReference]),
            },
          ),
        });
      }
      logFirebaseEvent('notificationActionBlock_navigate_to');

      context.pushNamed(
        LinkUpWidget.routeName,
        queryParameters: {
          'tabIndex': serializeParam(
            3,
            ParamType.int,
          ),
        }.withoutNulls,
      );
    }
  }
}
