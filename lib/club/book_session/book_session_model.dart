import '/club/opportunity_card/opportunity_card_widget.dart';
import '/club/select_session/select_session_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'book_session_widget.dart' show BookSessionWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BookSessionModel extends FlutterFlowModel<BookSessionWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for OpportunityCard.
  late OpportunityCardModel opportunityCardModel;

  @override
  void initState(BuildContext context) {
    opportunityCardModel = createModel(context, () => OpportunityCardModel());
  }

  @override
  void dispose() {
    opportunityCardModel.dispose();
  }
}
