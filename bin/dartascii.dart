// import 'package:dartascii/dartascii.dart' as dartascii;
import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'dart:io';

class Imgfilterobj {
  final String gscale1 =
      "\$@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft/|()1{}[]?-_+~<>i!lI;:,\"^`'. ";

  final String gscale2 = '@%#*+=-:. ';

  final String gscale3 = "BWMoahkbdpqwmZOQLCJUYXzcvunxrjftilI ";
  final List<int> rainbow = [
    0X00d30094,
    0X0082004b,
    0X00ff0000,
    0X0000ff00,
    0X0000ffff,
    0X00007fff,
    0X000000ff
  ];

  final Map<String, int> singlecolormap = {
    'Violet symbols': 0X00d30094,
    'Indigo symbols': 0X0082004b,
    'Blue symbols': 0X00ff0000,
    'Green symbols': 0X0000ff00,
    'Yellow symbols': 0X0000ffff,
    'Orange symbols': 0X00007fff,
    'Red symbols': 0X000000ff,
    'Grey scale': 0X00000000,
    'terminal green text': 0X0026F64A
  };

  Uint8List? bytes;
  double? _vacom;
  double? _vablur;
  Map<String, bool>? filters;
  Map<String, bool>? brc;
  Map<String, bool>? fonts;
  Map<String, bool>? symbols;
  int? c;

  Imgfilterobj(this.bytes, double _vacom, double _vablur, this.filters,
      this.brc, this.fonts, this.symbols, this.c) {
    this._vacom = _vacom;
    this._vablur = _vablur;
  }
}

void photohash(Imgfilterobj imgfobj) {
  img.Image? photo;

  photo = img.decodeImage(imgfobj.bytes!);

  int height = photo!.height;

  int width = photo.width;

  photo = img.copyResize(photo, width: ((width * imgfobj._vacom!).round()));

  height = photo.height;

  width = photo.width;

  List<int> photodata = photo.data;

  img.gaussianBlur(photo, imgfobj._vablur!.round());

  var fillcolor = img.getColor(255, 255, 255);

  if (imgfobj.brc!['black'] == true) {
    fillcolor = img.getColor(0, 0, 0);
  } else if (imgfobj.brc!['red'] == true) {
    fillcolor = img.getColor(255, 0, 0);
  } else if (imgfobj.brc!['green'] == true) {
    fillcolor = img.getColor(0, 255, 0);
  } else if (imgfobj.brc!['blue'] == true) {
    fillcolor = img.getColor(0, 0, 255);
  }

  img.BitmapFont drawfonts = img.arial_14;

  int fontindex = 12;

  if (imgfobj.fonts!['24 px'] == true) {
    drawfonts = img.arial_24;

    fontindex = 22;
  }

  String gscale = imgfobj.gscale1;

  int gscalelen = gscale.length - 1;

  if (imgfobj.symbols!['only symbols'] == true) {
    gscale = imgfobj.gscale2;

    gscalelen = gscale.length - 1;
  } else if (imgfobj.symbols!['only letters'] == true) {
    gscale = imgfobj.gscale3;

    gscalelen = gscale.length - 1;
  }

  img.Image imageg = img.Image(width * fontindex, height * fontindex);

  img.fill(imageg, fillcolor);

  //
  //
  //
  //

  if ((imgfobj.filters!['Normal colors'] == true) ||
      (imgfobj.filters!['sepia'] == true)) {
    if (imgfobj.filters!['sepia'] == true) {
      photo = img.sepia(photo, amount: 1);
      photodata = photo.data;
    }

    for (int i = 0; i < height; i++) {
      for (int j = 0; j < width; j++) {
        //get pixle colors

        int red = photodata[i * width + j] & 0xff;
        int green = (photodata[i * width + j] >> 8) & 0xff;
        int blue = (photodata[i * width + j] >> 16) & 0xff;
        int alpha = (photodata[i * width + j] >> 24) & 0xff;

        //cal avg
        double avg = (blue + red + green + alpha) / 4;

        var k = gscale[((avg * gscalelen) / 255).round()];

        img.drawString(imageg, drawfonts, j * fontindex, i * fontindex, k,
            color: photodata[i * width + j]);
      }
    }
  }

  if ((imgfobj.filters!['photo hash 1'] == true) ||
      (imgfobj.filters!['photo hash 2'] == true) ||
      (imgfobj.filters!['photo hash 3'] == true)) {
    ///
    ////
    ///
    ///
    if (imgfobj.filters!['photo hash 1'] == true) {
      for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
          //get pixle colors

          int red = photodata[i * width + j] & 0xff;
          int green = (photodata[i * width + j] >> 8) & 0xff;
          int blue = (photodata[i * width + j] >> 16) & 0xff;

          //cal avg
          double avg = (blue + red + green) / 3;

          var k = gscale[((avg * gscalelen) / 255).round()];

          int alpha = (((photodata[i * width + j] >> 24) & 0xff) << 24);

          img.drawString(imageg, drawfonts, j * fontindex, i * fontindex, k,
              color: (imgfobj.rainbow[(i * width + j) % 7] ^ alpha));
        }
      }
    } else {
      var rainbow0 = imgfobj.rainbow;
      if (imgfobj.filters!['photo hash 3'] == true) {
        rainbow0 = imgfobj.rainbow.reversed.toList();
      }
      for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
          //get pixle colors

          int red = photodata[i * width + j] & 0xff;
          int green = (photodata[i * width + j] >> 8) & 0xff;
          int blue = (photodata[i * width + j] >> 16) & 0xff;

          //cal avg
          double avg = (blue + red + green) / 3;

          var k = gscale[((avg * gscalelen) / 255).round()];
          int alpha = (((photodata[i * width + j] >> 24) & 0xff) << 24);

          img.drawString(imageg, drawfonts, j * fontindex, i * fontindex, k,
              color: (rainbow0[((avg * 6) / 255).round()]) ^ alpha);
        }
      }
    }
  }
  List<String> singlecolor = imgfobj.singlecolormap.keys.toList();

  for (int k = 0; k < singlecolor.length; k++) {
    if (imgfobj.filters![singlecolor[k]] == true) {
      var printcolor = imgfobj.singlecolormap[singlecolor[k]];

      if ((singlecolor[k] == 'Grey scale') && imgfobj.brc!['black'] == true) {
        printcolor = 0X00ffffff;
      }

      for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
          //get pixle colors

          int red = photodata[i * width + j] & 0xff;
          int green = (photodata[i * width + j] >> 8) & 0xff;
          int blue = (photodata[i * width + j] >> 16) & 0xff;

          //cal avg
          double avg = (blue + red + green) / 3;

          var k = gscale[((avg * gscalelen) / 255).round()];

          int alpha = (((photodata[i * width + j] >> 24) & 0xff) << 24);

          img.drawString(imageg, drawfonts, j * fontindex, i * fontindex, k,
              color: (printcolor! ^ alpha));
        }
      }
    }
  }

  File('haha/image${imgfobj.c}.png').writeAsBytesSync(img.encodePng(imageg));

  // File quotes = File('../asciiart/image.png');
  // print(quotes);

  //  await quotes.writeAsBytes(res);
}
// Future<void> writeimg(k,c) async {

