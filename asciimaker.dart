import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'dart:io';
import 'dart:math';

import 'package:image/image.dart';

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
  bool? q;

  Imgfilterobj(this.bytes, double _vacom, double _vablur, this.filters,
      this.brc, this.fonts, this.symbols, this.c, this.q) {
    this._vacom = _vacom;
    this._vablur = _vablur;
  }
}

class Imgfilterobjtxt {
  final String gscale1 =
      "\$@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft/|()1{}[]?-_+~<>i!lI;:,\"^`'. ";

  final String gscale2 = '@%#*+=-:. ';

  final String gscale3 = "BWMoahkbdpqwmZOQLCJUYXzcvunxrjftilI ";
  Uint8List? bytes;
  Map<String, bool>? symbols;
  int clos = 100;

  Imgfilterobjtxt(this.bytes, this.clos, this.symbols) {
    // Ignored
  }
}

Future<void> photohashtxt(Imgfilterobjtxt imgfobjtxt) async {
  List<String> res = [''];

  img.Image? photo;
  String name = 'textascii';

  photo = img.decodeImage(imgfobjtxt.bytes!);

  photo = img.copyResize(photo!, width: imgfobjtxt.clos);

  int height = photo.height;

  int width = photo.width;

  List<int> photodata = photo.data;

  String gscale = imgfobjtxt.gscale1;

  int gscalelen = gscale.length - 1;

  if (imgfobjtxt.symbols!['only symbols'] == true) {
    gscale = imgfobjtxt.gscale2;

    gscalelen = gscale.length - 1;
  } else if (imgfobjtxt.symbols!['only letters'] == true) {
    gscale = imgfobjtxt.gscale3;

    gscalelen = gscale.length - 1;
  }

  for (int i = 0; i < height; i++) {
    String row = '';
    for (int j = 0; j < width; j++) {
      //get pixle colors

      int red = photodata[i * width + j] & 0xff;
      int green = (photodata[i * width + j] >> 8) & 0xff;
      int blue = (photodata[i * width + j] >> 16) & 0xff;
      int alpha = (photodata[i * width + j] >> 24) & 0xff;

      //cal avg
      double avg = (blue + red + green + alpha) / 4;

      String k = gscale[((avg * gscalelen) / 255).round()];
      row = row + k;
    }
    res.add(row);
  }

  // List<String> res1 = res;

  int lentxt = res.length;

  File f = File('haha/$name.txt');

  for (int i = 0; i < lentxt; i++) {
    await f.writeAsString("${res[i]} \n", mode: FileMode.append);
    print(res[i]);
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

  int fontindex = 13;

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

  if (imgfobj.q! == true) {
    for (int i = 0; i < height; i++) {
      for (int j = 0; j < width; j++) {
        var g = Random(i * j);

        int index = g.nextInt(37);

        if (index > 32) {
          index = index - 32;

          img.drawLine(
              imageg,
              j * fontindex,
              i * fontindex - 6,
              j * fontindex + index * 13,
              i * fontindex - 6,
              imgfobj.rainbow[g.nextInt(7)] ^ 0x88000000,
              thickness: 13);
        }
      }
    }
  }

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
        double avg = (blue + red + green) / 3;

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

          int alpha = (((photodata[i * width + j] >> 24)) << 24);

          img.drawString(imageg, drawfonts, j * fontindex, i * fontindex, k,
              color: (imgfobj.rainbow[(i * width + j) % 7] | alpha));
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

          int alpha = (((photodata[i * width + j] >> 24)) << 24);

          img.drawString(imageg, drawfonts, j * fontindex, i * fontindex, k,
              color: (printcolor! | alpha));
        }
      }
    }

    if (imgfobj.filters!['Rainbow Flag'] == true ||
        imgfobj.filters!['Rainbow Flag Reversed'] == true) {
      var rainbow0 = imgfobj.rainbow;

      if (imgfobj.filters!['Rainbow Flag Reversed'] == true) {
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

          int alpha = (((photodata[i * width + j] >> 24)) << 24);

          img.drawString(imageg, drawfonts, j * fontindex, i * fontindex, k,
              color: (rainbow0[i ~/ (height / 7)] | alpha));
        }
      }
    }

    if (imgfobj.filters!['Rainbow Random'] == true) {
      var rainbow0 = imgfobj.rainbow;

      var g = Random(45);

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
              color: (rainbow0[g.nextInt(7)] ^ alpha));
        }
      }
    }

    if (imgfobj.filters!['Random colors'] == true) {
      var g = Random(photodata[Random(56).nextInt(256)]);

      for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
          //get pixle colors

          int red = photodata[i * width + j] & 0xff;
          int green = (photodata[i * width + j] >> 8) & 0xff;
          int blue = (photodata[i * width + j] >> 16) & 0xff;

          //cal avg
          double avg = (blue + red + green) / 3;

          var color = 0X00000000 |
              g.nextInt(256) |
              (g.nextInt(256)) << 8 |
              (g.nextInt(256) << 16);

          var k = gscale[((avg * gscalelen) / 255).round()];

          int alpha = (((photodata[i * width + j] >> 24) & 0xff) << 24);

          img.drawString(imageg, drawfonts, j * fontindex, i * fontindex, k,
              color: (color ^ alpha));
        }
      }
    }
    if (imgfobj.filters!['cmatrix'] == true ||
        imgfobj.filters!['cmatrix modren'] == true) {
      var g = Random(56);

      int index = g.nextInt(21) + 20;

      bool visable = true;

      var color = 0X0026F64A;

      if (imgfobj.filters!['cmatrix modren'] == true) {
        //#87FFC5
        img.fill(imageg, 0xff242120);
        color = 0X00C5FF87;
      }

      for (int i = 0; i < width; i++) {
        for (int j = 0; j < height; j++) {
          //get pixle colors

          int red = photodata[j * width + i] & 0xff;
          int green = (photodata[j * width + i] >> 8) & 0xff;
          int blue = (photodata[j * width + i] >> 16) & 0xff;

          //cal avg
          double avg = (blue + red + green) / 3;

          index = index - 1;

          if (index == 0) {
            if (visable == true) {
              index = g.nextInt(21) + 2;
              visable = false;
            } else {
              index = g.nextInt(21) + 20;
              visable = true;
            }
          }

          var k = gscale[((avg * gscalelen) / 255).round()];

          int alpha = (((photodata[j * width + i] >> 24) & 0xff) << 24);

          if (visable == true) {
            if (index == 1) {
              img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
                  color: (0X00ffffff ^ alpha));
            } else {
              img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
                  color: (color ^ alpha));
            }
          }
        }
      }
    }

    if (imgfobj.filters!['cmatrix full colors'] == true) {
      var g = Random(56);

      int index = g.nextInt(21) + 20;

      bool visable = true;

      var color = 0X0026F64A;

      for (int i = 0; i < width; i++) {
        for (int j = 0; j < height; j++) {
          //get pixle colors

          int red = photodata[j * width + i] & 0xff;
          int green = (photodata[j * width + i] >> 8) & 0xff;
          int blue = (photodata[j * width + i] >> 16) & 0xff;

          //cal avg
          double avg = (blue + red + green) / 3;

          index = index - 1;

          if (index == 0) {
            if (visable == true) {
              index = g.nextInt(21) + 2;
              visable = false;
            } else {
              index = g.nextInt(21) + 20;
              visable = true;
            }
          }

          var k = gscale[((avg * gscalelen) / 255).round()];

          int alpha = (((photodata[j * width + i] >> 24) & 0xff) << 24);

          if (visable == true) {
            if (index == 1) {
              img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
                  color: (0X00ffffff ^ alpha));
            } else {
              img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
                  color: (photodata[j * width + i]));
            }
          }
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

void cmatrixframs(Imgfilterobj imgfobj) {
  int fconter = 0;
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

  int fontindex = 13;

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

  List<List<List<int>>> matrix = [];

  var g = Random(56);

  int index = g.nextInt(21) + 20;

  bool visable = true;

  var color = 0X0026F64A;

  for (int i = 0; i < width; i++) {
    List<List<int>> line = [];
    line.add([1, index]);

    for (int j = 0; j < height; j++) {
      //get pixle colors

      int red = photodata[j * width + i] & 0xff;
      int green = (photodata[j * width + i] >> 8) & 0xff;
      int blue = (photodata[j * width + i] >> 16) & 0xff;

      //cal avg
      double avg = (blue + red + green) / 3;

      index = index - 1;

      if (index == 0) {
        if (visable == true) {
          index = g.nextInt(21) + 2;
          visable = false;
        } else {
          index = g.nextInt(21) + 20;
          visable = true;
        }
      }

      var k = gscale[((avg * gscalelen) / 255).round()];

      // int alpha = (((photodata[j * width + i] >> 24) & 0xff) << 24);

      if (visable == true) {
        if (index == 1) {
          line.add([2, ((avg * gscalelen) / 255).round()]);
          // img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
          // color: (0X00ffffff ^ alpha));

        } else {
          line.add([1, ((avg * gscalelen) / 255).round()]);

          // img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
          //     color: (color ^ alpha));
        }
      } else {
        line.add([0, ((avg * gscalelen) / 255).round()]);
      }
    }
    matrix.add(line);
  }

  // File('haha/fram${fconter}.png').writeAsBytesSync(img.encodePng(imageg));
  // fconter += 1;

  for (int o = 0; o < height; o++) {
    img.Image imageg = img.Image(width * fontindex, height * fontindex);

    img.fill(imageg, fillcolor);

    for (int i = 0; i < width; i++) {
      var tem = matrix[i][height - 1][0];

      matrix[i][height - 1][0] = matrix[i][0][0];

      for (int j = 0; j < height - 2; j++) {
        matrix[i][j][0] = matrix[i][j + 1][0];
      }

      matrix[i][height - 2][0] = tem;
    }

    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        //get pixle colors

        var k = gscale[matrix[i][j][1]];
        int alpha = (((photodata[j * width + i] >> 24)) << 24);

        if (matrix[i][j][0] != 0) {
          if (matrix[i][j][0] == 2) {
            img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
                color: (0X00ffffff | alpha));
          } else {
            img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
                color: (color | alpha));
          }
        }
      }
    }

    File('image/frame${fconter}.png').writeAsBytesSync(img.encodePng(imageg));
    fconter += 1;
  }

  //  print(matrix[0].last[0]);
}

