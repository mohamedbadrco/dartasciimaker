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

void fun6(Imgfilterobj imgfobj) {
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
  print('$folderName/matrix${imgfobj.c}---cmc2.gif');

  photo = img.decodeImage(imgfobj.bytes!);

  int height = photo!.height;
  int ct = 0;
  int width = photo.width;

  photo = img.copyResize(photo, width: ((width * (60 / height)).round()));

  height = photo.height;

  width = photo.width;

  List<int> photodata = photo.data;

  img.gaussianBlur(photo, imgfobj.vablur!.round());

  var fillcolor = img.getColor(255, 255, 255);

  font1.bold = true;
  img.BitmapFont deffonts = img.arial_14;

  int fontindex = 12;

  if (imgfobj.fonts!['24 px'] == true) {
    deffonts = img.arial_24;

    fontindex = 22;
  }
  deffonts.bold = true;
  String gscale = imgfobj.gscale1;
  int gscalelen = gscale.length - 1;

  if (imgfobj.symbols!['only symbols'] == true) {
    gscale = imgfobj.gscale2;

    gscalelen = gscale.length - 1;
  } else if (imgfobj.symbols!['only letters'] == true) {
    gscale = imgfobj.gscale3;

    gscalelen = gscale.length - 1;
  }


  List<List<List<int>>> matrix = [];

  var g = Random(imgfobj.c! + y + m + d + h + min);

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
          index = g.nextInt(21) + 100;
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

  var gife = GifEncoder(delay: 7, samplingFactor: 100);
  gife.ditherSerpentine = true;

  img.BitmapFont drawfonts = font1;

  var lc = 0;
  for (int oo = 0; oo < (height * 20); oo++) {
    img.Image imageg = img.Image(width * fontindex, height * fontindex);

    // img.fill(imageg, 0xffffffff);
    img.fill(imageg, 0xff000000);

    for (int i = 0; i < width; i++) {
      var tem = matrix[i][0][0];

      matrix[i][0][0] = matrix[i][height - 1][0];

      for (int j = height - 1; j > 1; j--) {
        matrix[i][j][0] = matrix[i][j - 1][0];
      }

      matrix[i][1][0] = tem;
    }
    var off = 0;
    var off2 = 0;
    var rand = g.nextBool();

    if (oo % 20 == 0) {
      lc += 1;
      off = 0;
    }
    if (rand) {
      if (oo % 20 == 2) {
        off = (width * 0.15).round() * (g.nextBool() ? 1 : -1);
        off2 = off;
      }
      if (oo % 20 == 4) {
        off = 0;
      }
      if (oo % 20 == 6) {
        off = -(width * 0.15).round() * (g.nextBool() ? 1 : -1);
        off2 = off;
      }
      if (oo % 20 == 8) {
        off = 0;
      }
    } else {
      if (oo % 20 == 2) {
        off = (width * 0.15).round() * (g.nextBool() ? 1 : -1);
        off2 = -off;
      }
      if (oo % 20 == 4) {
        off = 0;
      }
      if (oo % 20 == 6) {
        off = (width * 0.15).round() * (g.nextBool() ? 1 : -1);
        off2 = -off;
      }
      if (oo % 20 == 8) {
        off = 0;
      }
    }
    // print("$rand :  $off :: $off2");
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        //get pixle colors
        var k = gscale[matrix[i][j][1]];
        if (k == "\$") {
          drawfonts = deffonts;
        } else {
          drawfonts = font1;
        }
        int alpha = (((photodata[j * width + i] >> 24) & 0xff) << 24);

        if ((matrix[i][j][0] != 0) || (lc > ((height - 1) - j))) {
          if ((matrix[i][j][0] == 2 && !(lc > ((height - 1) - j)))) {
            img.drawString(imageg, drawfonts, (i * fontindex), j * fontindex, k,
                color: (0x00ffffff ^ alpha));
          } else if ((oo % 20 <= 2) && (lc > ((height - 1) - j))) {
            img.drawString(imageg, drawfonts, (i * fontindex) + off,
                (j * fontindex) + off2, k,
                color: (0x00ffffff ^ alpha));
          } else {
            if (lc > ((height - 1) - j)) {
              img.drawString(imageg, drawfonts, (i * fontindex) + off,
                  (j * fontindex) + off2, k,
                  color: (photodata[j * width + i]));
            }
            img.drawString(imageg, drawfonts, (i * fontindex), j * fontindex, k,
                color: (photodata[j * width + i]));
          }
        }
      }
    }

    var o = img.decodeImage(img.encodePng(imageg));

    gife.addFrame(o!);
  }
  var ff = gife.finish()!;
  File fl = File('commands.txt');
  File('$folderName/matrix$y-$m-$d-$h-$min-${imgfobj.c}.gif')
      .writeAsBytesSync(ff);
  fl.writeAsStringSync("""
gifsicle  matrix$y-$m-$d-$h-$min${imgfobj.c}.gif 
-o matrix${imgfobj.c}.gif --optimize --colors 25 \n""", mode: FileMode.append);
}
