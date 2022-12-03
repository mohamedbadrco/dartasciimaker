import 'dart:typed_data';

import 'package:asciimaker/asciimaker.dart';
import 'package:image/image.dart' as img;
import 'dart:io';
import 'dart:math';

import 'package:image/image.dart';

Future<void> g2g() async {
  Uint8List? gifbytes;
  Directory dir = Directory('./gifin');
  dir.list(recursive: false).forEach((f) async {
    if (f is File) {
      print(f);
      gifbytes = (f).readAsBytesSync();
      var gifyd = img.GifDecoder(gifbytes);
      print(gifyd.info?.frames);
      print(gifyd.info?.numFrames);
    }
  });
}
//   photo = img.copyResize(photo, width: ((width * (60 / height)).round()));

//   height = photo.height;

//   width = photo.width;

//   List<int> photodata = photo.data;

//   retrun;
// }