void cmatrixframscolor(Imgfilterobj imgfobj) {
  int fconter = 0;
  img.Image? photo;

  final folderName = "gifout";
  final path = Directory("$folderName");
  path.create();

  photo = img.decodeImage(imgfobj.bytes!);

  int height = photo!.height;

  int width = photo.width;

  photo = img.copyResize(photo, width: ((width * (60 / height)).round()));

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

  int fontindex = 13;

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

  List<List<List<int>>> matrix = [];

  var g = Random(56);

  int index = g.nextInt(21) + 20;

  bool visable = true;

  var color = 0X0026F64A;

  for (int i = 0; i < width; i++) {
    List<List<int>> line = [];

    for (int j = 0; j < height; j++) {
      //get pixle colors

      int red = photodata[j * width + i] & 0xff;
      int green = (photodata[j * width + i] >> 8) & 0xff;
      int blue = (photodata[j * width + i] >> 16) & 0xff;

      //cal avg
      double avg = (blue + red + green) / 3;

      index = index - 1;

      if (index == 0) {
        if (visable == true) {
          index = g.nextInt(21) + 2;
          visable = false;
        } else {
          index = g.nextInt(21) + 20;
          visable = true;
        }
      }

      var k = gscale[((avg * gscalelen) / 255).round()];

      // int alpha = (((photodata[j * width + i] >> 24) & 0xff) << 24);

      if (visable == true) {
        if (index == 1) {
          line.add([2, ((avg * gscalelen) / 255).round()]);
          // img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
          // color: (0X00ffffff ^ alpha));

        } else {
          line.add([1, ((avg * gscalelen) / 255).round()]);

          // img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
          //     color: (color ^ alpha));
        }
      } else {
        line.add([0, ((avg * gscalelen) / 255).round()]);
      }
    }
    matrix.add(line);
  }

  // File('haha/fram${fconter}.png').writeAsBytesSync(img.encodePng(imageg));
  // fconter += 1; 0xff242120
  var gife = GifEncoder(delay: 7);

  for (int o = 0; o < height; o++) {
    img.Image imageg = img.Image(width * fontindex, height * fontindex);
    if (imgfobj.filters!['cmatrix modren'] == true) {
      img.fill(
          imageg,
          img.getColor(0xff242120 & 0xff, (0xff242120 >> 8) & 0xff,
              (0xff242120 >> 16) & 0xff));
    } else {
      img.fill(imageg, fillcolor);
    }

    for (int i = 0; i < width; i++) {
      var tem = matrix[i][0][0];

      matrix[i][0][0] = matrix[i][height - 1][0];

      for (int j = height - 1; j > 1; j--) {
        matrix[i][j][0] = matrix[i][j - 1][0];
      }

      matrix[i][1][0] = tem;
    }
    var g = Random(45);
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        //get pixle colors
        var k = gscale[matrix[i][j][1]];
        int alpha = (((photodata[j * width + i] >> 24) & 0xff) << 24);

        if (matrix[i][j][0] != 0) {
          if (matrix[i][j][0] == 2) {
            if (imgfobj.brc!['black'] == true) {
              if (imgfobj.filters!['Grey scale'] == true) {
                img.drawString(
                    imageg, drawfonts, i * fontindex, j * fontindex, k,
                    color: (0X00CBC0FF ^ alpha));
              } else {
                img.drawString(
                    imageg, drawfonts, i * fontindex, j * fontindex, k,
                    color: (0X00ffffff ^ alpha));
              }
            } else {
              img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
                  color: (0X00CBC0FF ^ alpha));
            }
          } else {
            if (imgfobj.filters!['Normal colors'] == true) {
              img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
                  color: photodata[j * width + i]);
            } else if (imgfobj.filters!['sepia'] == true) {
              photo = img.sepia(photo!, amount: 1);
              photodata = photo.data;
              img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
                  color: photodata[j * width + i]);
            } else if (imgfobj.filters!['photo hash 2'] == true) {
              var rainbow0 = imgfobj.rainbow;
              img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
                  color: (rainbow0[
                          ((((matrix[i][j][1] / gscalelen)) * 6)).round()]) ^
                      alpha);
            } else if (imgfobj.filters!['photo hash 3'] == true) {
              var rainbow0 = imgfobj.rainbow.reversed.toList();
              img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
                  color: (rainbow0[
                          ((((matrix[i][j][1] / gscalelen)) * 6)).round()]) ^
                      alpha);
            } else if (imgfobj.filters!['cmatrix modren'] == true) {
              color = 0X00C5FF87;
              img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
                  color: color ^ alpha);
            } else if (imgfobj.filters!['Rainbow Random'] == true) {
              img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
                  color: (imgfobj.rainbow[g.nextInt(7)] ^ alpha));
            } else if (imgfobj.filters!['Random colors'] == true) {
              var color = 0X00000000 |
                  g.nextInt(256) |
                  (g.nextInt(256)) << 8 |
                  (g.nextInt(256) << 16);
              img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
                  color: color ^ alpha);
            } else if (imgfobj.filters!['Grey scale'] == true) {
              var printcolor = 0X00000000;
              if (imgfobj.brc!['black'] == true) {
                printcolor = 0X00ffffff;
              }
                  
              img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
                  color: (printcolor ^ alpha));
            }
          }
        }
      }
    }

    gife.addFrame(imageg);
  }
  File('$folderName/gif${imgfobj.c}.gif').writeAsBytesSync(gife.finish()!);

  //  print(matrix[0].last[0]);
}

