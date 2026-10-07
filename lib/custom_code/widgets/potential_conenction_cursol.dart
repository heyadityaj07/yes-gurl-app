// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:yes_gurl/auth/firebase_auth/auth_util.dart';

import 'index.dart';
import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:yes_gurl/profile/profile_settings_report/profile_settings_report_widget.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;

class PotentialConenctionCursol extends StatefulWidget {
  const PotentialConenctionCursol({
    super.key,
    this.width,
    this.height,
    this.advertisements,
  });

  final double? width;
  final double? height;

  final List<AdvertisementRecord>? advertisements;

  @override
  State<PotentialConenctionCursol> createState() =>
      _PotentialConenctionCursolState();
}

class _PotentialConenctionCursolState extends State<PotentialConenctionCursol> {
  late final ScrollController _scrollController;
  Timer? _timer;

  int _currentPage = 0;

  bool _movingForward = true;

  bool _isAutoScrolling = false;
  static const int staticCardCount = 4;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _startAutoScroll();
  }

  @override
  void didUpdateWidget(
    covariant PotentialConenctionCursol oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);

    final oldAds = oldWidget.advertisements ?? [];
    final newAds = widget.advertisements ?? [];

    if (oldAds.length != newAds.length) {
      _resetCarousel();
    }
  }

  void _resetCarousel() {
    _movingForward = true;

    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }

    _startAutoScroll();
  }

  int get _totalItems {
    final ads = widget.advertisements ?? [];
    if ((valueOrDefault<bool>(currentUserDocument?.isPromptPass, false) ==
            true) &&
        (valueOrDefault<bool>(currentUserDocument?.isInterestPass, false) ==
            true)) {
      return staticCardCount + ads.length;
    } else {
      return ads.length;
    }
  }

  void _startAutoScroll() {
    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => _moveCarousel(),
    );
  }

  Future<void> _moveCarousel() async {
    if (!mounted ||
        !_scrollController.hasClients ||
        _totalItems <= 1 ||
        _isAutoScrolling) {
      return;
    }

    final double screenWidth = MediaQuery.sizeOf(context).width;

    final double cardWidth = screenWidth * 0.75;

    const double spacing = 15.0;
    const double leftPadding = 15.0;

    final double itemWidth = cardWidth + spacing;

    final double currentOffset = _scrollController.offset;

    int currentIndex = ((currentOffset + 1) / itemWidth).round();

    currentIndex = currentIndex.clamp(
      0,
      _totalItems - 1,
    );

    int nextIndex;

    if (_movingForward) {
      nextIndex = currentIndex + 1;

      if (nextIndex >= _totalItems) {
        _movingForward = false;
        nextIndex = currentIndex - 1;
      }
    } else {
      nextIndex = currentIndex - 1;

      if (nextIndex < 0) {
        _movingForward = true;
        nextIndex = currentIndex + 1;
      }
    }

    nextIndex = nextIndex.clamp(
      0,
      _totalItems - 1,
    );

    double targetOffset = nextIndex * itemWidth;

    // Because ListView has left padding.
    targetOffset = targetOffset.clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );

    _isAutoScrolling = true;

    try {
      await _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    } finally {
      _isAutoScrolling = false;
    }
  }

  void _moveCarousel1() {
    if (!mounted || !_scrollController.hasClients || _totalItems <= 1) {
      return;
    }

    final double cardWidth = MediaQuery.sizeOf(context).width * 0.75;

    const double spacing = 15;

    final double moveAmount = cardWidth + spacing;

    final double maxScroll = _scrollController.position.maxScrollExtent;

    double currentOffset = _scrollController.offset;

    if (_movingForward) {
      if (currentOffset < maxScroll - 2) {
        double nextOffset = currentOffset + moveAmount;

        if (nextOffset > maxScroll) {
          nextOffset = maxScroll;
        }

        _scrollController.animateTo(
          nextOffset,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      } else {
        _movingForward = false;

        _scrollController.animateTo(
          (currentOffset - moveAmount).clamp(0.0, maxScroll),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    } else {
      if (currentOffset > 2) {
        double nextOffset = currentOffset - moveAmount;

        if (nextOffset < 0) {
          nextOffset = 0;
        }

        _scrollController.animateTo(
          nextOffset,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      } else {
        _movingForward = true;

        _scrollController.animateTo(
          moveAmount.clamp(0.0, maxScroll),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void _onPageChanged(int page) {
    if (!mounted) {
      return;
    }

    _currentPage = page;

    final int lastIndex = _totalItems - 1;

    if (page >= lastIndex) {
      _movingForward = false;
    } else if (page <= 0) {
      _movingForward = true;
    }
  }

  Future<void> _openAdvertisement(
    AdvertisementRecord advertisement,
  ) async {
    final String link = advertisement.aditionalLink.trim();

    if (link.isEmpty) {
      return;
    }

    // ----------------------------------------------------------
    // EXTERNAL WEBSITE
    // Example:
    // https://google.com
    // ----------------------------------------------------------

    if (link.startsWith('http://') || link.startsWith('https://')) {
      final Uri? uri = Uri.tryParse(link);

      if (uri != null) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      }

      return;
    }

    try {
      context.pushNamed(link);
    } catch (e) {
      debugPrint(
        'Unable to open advertisement route: $link',
      );
    }
  }

  void _snapToNearestCard() {
    if (!mounted || !_scrollController.hasClients) {
      return;
    }

    final double cardWidth = MediaQuery.sizeOf(context).width * 0.75;

    const double spacing = 15.0;

    final double itemWidth = cardWidth + spacing;

    final double currentOffset = _scrollController.offset;

    int nearestIndex = (currentOffset / itemWidth).round();

    final int maxIndex = _totalItems - 1;

    nearestIndex = nearestIndex.clamp(
      0,
      maxIndex,
    );

    final double targetOffset = nearestIndex * itemWidth;

    final double maxScroll = _scrollController.position.maxScrollExtent;

    final double finalOffset = targetOffset.clamp(0.0, maxScroll);

    _scrollController.animateTo(
      finalOffset,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  void _snapToCard() {
    if (!mounted || !_scrollController.hasClients || _isAutoScrolling) {
      return;
    }

    final double screenWidth = MediaQuery.sizeOf(context).width;

    final double cardWidth = screenWidth * 0.75;

    const double spacing = 15.0;

    final double itemWidth = cardWidth + spacing;

    final double offset = _scrollController.offset;

    int index = (offset / itemWidth).round();

    index = index.clamp(
      0,
      _totalItems - 1,
    );

    double targetOffset = index * itemWidth;

    targetOffset = targetOffset.clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );

    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_totalItems == 0) {
      return const SizedBox.shrink();
    }

    return Padding(
        padding: const EdgeInsets.only(left: 15),
        child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: NotificationListener<ScrollEndNotification>(
              onNotification: (notification) {
                if (!_isAutoScrolling) {
                  _snapToCard();
                }

                return false;
              },
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                  left: 0,
                  right: 0,
                ),
                itemCount: _totalItems,
                itemBuilder: (context, index) {
                  if (index < staticCardCount) {
                    return _buildStaticCard(
                      context,
                      index,
                    );
                  }

                  final int advertisementIndex = index - staticCardCount;

                  final ads = widget.advertisements ?? [];

                  if (advertisementIndex >= ads.length) {
                    return const SizedBox.shrink();
                  }

                  return _buildAdvertisementCard(
                    context,
                    ads[advertisementIndex],
                  );
                },
              ),
            )));
  }

  Widget _buildStaticCard(
    BuildContext context,
    int index,
  ) {
    Widget card;

    switch (index) {
      case 0:
        card = InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () async {
            context.pushNamed(
              ProfileSettingsReportWidget.routeName,
            );
          },
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.75,
            height: 150,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondary,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsetsDirectional.fromSTEB(
              15,
              20,
              12,
              20,
            ),
            child: Center(
              child: Text(
                'experiencing an issue? report it here and we\'ll take care of it',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).headlineSmallFamily,
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontWeight: FontWeight.w500,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                    ),
              ),
            ),
          ),
        );
        break;

      case 1:
        card = Container(
          width: MediaQuery.sizeOf(context).width * 0.75,
          height: 150,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).tertiary,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsetsDirectional.fromSTEB(
            15,
            20,
            12,
            20,
          ),
          child: Center(
            child: Text(
              'you will see three new women a day',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily:
                        FlutterFlowTheme.of(context).headlineSmallFamily,
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontWeight: FontWeight.w500,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                  ),
            ),
          ),
        );
        break;

      case 2:
        card = Container(
          width: MediaQuery.sizeOf(context).width * 0.75,
          height: 150,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondary,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsetsDirectional.fromSTEB(
            15,
            20,
            12,
            20,
          ),
          child: Center(
            child: Text(
              'you are most likely to get on with compatible and possible types',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily:
                        FlutterFlowTheme.of(context).headlineSmallFamily,
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontWeight: FontWeight.w500,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                  ),
            ),
          ),
        );
        break;

      case 3:
        card = Container(
          width: MediaQuery.sizeOf(context).width * 0.75,
          height: 150,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).tertiary,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsetsDirectional.fromSTEB(
            15,
            20,
            12,
            20,
          ),
          child: Center(
            child: Text(
              'if you see someone you want to connect with, act today',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily:
                        FlutterFlowTheme.of(context).headlineSmallFamily,
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontWeight: FontWeight.w500,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                  ),
            ),
          ),
        );
        break;

      default:
        return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(
        right: 15,
        top: 5,
        bottom: 5,
      ),
      child: card,
    );
  }

  Widget _buildStaticCard1(
    BuildContext context,
    int index,
  ) {
    switch (index) {
      // ========================================================
      // CARD 1
      // ========================================================

      case 0:
        return Padding(
          padding: const EdgeInsets.only(
            right: 15,
            top: 5,
            bottom: 5,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () async {
              context.pushNamed(
                ProfileSettingsReportWidget.routeName,
              );
            },
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsetsDirectional.fromSTEB(
                15,
                20,
                12,
                20,
              ),
              child: Center(
                child: Text(
                  'experiencing an issue? report it here and we\'ll take care of it',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).headlineSmallFamily,
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontWeight: FontWeight.w500,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                      ),
                ),
              ),
            ),
          ),
        );

      // ========================================================
      // CARD 2
      // ========================================================

      case 1:
        return Padding(
          padding: const EdgeInsets.only(
            right: 15,
            top: 5,
            bottom: 5,
          ),
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).tertiary,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsetsDirectional.fromSTEB(
              15,
              20,
              12,
              20,
            ),
            child: Center(
              child: Text(
                'you will see three new women a day',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).headlineSmallFamily,
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontWeight: FontWeight.w500,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                    ),
              ),
            ),
          ),
        );

      // ========================================================
      // CARD 3
      // ========================================================

      case 2:
        return Padding(
          padding: const EdgeInsets.only(
            right: 15,
            top: 5,
            bottom: 5,
          ),
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondary,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsetsDirectional.fromSTEB(
              15,
              20,
              12,
              20,
            ),
            child: Center(
              child: Text(
                'you are most likely to get on with compatible and possible types',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).headlineSmallFamily,
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontWeight: FontWeight.w500,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                    ),
              ),
            ),
          ),
        );

      // ========================================================
      // CARD 4
      // ========================================================

      case 3:
        return Padding(
          padding: const EdgeInsets.only(
            right: 15,
            top: 5,
            bottom: 5,
          ),
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).tertiary,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsetsDirectional.fromSTEB(
              15,
              20,
              12,
              20,
            ),
            child: Center(
              child: Text(
                'if you see someone you want to connect with, act today',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).headlineSmallFamily,
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontWeight: FontWeight.w500,
                      useGoogleFonts:
                          !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                    ),
              ),
            ),
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildAdvertisementCard(
    BuildContext context,
    AdvertisementRecord advertisement,
  ) {
    final bool hasImage = advertisement.isImage;
    final String imagePath = advertisement.image;
    final String message = advertisement.message;

    return Padding(
      padding: const EdgeInsets.only(
        right: 15,
        top: 5,
        bottom: 5,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          _openAdvertisement(advertisement);
        },
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.75,
          height: 150,
          decoration: BoxDecoration(
            color: hasImage
                ? Colors.transparent
                : (advertisement.color ?? const Color(0xFFF2D7D7)),
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              if (hasImage && imagePath.isNotEmpty)
                Positioned.fill(
                  child: custom_widgets.ImageView(
                    width: double.infinity,
                    height: double.infinity,
                    imagePath: advertisement.image,
                  ),
                ),
              Positioned.fill(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).headlineSmallFamily,
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontWeight: FontWeight.w500,
                          useGoogleFonts: !FlutterFlowTheme.of(context)
                              .headlineSmallIsCustom,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdvertisementMessage(
    BuildContext context,
    String message,
  ) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context).headlineSmall.override(
                fontFamily: FlutterFlowTheme.of(context).headlineSmallFamily,
                color: FlutterFlowTheme.of(context).primaryText,
                fontWeight: FontWeight.w500,
                useGoogleFonts:
                    !FlutterFlowTheme.of(context).headlineSmallIsCustom,
              ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
