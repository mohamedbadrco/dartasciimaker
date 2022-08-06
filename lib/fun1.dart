// ignore_for_file: unused_local_variable

import 'package:asciimaker/asciimaker.dart';
import 'package:image/image.dart' as img;
import 'dart:io';
import 'dart:math';


import 'package:image/image.dart';



final now = DateTime.now();
final y = now.year;
final m = now.month;
final d = now.day;
final h = now.hour;
final min = now.minute;

void cmc(Imgfilterobj imgfobj) {
  int fconter = 0;
  img.Image? photo;
  var font1 = img.BitmapFont.fromZip(
      File('font/Audiowide-Regular.ttf (1).zip').readAsBytesSync());

  // var font2 = img.BitmapFont.fromZip(
  //     File('font/Pacifico-Regular.ttf (1).zip').readAsBytesSync());

  // var font3 = img.BitmapFont.fromZip(
  //     File('font/EduVICWANTBeginner-Bold.ttf (1).zip').readAsBytesSync());

  // var font4 = img.BitmapFont.fromZip(
  //     File('font/RubikMoonrocks-Regular.ttf (1).zip').readAsBytesSync());

  var font5 = img.BitmapFont.fromZip(
      File('font/PressStart2P-Regular.ttf.zip').readAsBytesSync());

  // var font6 = img.BitmapFont.fromZip(
  //     File('font/Ultra-Regular.ttf.zip').readAsBytesSync());

  // var fonts = [font1, font2, font3, font4, font5, font6];
  final folderName = "gifout";
  final path = Directory(folderName);
  path.create();
  print('$folderName/matrix${imgfobj.c}.gif');

  photo = img.decodeImage(imgfobj.bytes!);

  int height = photo!.height;
  int ct = 0;
  int width = photo.width;

  photo = img.copyResize(photo, width: ((width * (100 / height)).round()));

  height = photo.height;

  width = photo.width;

  List<int> photodata = photo.data;

  img.gaussianBlur(photo, imgfobj.vablur!.round());

  var fillcolor = img.getColor(255, 255, 255);

  // if (imgfobj.brc!['black'] == true) {
  //   fillcolor = img.getColor(0, 0, 0);
  // } else if (imgfobj.brc!['red'] == true) {
  //   fillcolor = img.getColor(255, 0, 0);
  // } else if (imgfobj.brc!['green'] == true) {
  //   fillcolor = img.getColor(0, 255, 0);
  // } else if (imgfobj.brc!['blue'] == true) {
  //   fillcolor = img.getColor(0, 0, 255);
  // }
  // bold bitmap font
  img.arial_14.bold = true;
  img.BitmapFont drawfonts = font1;
  var bold = true;
  drawfonts.bold = bold;

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

  // img.Image imageg = img.Image(width * fontindex, height * fontindex);

  // img.fill(imageg, fillcolor);

  List<List<List<int>>> matrix = [];

  var g = Random(imgfobj.c);

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
          index = g.nextInt(21) + 5;
          visable = false;
        } else {
          index = g.nextInt(21) + 20;
          visable = true;
        }
      }

      // var k = gscale[((avg * gscalelen) / 255).round()];

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
  var gife = GifEncoder(delay: 7, samplingFactor: 100);
  gife.ditherSerpentine = true;
  // var gife2 = GifEncoder(delay: 7, samplingFactor: 100);
  // var L = [
  //   // 0x00FFFFFF,
  //   // 0X00688410,
  //   // 0x00242120,
  //   0x00242120,
  //   0X00567313,
  //   0x00FFFFFF,
  //   0x00101010,
  //   0X00069A4E,
  //   0x00CFD7D3,
  //   // 0x00362B00,
  //   // 0X00009985,
  //   // 0x00D5E8EE
  // ].reversed.toList();

  // var L = [
  //   0x00FFFFFF,
  //   0X00688410,
  //   0x00242120,
  //   0x00F59AB3,
  //   0x008BA0FF,
  //   0x007B4D43,
  //   0x00999000,
  //   0x00362B00,
  //   0X00009985,
  //   0x00D5E8EE
  // ];
  // var L = [
  //   0x00FFFFFF,
  //   0X00688410,
  //   0x00242120,
  //   0x00242120,
  //   0X00567313,
  //   0x00FFFFFF,
  //   0x00101010,
  //   0X00069A4E,
  //   0x00CFD7D3,
  //   0x00362B00,
  //   0X00009985,
  //   0x00D5E8EE,
  //   0x00E3F6FD,
  //   0X00009985,
  //   0x00423607,
  //   0x003E2722,
  //   0X00EFFEE3,
  //   0x007B4D43,
  //   0x00431C3E,
  //   0X00FAD8CD,
  //   0x002E222C,
  //   0x0034331F,
  //   0X00B09770,
  //   0x006C6B48
  // ];

  var c = Colors();
  // var L = [
  //   c.bblack1,
  //   c.red1,
  //   c.green1,
  //   c.yellow1,
  //   c.blue1,
  //   c.magtena1,
  //   c.cyan1,
  //   c.white1
  // ];
  var l2 = [
    c.black2,
    c.red2,
    c.green2,
    c.yellow2,
    c.blue2,
    c.magtena2,
    c.cyan2,
    c.white2
  ];

  var l1 = [
    c.black1,
    c.red1,
    c.green1,
    c.yellow1,
    c.blue1,
    c.magtena1,
    c.cyan1,
    c.white1
  ];

  var pair1 = [rtog(0x00E8EAED), rtog(0x00F28B82)];
  var pair2 = [rtog(0x003C4043), rtog(0x00F28B82)];
  var pair3 = [rtog(0x00000000), rtog(0x00CC0000)];
  var pair4 = [rtog(0x00268BD2), rtog(0x00FDF6E3)];
  var pair5 = [rtog(0x00434D7B), rtog(0x00FFA08B)];
  var pair6 = [rtog(0x003C4043), rtog(0x0003BFC8)];
  var pair7 = [rtog(0x00839496), rtog(0x002AA198)];

  var L = [
    // l2, l1, pair1, pair2,
    // pair3, pair4, pair5, pair6, pair7
  ];
  for (int i = 0; i < 5; i++) {
    // var nextInt = g.nextInt(256);
    // var other = (g.nextInt(256)) << 8;
    // var other2 = (g.nextInt(256) << 16);

    // var nextInt2 = g.nextInt(256);
    // var other3 = (g.nextInt(256)) << 8;
    // var other4 = (g.nextInt(256) << 16);
    // while (((nextInt2 - nextInt).abs() +
    //         (other - other3).abs() +
    //         (other2 - other4)) <
    //     20) {
    //   nextInt2 = g.nextInt(256);
    //   other3 = (g.nextInt(256)) << 8;
    //   other4 = (g.nextInt(256) << 16);
    // }

    // var as = [
    //   0X00000000 | nextInt | other | other2,
    //   0X00000000 | nextInt2 | other3 | other4
    // ];
    List<int> as = [];
    for (int j = 0; j < 7; j++) {
      as.add(0X00000000 |
          g.nextInt(256) |
          (g.nextInt(256)) << 8 |
          (g.nextInt(256) << 16));
    }
    L.add(as);
  }
  // L[(((((matrix[i][j][1] / gscalelen) * 255) *
  //                               (L.length - 1)) /
  //                           255))
  //                       .round()]) ^
  //                   alpha
  for (int p = 0; p < L.length; p++) {
    var endc = 0Xff000000 |
        g.nextInt(256) |
        (g.nextInt(256)) << 8 |
        (g.nextInt(256) << 16);
    var dL = L[p];

    var bnextInt = g.nextInt(256);
    var bother = (g.nextInt(256)) << 8;
    var bother2 = (g.nextInt(256) << 16);

    // while ((((bnextInt - (L[p][0] & 0xff)).abs() +
    //             (bother - (L[p][0] >> 8) & 0xff).abs() +
    //             (bother2 - (L[p][0] >> 16) & 0xff)) <
    //         20) ||
    //     (((bnextInt - (L[p][1] & 0xff)).abs() +
    //             (bother - (L[p][1] >> 8) & 0xff).abs() +
    //             (bother2 - (L[p][1] >> 16) & 0xff)) <
    //         20)) {
    //   bnextInt = g.nextInt(256);
    //   bother = (g.nextInt(256)) << 8;
    //   bother2 = (g.nextInt(256) << 16);
    // }

    var bc = 0Xff000000 | bnextInt | (bnextInt << 8) | (bnextInt << 16);

    for (int o = 0; o < height; o++) {
      img.Image imageg = img.Image(width * fontindex, height * fontindex);

      // img.fill(imageg, 0xffffffff);
      img.fill(imageg, bc);

      for (int i = 0; i < width; i++) {
        var tem = matrix[i][0][0];

        matrix[i][0][0] = matrix[i][height - 1][0];

        for (int j = height - 1; j > 1; j--) {
          matrix[i][j][0] = matrix[i][j - 1][0];
        }

        matrix[i][1][0] = tem;
      }

      for (int i = 0; i < width; i++) {
        for (int j = 0; j < height; j++) {
          //get pixle colors
          var k = gscale[matrix[i][j][1]];
          int alpha = (((photodata[j * width + i] >> 24) & 0xff) << 24);

          if (matrix[i][j][0] != 0) {
            if (matrix[i][j][0] == 2) {
              img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
                  color: (0x00ffffff ^ alpha));
            } else {
              img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
                  color: (dL[(((((matrix[i][j][1] / gscalelen) * 255) *
                                  (dL.length - 1)) /
                              255)
                          .round())]) ^
                      alpha);
            }
          }
        }
      }

      var o = img.decodeImage(img.encodePng(imageg));

      gife.addFrame(o!);

      // gife2.addFrame(imageg);

      // File('$folderName/f$ct.png').writeAsBytesSync(img.encodePng(imageg));
      // ct += 1;
    }
    var ff = gife.finish()!;
    File fl = File('commands.txt');
    File('$folderName/matrix$y-$m-$d-$h-$min-${imgfobj.c}-$p.gif')
        .writeAsBytesSync(ff);
    fl.writeAsStringSync(
        "gifsicle  matrix$y-$m-$d-$h-$min${imgfobj.c}-$p.gif -o matrix${imgfobj.c}-$p.gif --optimize --colors 25 \n",
        mode: FileMode.append);
  }
  // File('$folderName/matrix${imgfobj.c}-2.png').writeAsBytesSync(ff);
  // }

  //  print(matrix[0].last[0]);
}