void fadeframes(Imgfilterobj imgfobj) {
  int fconter = 0;
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

  int fontindex = 13;

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

  List<int> lints = [1, 2, 4, 8, 16, 32, 64, height * width];

  for (int o = 0; o < lints.length; o++) {
    img.Image imageg = img.Image(width * fontindex, height * fontindex);

    img.fill(imageg, fillcolor);

    for (int i = 0; i < height; i++) {
      for (int j = 0; j < width; j++) {
        //get pixle colors

        int red = photodata[i * width + j] & 0xff;
        int green = (photodata[i * width + j] >> 8) & 0xff;
        int blue = (photodata[i * width + j] >> 16) & 0xff;

        //cal avg
        double avg = (blue + red + green) / 3;

        var k = gscale[((avg * gscalelen) / 255).round()];
        if (i % lints[o] == 0 && j % lints[o] == 0) {
          img.drawString(imageg, drawfonts, j * fontindex, i * fontindex, k,
              color: photodata[i * width + j]);
        }
      }
    }

    File('sframes/frame${fconter}.png').writeAsBytesSync(img.encodePng(imageg));
    fconter += 1;
  }
}

void randomcolorsgif(Imgfilterobj imgfobj) {
  int fconter = 0;
  img.Image? photo;

  final folderName = "gifout";
  final path = Directory("$folderName");
  path.create();

  photo = img.decodeImage(imgfobj.bytes!);

  int height = photo!.height;

  int width = photo.width;

  photo = img.copyResize(photo, width: ((width * (60 / height)).round()));

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

  int fontindex = 13;

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

  List<List<List<int>>> matrix = [];

  var g = Random(56);

  int index = g.nextInt(21) + 20;

  bool visable = true;

  var color = 0X0026F64A;

  for (int i = 0; i < width; i++) {
    List<List<int>> line = [];

    for (int j = 0; j < height; j++) {
      //get pixle colors

      int red = photodata[j * width + i] & 0xff;
      int green = (photodata[j * width + i] >> 8) & 0xff;
      int blue = (photodata[j * width + i] >> 16) & 0xff;

      //cal avg
      double avg = (blue + red + green) / 3;

      var k = gscale[((avg * gscalelen) / 255).round()];

      var color = 0X00000000 |
          g.nextInt(256) |
          (g.nextInt(256)) << 8 |
          (g.nextInt(256) << 16);

      int alpha = (((photodata[j * width + i] >> 24) & 0xff) << 24);
      // print(alpha);
      // print(((color | alpha) >> 24) << 24);

      line.add([color | alpha, ((avg * gscalelen) / 255).round()]);
    }
    matrix.add(line);
  }

  // File('haha/fram${fconter}.png').writeAsBytesSync(img.encodePng(imageg));
  // fconter += 1;
  var gife = GifEncoder(delay: 7);

  for (int o = 0; o < height; o++) {
    img.Image imageg = img.Image(width * fontindex, height * fontindex);

    img.fill(imageg, fillcolor);

    for (int i = 0; i < width; i++) {
      var tem = matrix[i][0][0];

      matrix[i][0][0] = matrix[i][height - 1][0];

      for (int j = height - 1; j > 1; j--) {
        matrix[i][j][0] = matrix[i][j - 1][0];
      }

      matrix[i][1][0] = tem;
    }

    for (int i = 0; i < height; i++) {
      var tem = matrix[0][i][0];

      matrix[0][i][0] = matrix[width - 1][i][0];

      for (int j = width - 1; j > 1; j--) {
        matrix[j][i][0] = matrix[j - 1][i][0];
      }

      matrix[1][i][0] = tem;
    }

    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        //get pixle colors

        var k = gscale[matrix[i][j][1]];
        int alpha = (((photodata[j * width + i] >> 24) & 0xff) << 24);

        img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
            color: matrix[i][j][0]);
      }
    }

    gife.addFrame(imageg);
  }
  File('$folderName/gif${imgfobj.c}.gif').writeAsBytesSync(gife.finish()!);

  //  print(matrix[0].last[0]);
}