//   File quotes = File('./asciiart/image${c}.png');

//    await quotes.writeAsBytes(k!);

// }
Future<void> main(List<String> arguments) async {
  int counter = 1176;

  double _valuecom = 0.25;

  double _valueblur = 0.0;

  Map<String, bool> filtersmap = {
    'Grey scale': true,
    'Normal colors': false,
    'sepia': false,
    'terminal green text': false,
    'photo hash 1': false,
    'photo hash 2': false,
    'photo hash 3': false,
    'Violet symbols': false,
    'Indigo symbols': false,
    'Blue symbols': false,
    'Green symbols': false,
    'Yellow symbols': false,
    'Orange symbols': false,
    'Red symbols': false,
  };

  // Map<String, bool> typemap = {
  //   'image': true,
  //   'text': false,
  // };

  Map<String, bool> brcmap = {
    'white': true,
    'black': false,
  };

  Map<String, bool> fontmap = {'14 px': true, '24 px': false};

  Map<String, bool> symbolsmap = {
    'letters and symbols': true,
    'only symbols': false,
    'only letters': false
  };

  Uint8List? imagebytes;

  // List<String> images = [''];

  List keysf = filtersmap.keys.toList();

  List keysb = brcmap.keys.toList();

  List keyss = symbolsmap.keys.toList();

  Directory dir = Directory('./image');
// execute an action on each entry
  dir.list(recursive: false).forEach((f) {
    if (f is File) {
      print(f);
      imagebytes = (f).readAsBytesSync();

      for (int i = 0; i < keysf.length; i++) {
        filtersmap.forEach((k, v) => filtersmap[k] = false);

        filtersmap[keysf[i]] = true;

        for (int j = 0; j < keysb.length; j++) {
          brcmap.forEach((k, v) => brcmap[k] = false);

          brcmap[keysb[j]] = true;

          for (int k = 0; k < keyss.length; k++) {
            symbolsmap.forEach((g, v) => symbolsmap[g] = false);

            symbolsmap[keyss[k]] = true;

            var imgfobj = Imgfilterobj(imagebytes!, _valuecom, _valueblur,
                filtersmap, brcmap, fontmap, symbolsmap, counter);
            photohash(imgfobj);
            counter++;
          }
        }
      }
    }
  });
}
