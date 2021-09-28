library controls_image;

import 'dart:typed_data';

import 'package:controls_image_android/controls_image_android.dart'
    if (dart.library.js) 'package:controls_image_web/controls_image_web.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imageLib;
import 'package:image_editor/image_editor.dart';

class ImagePicker extends ControlsImage {
  static Future<Uint8List?> resize(Uint8List image, width, height) async {
    imageLib.Image? img = imageLib.decodeImage(image);
    final imageLib.Image _xmg =
        imageLib.copyResize(img!, height: height, width: width);
    return Uint8List.fromList(imageLib.encodePng(_xmg));
  }

  static Future<Uint8List?> crop(context, Uint8List image,
      {double rotateAngle = 0.0,
      required Rect rect,
      EditActionDetails? action,
      int quality = 88}) async {
    ImageEditorOption option = ImageEditorOption();
    option.addOption(ClipOption.fromRect(rect));

    if (action != null) {
      final flipHorizontal = action.flipY;
      final flipVertical = action.flipX;
      option.addOption(
          FlipOption(horizontal: flipHorizontal, vertical: flipVertical));
      if (action.hasRotateAngle) {
        option.addOption(RotateOption(rotateAngle.toInt()));
      }
    }
    option.outputFormat = OutputFormat.png(quality);
    // warm : The problem because flutter plugin(have native code) is not support hot restart/hot reload. So you must exit app and rerun.
    final Uint8List? result = await ImageEditor.editImage(
      image: image,
      imageEditorOption: option,
    );
    return result;
  }

  static Future<ImageFactorResize> factorResize(
      Uint8List image, double widthTo) async {
    return decodeImageFromList(image).then((_img) {
      double w = (_img.width) + 0.0;
      double p = widthTo / w;
      return ImageFactorResize(factor: p, x: w, y: _img.height + 0.0);
    });
  }
}

class ImageFactorResize {
  double? x;
  double? y;
  double? factor;
  ImageFactorResize({this.x, this.y, this.factor});
}