void rainbowgif(Imgfilterobj imgfobj) {
  int fconter = 0;
  img.Image? photo;

  final folderName = "gifout";
  final path = Directory("$folderName");
  path.create();

  photo = img.decodeImage(imgfobj.bytes!);

  int height = photo!.height;

  int width = photo.width;

  photo = img.copyResize(photo, width: ((width * (60 / height)).round()));

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

  int fontindex = 13;

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

  List<List<List<int>>> matrix = [];

  var g = Random(56);

  int index = g.nextInt(21) + 20;

  bool visable = true;

  var color = 0X0026F64A;

  for (int i = 0; i < width; i++) {
    List<List<int>> line = [];

    for (int j = 0; j < height; j++) {
      //get pixle colors

      int red = photodata[j * width + i] & 0xff;
      int green = (photodata[j * width + i] >> 8) & 0xff;
      int blue = (photodata[j * width + i] >> 16) & 0xff;

      //cal avg
      double avg = (blue + red + green) / 3;

      var k = gscale[((avg * gscalelen) / 255).round()];

      var color = 0X00000000 |
          g.nextInt(256) |
          (g.nextInt(256)) << 8 |
          (g.nextInt(256) << 16);

      int alpha = (((photodata[j * width + i] >> 24) & 0xff) << 24);
      // print(alpha);
      // print(((color | alpha) >> 24) << 24);

      line.add([
        imgfobj.rainbow[j ~/ (height / 7)] ^ alpha,
        ((avg * gscalelen) / 255).round()
      ]);
    }
    matrix.add(line);
  }

  // File('haha/fram${fconter}.png').writeAsBytesSync(img.encodePng(imageg));
  // fconter += 1;
  var gife = GifEncoder(delay: 7);

  for (int o = 0; o < height; o++) {
    img.Image imageg = img.Image(width * fontindex, height * fontindex);

    img.fill(imageg, fillcolor);

    for (int i = 0; i < width; i++) {
      var tem = matrix[i][0][0];

      matrix[i][0][0] = matrix[i][height - 1][0];

      for (int j = height - 1; j > 1; j--) {
        matrix[i][j][0] = matrix[i][j - 1][0];
      }

      matrix[i][1][0] = tem;
    }

    for (int i = 0; i < height; i++) {
      var tem = matrix[0][i][0];

      matrix[0][i][0] = matrix[width - 1][i][0];

      for (int j = width - 1; j > 1; j--) {
        matrix[j][i][0] = matrix[j - 1][i][0];
      }

      matrix[1][i][0] = tem;
    }

    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        //get pixle colors

        var k = gscale[matrix[i][j][1]];
        int alpha = (((photodata[j * width + i] >> 24) & 0xff) << 24);

        img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
            color: matrix[i][j][0]);
      }
    }

    gife.addFrame(imageg);
  }
  File('$folderName/gif${imgfobj.c}.gif').writeAsBytesSync(gife.finish()!);

  //  print(matrix[0].last[0]);
}

