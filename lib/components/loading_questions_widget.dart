import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'loading_questions_model.dart';
export 'loading_questions_model.dart';

class LoadingQuestionsWidget extends StatefulWidget {
  const LoadingQuestionsWidget({super.key});

  @override
  State<LoadingQuestionsWidget> createState() => _LoadingQuestionsWidgetState();
}

class _LoadingQuestionsWidgetState extends State<LoadingQuestionsWidget> {
  late LoadingQuestionsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoadingQuestionsModel());

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
        color: Colors.transparent,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 120.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0x1AFFFFFF),
                    Color(0x33FFFFFF),
                    Color(0x1AFFFFFF)
                  ],
                  stops: [0.0, 0.5, 1.0],
                  begin: AlignmentDirectional(1.0, 0.0),
                  end: AlignmentDirectional(-1.0, 0),
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  height: 60.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0x1AFFFFFF),
                        Color(0x33FFFFFF),
                        Color(0x1AFFFFFF)
                      ],
                      stops: [0.0, 0.5, 1.0],
                      begin: AlignmentDirectional(1.0, 0.0),
                      end: AlignmentDirectional(-1.0, 0),
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 60.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0x1AFFFFFF),
                        Color(0x33FFFFFF),
                        Color(0x1AFFFFFF)
                      ],
                      stops: [0.0, 0.5, 1.0],
                      begin: AlignmentDirectional(1.0, 0.0),
                      end: AlignmentDirectional(-1.0, 0),
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ].divide(SizedBox(height: 16.0)),
            ),
          ].divide(SizedBox(height: 20.0)),
        ),
      ),
    );
  }
}
