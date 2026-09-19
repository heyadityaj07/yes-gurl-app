// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:http/http.dart' as http;

class ImageView extends StatefulWidget {
  const ImageView({
    super.key,
    this.width,
    this.height,
    this.imagePath,
  });

  final double? width;
  final double? height;
  final String? imagePath;

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  static const String _fallbackAsset = 'assets/images/error_image.png';

  int _loadId = 0;
  bool _loading = true;
  bool _failed = false;
  Uint8List? _bytes;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  void didUpdateWidget(ImageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imagePath != widget.imagePath) {
      _loadImage();
    }
  }

  bool _isHttpUrl(String? path) {
    if (path == null) return false;
    final value = path.trim();
    if (value.isEmpty) return false;
    final uri = Uri.tryParse(value);
    if (uri == null || uri.host.isEmpty) return false;
    final scheme = uri.scheme.toLowerCase();
    return scheme == 'http' || scheme == 'https';
  }

  Future<void> _loadImage() async {
    final loadId = ++_loadId;

    if (!_isHttpUrl(widget.imagePath)) {
      if (!mounted || loadId != _loadId) return;
      setState(() {
        _loading = false;
        _failed = true;
        _bytes = null;
      });
      return;
    }

    setState(() {
      _loading = true;
      _failed = false;
      _bytes = null;
    });

    try {
      final response = await http.get(Uri.parse(widget.imagePath!.trim()));
      if (loadId != _loadId) return;

      if (response.statusCode != 200 || response.bodyBytes.isEmpty) {
        throw Exception('Image download failed');
      }

      // Decode here so Invalid image data is a caught exception,
      // not a FlutterError that Crashlytics marks fatal.
      final codec = await ui.instantiateImageCodec(response.bodyBytes);
      codec.dispose();

      if (!mounted || loadId != _loadId) return;
      setState(() {
        _bytes = response.bodyBytes;
        _loading = false;
        _failed = false;
      });
    } catch (_) {
      if (!mounted || loadId != _loadId) return;
      setState(() {
        _bytes = null;
        _loading = false;
        _failed = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (_loading) {
      child = _shimmerLoader();
    } else if (_failed || _bytes == null) {
      child = _errorWidget();
    } else {
      child = Image.memory(
        _bytes!,
        width: widget.width,
        height: widget.height,
        fit: BoxFit.cover,
        alignment: Alignment.center,
        gaplessPlayback: true,
        errorBuilder: (context, error, stackTrace) => _errorWidget(),
      );
    }

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: child,
      ),
    );
  }

  Widget _shimmerLoader() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        color: Colors.white,
      ),
    );
  }

  Widget _errorWidget() {
    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: Image.asset(
        _fallbackAsset,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.person,
          color: Colors.grey.shade500,
          size: 48,
        ),
      ),
    );
  }
}

//   static const String errorImage =
//       'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/y-e-s-g-u-r-l-test-qjpqs9/assets/uu87cwdo16rt/yes_gurl_logo_socials_(5).png';

//   @override
//   Widget build(BuildContext context) {
//     if (widget.imagePath == null || widget.imagePath!.isEmpty) {
//       return _errorWidget();
//     }

//     return SizedBox(
//       width: widget.width,
//       height: widget.height,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(12),
//         child: CachedNetworkImage(
//           imageUrl: widget.imagePath!,

//           // ✅ FIXED IMAGE STRETCH ISSUE
//           imageBuilder: (context, imageProvider) {
//             return Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: imageProvider,
//                   fit: BoxFit.cover,
//                   alignment: Alignment.center,
//                 ),
//               ),
//             );
//           },

//           // ✅ Shimmer Loader
//           placeholder: (context, url) => _shimmerLoader(),

//           // ✅ Custom Error Image
//           errorWidget: (context, url, error) => _errorWidget(),
//         ),
//       ),
//     );
//   }

//   Widget _shimmerLoader() {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey.shade300,
//       highlightColor: Colors.grey.shade100,
//       child: Container(
//         color: Colors.white,
//       ),
//     );
//   }

//   Widget _errorWidget() {
//     return Container(
//       color: Colors.grey.shade200,
//       child: CachedNetworkImage(
//         imageUrl: errorImage,
//         fit: BoxFit.contain,
//       ),
//     );
//   }
// }