void a(Imgfilterobj imgfobj) {
  int fconter = 0;
  img.Image? photo;

  final folderName = "gifout";
  final path = Directory("$folderName");
  path.create();

  photo = img.decodeImage(imgfobj.bytes!);

  int height = photo!.height;

  int width = photo.width;

  photo = img.copyResize(photo, width: ((width * (60 / height)).round()));

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

  int fontindex = 13;

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

  var g = Random(5684949);

  var gife = GifEncoder(delay: 7);

  List<int> gl = [];

  for (int o = 0; o < height; o++) {
    int indexg = 0;
    img.Image imageg = img.Image(width * fontindex, height * fontindex);

    img.fill(imageg, fillcolor);

    while (indexg < width) {
      int ig = g.nextInt(photodata.length);
      if (!gl.contains(ig)) {
        gl.add(ig);
        indexg += 1;
      }
    }
    // print(width);
    // print(height);
    // print(gl.length);
    // print(photodata.length);

    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        //get pixle colors
        int red = photodata[j * width + i] & 0xff;
        int green = (photodata[j * width + i] >> 8) & 0xff;
        int blue = (photodata[j * width + i] >> 16) & 0xff;
        // int alpha = (photodata[j * width + i] >> 24) & 0xff;

        //cal avg
        double avg = (blue + red + green) / 3;

        var k = gscale[((avg * gscalelen) / 255).round()];

        if (gl.contains(j * width + i)) {
          img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
              color: photodata[j * width + i]);
        }
      }
    }

    gife.addFrame(imageg);
  }
  File('$folderName/gif${imgfobj.c}.gif').writeAsBytesSync(gife.finish()!);

  //  print(matrix[0].last[0]);
}

