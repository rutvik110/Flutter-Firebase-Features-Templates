import 'dart:io';

import 'package:flutter/painting.dart';

///Credit Goes to @liroKrankka for this amazing class
///Read about it here: https://iiro.dev/adaptive-images/

class AdaptiveImageProvider extends ImageProvider {
  AdaptiveImageProvider(String url) : _delegate = _resolve(url);
  final ImageProvider _delegate;

  static ImageProvider _resolve(String url) {
    final uri = Uri.parse(url);
    switch (uri.scheme) {
      case 'asset':
        final path = uri.toString().replaceFirst('asset://', '');
        return AssetImage(path);
      case 'file':
        final file = File.fromUri(uri);
        return FileImage(file);
      case 'http':
      case 'https':
        return NetworkImage(url);
      default:
        throw ArgumentError('Unsupported scheme: ${uri.scheme}');
    }
  }

  @override
  ImageStreamCompleter load(Object key, DecoderCallback decode) =>
      _delegate.load(key, decode);

  @override
  Future<Object> obtainKey(ImageConfiguration configuration) =>
      _delegate.obtainKey(configuration);
}
