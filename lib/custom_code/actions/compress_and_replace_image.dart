// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

Future<String?> compressAndReplaceImage(String? imageUrl) async {
  // Add your function code here!
  // File? originalFile;
  // File? compressedFile;

  // try {
  //   // ✅ Validate input
  //   if (imageUrl == null ||
  //       imageUrl.trim().isEmpty ||
  //       !(imageUrl.startsWith('http://') || imageUrl.startsWith('https://'))) {
  //     return null;
  //   }

  //   // ✅ Get reference
  //   final ref = FirebaseStorage.instance.refFromURL(imageUrl);

  //   // ✅ Get size
  //   final metadata = await ref.getMetadata();
  //   final size = metadata.size ?? 0;

  //   // ✅ Skip small images
  //   if (size < 300 * 1024) {
  //     return imageUrl;
  //   }

  //   // ✅ Decide quality dynamically
  //   int quality;
  //   if (size > 3 * 1024 * 1024) {
  //     quality = 50;
  //   } else if (size > 2 * 1024 * 1024) {
  //     quality = 60;
  //   } else {
  //     quality = 70;
  //   }

  //   // ✅ Download image
  //   final response = await http.get(Uri.parse(imageUrl));
  //   if (response.statusCode != 200) return imageUrl;

  //   final dir = await getTemporaryDirectory();
  //   originalFile =
  //       File('${dir.path}/temp_${DateTime.now().millisecondsSinceEpoch}.jpg');
  //   await originalFile.writeAsBytes(response.bodyBytes);

  //   // ✅ Compress
  //   compressedFile = await FlutterImageCompress.compressAndGetFile(
  //     originalFile.path,
  //     '${dir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg',
  //     quality: quality,
  //     minWidth: 1080,
  //     minHeight: 1080,
  //   );

  //   if (compressedFile == null) return imageUrl;

  //   // ✅ Replace same file
  //   await ref.putFile(
  //     File(compressedFile.path),
  //     SettableMetadata(contentType: 'image/jpeg'),
  //   );

  //   // ✅ Get updated URL
  //   final newUrl = await ref.getDownloadURL();

  //   print("✅ Compressed (${quality}%) → $newUrl");

  //   return newUrl;
  // } catch (e) {
  //   print("❌ Error: $e");
  //   return imageUrl; // fallback
  // } finally {
  //   // ✅ Cleanup
  //   try {
  //     if (originalFile != null && await originalFile.exists()) {
  //       await originalFile.delete();
  //     }
  //     if (compressedFile != null && await compressedFile.exists()) {
  //       await compressedFile.delete();
  //     }
  //   } catch (_) {}
  // }
  return '';
}