void matrixm(Imgfilterobj imgfobj) {
  int fconter = 0;
  img.Image? photo;

  final folderName = "gifout";
  final path = Directory("$folderName");
  path.create();

  photo = img.decodeImage(imgfobj.bytes!);

  int height = photo!.height;

  int width = photo.width;

  photo = img.copyResize(photo, width: ((width * (60 / height)).round()));

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

  int fontindex = 13;

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

  List<List<List<int>>> matrix = [];

  var g = Random(56);

  // File('haha/fram${fconter}.png').writeAsBytesSync(img.encodePng(imageg));
  // fconter += 1;
  var gife = GifEncoder(delay: 7);
  List<int> alphas = [
    0x00000000,
    0x44000000,
    0x88000000,
    0xcc000000,
    0xff000000,
    0xffffffff,
    0xff000000,
  ];
  List<List<int>> gl = [];

  for (int o = 0; o < width; o++) {
    int indexg = 0;
    img.Image imageg = img.Image(width * fontindex, height * fontindex);

    img.fill(imageg, fillcolor);
    List<int> go = [];
    go.add(0);

    while (go.length < width) {
      int ig = g.nextInt(photodata.length);
      go.add(ig);
    }
    gl.add(go);

    for (int i = 0; i < gl.length; i++) {
      if (gl[i][0] == 6) {
        gl.removeAt(i);
      }
    }

    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        //get pixle colors
        bool indexbool = false;
        int red = photodata[j * width + i] & 0xff;

        int green = (photodata[j * width + i] >> 8) & 0xff;
        int blue = (photodata[j * width + i] >> 16) & 0xff;
        // int alpha = (photodata[j * width + i] >> 24) & 0xff;

        //cal avg
        double avg = (blue + red + green) / 3;

        var k = gscale[((avg * gscalelen) / 255).round()];

        for (int i = 0; i < gl.length; i++) {
          if (gl[i].contains(j * width + i)) {
            indexbool = true;

            var color = alphas[gl[i][0]] | red | (green << 8) | (blue << 16);

            img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
                color: color);
            break;
          }
        }
        if (!indexbool) {
          img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
              color: photodata[j * width + i]);
        }
      }
    }

    for (int i = 0; i < gl.length; i++) {
      gl[i][0] += 1;
    }

    gife.addFrame(imageg);
  }
  File('$folderName/gif${imgfobj.c}.gif').writeAsBytesSync(gife.finish()!);

  //  print(matrix[0].last[0]);
}

void rainbowgifls(Imgfilterobj imgfobj) {
  int fconter = 0;
  img.Image? photo;

  final folderName = "gifout";
  final path = Directory("$folderName");
  path.create();

  photo = img.decodeImage(imgfobj.bytes!);

  int height = photo!.height;

  int width = photo.width;

  photo = img.copyResize(photo, width: ((width * (60 / height)).round()));

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

  int fontindex = 13;

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

  List<List<List<int>>> matrix = [];

  var g = Random(56);

  int index = g.nextInt(21) + 20;

  bool visable = true;

  var color = 0X0026F64A;

  for (int i = 0; i < width; i++) {
    List<List<int>> line = [];

    for (int j = 0; j < height; j++) {
      //get pixle colors

      int red = photodata[j * width + i] & 0xff;
      int green = (photodata[j * width + i] >> 8) & 0xff;
      int blue = (photodata[j * width + i] >> 16) & 0xff;

      //cal avg
      double avg = (blue + red + green) / 3;

      var k = gscale[((avg * gscalelen) / 255).round()];

      var color = 0X00000000 |
          g.nextInt(256) |
          (g.nextInt(256)) << 8 |
          (g.nextInt(256) << 16);

      int alpha = (((photodata[j * width + i] >> 24) & 0xff) << 24);
      // print(alpha);
      // print(((color | alpha) >> 24) << 24);

      line.add([
        imgfobj.rainbow[j ~/ (height / 7)] ^ alpha,
        ((avg * gscalelen) / 255).round()
      ]);
    }
    matrix.add(line);
  }

  // File('haha/fram${fconter}.png').writeAsBytesSync(img.encodePng(imageg));
  // fconter += 1;
  var gife = GifEncoder(delay: 7);

  for (int o = 0; o < width; o++) {
    img.Image imageg = img.Image(width * fontindex, height * fontindex);

    img.fill(imageg, fillcolor);
    List<int> tmps = [];

    for (int i = 0; i < width; i++) {
      tmps.add(matrix[i][0][0]);
    }

    for (int i = 1; i < width; i++) {
      matrix[i][0][0] = matrix[i - 1][height - 1][0];
    }

    matrix[0][0][0] = matrix[width - 1][height - 1][0];

    for (int j = width - 1; j > 1; j--) {
      for (int i = height - 1; i > 1; i--) {
        matrix[j][i][0] = matrix[j - 1][i - 1][0];
      }
    }

    for (int i = 1; i < width; i++) {
      matrix[i][1][0] = tmps[i];
    }

    matrix[0][1][0] = tmps[width - 1];

    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        //get pixle colors

        var k = gscale[matrix[i][j][1]];
        int alpha = (((photodata[j * width + i] >> 24) & 0xff) << 24);

        img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
            color: matrix[i][j][0]);
      }
    }

    gife.addFrame(imageg);
  }
  File('$folderName/gif${imgfobj.c}.gif').writeAsBytesSync(gife.finish()!);

  //  print(matrix[0].last[0]);
}

void shiftframes(Imgfilterobj imgfobj) {
  final folderName = "shift${imgfobj.c}";
  final path = Directory("$folderName");
  path.create();

  int fconter = 0;
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

  int fontindex = 13;

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

  var rainbow = imgfobj.rainbow;

  for (int o = 0; o < 7; o++) {
    img.Image imageg = img.Image(width * fontindex, height * fontindex);

    img.fill(imageg, fillcolor);

    for (int i = 0; i < height; i++) {
      for (int j = 0; j < width; j++) {
        //get pixle colors

        int red = photodata[i * width + j] & 0xff;
        int green = (photodata[i * width + j] >> 8) & 0xff;
        int blue = (photodata[i * width + j] >> 16) & 0xff;
        int alpha = (((photodata[j * width + i] >> 24) & 0xff) << 24);

        //cal avg
        double avg = (blue + red + green) / 3;

        var k = gscale[((avg * gscalelen) / 255).round()];

        img.drawString(imageg, drawfonts, j * fontindex, i * fontindex, k,
            color: (rainbow[((avg * 6) / 255).round()]) ^ alpha);
      }
    }
    rainbow.insert(0, rainbow[6]);
    rainbow.removeLast();
    print(rainbow);
    File('${folderName}/frame${fconter}.png')
        .writeAsBytesSync(img.encodePng(imageg));
    fconter += 1;
  }
}

Future<void> main(List<String> arguments) async {
  print(arguments);
  int counter = 3010;

  double _valuecom = 0.25;

  double _valueblur = 0.0;
  bool qouting = false;
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
    'Rainbow Flag': false,
    'Rainbow Flag Reversed': false,
    'Rainbow Random': false,
    'Random colors': false,
    'cmatrix': false,
    'cmatrix full colors': false,
    'cmatrix modren': false
  };
  Map<String, bool> filtersmap2 = {
    // 'sepia': false,
    // 'photo hash 2': false,
    // 'photo hash 3': false,
    'Rainbow Random': false,
    'Random colors': false,
    'cmatrix modren': true
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
    'letters and symbols': false,
    'only symbols': false,
    'only letters': false
  };
  

  int? columns = 120;

  Uint8List? imagebytes;

  // List<String> images = [''];

  List keysf = filtersmap2.keys.toList();

  List keysb = brcmap.keys.toList();

  List keyss = symbolsmap.keys.toList();

  Directory dir = Directory('./image');
// execute an action on each entry
  dir.list(recursive: false).forEach((f) {
    if (f is File) {
      print(f);
      imagebytes = (f).readAsBytesSync();

      // for (int i = 0; i < keysf.length; i++) {
      //   filtersmap.forEach((k, v) => filtersmap[k] = false);

      //   filtersmap[keysf[i]] = true;

        //   for (int j = 0; j < keysb.length; j++) {
        //     brcmap.forEach((k, v) => brcmap[k] = false);

        //     brcmap[keysb[j]] = true;

        //     for (int k = 0; k < keyss.length; k++) {
        //       symbolsmap.forEach((g, v) => symbolsmap[g] = false);

        //       symbolsmap[keyss[k]] = true;

        var imgfobj = Imgfilterobj(imagebytes!, _valuecom, _valueblur,
            filtersmap, brcmap, fontmap, symbolsmap, counter, qouting);
        // photohash(imgfobj);
        // fadeframes(imgfobj);
        // shiftframes(imgfobj);
        cmatrixframscolor(imgfobj);
        // randomcolorsgif(imgfobj);

        // rainbowgif(imgfobj);
        // rainbowgifls(imgfobj);
        //  a(imgfobj);
        // matrixm(imgfobj);
        // var imgfobjtxt =  Imgfilterobjtxt(imagebytes!, columns!, symbolsmap);

        //      photohashtxt(imgfobjtxt);

        counter++;
        //     }
        // }
      // }
    }
  });
}
