// ignore_for_file: unused_field

import 'dart:typed_data';

int rtog(int hexa) {
  int r = hexa & 0xff;
  int g = (hexa >> 8) & 0xff;
  int b = (hexa >> 16) & 0xff;
  int a = (((hexa >> 24) & 0xff) << 24);
  return 0x00000000 | b | g << 8 | r << 16 | a;
}

//  String s =
//       "ABCČĆDĐEFGHIJKLMNOPQRSŠTUVWXYZŽabcčćdđefghijklmnopqrsštuvwxyzžАБВГҐДЂЕЁЄЖЗЅИІЇЙЈКЛЉМНЊОПРСТЋУЎФХЦЧЏШЩЪЫЬЭЮЯабвгґдђеёєжзѕиіїйјклљмнњопрстћуўфхцчџшщъыьэюяΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩαβγδεζηθικλμνξοπρστυφχψωάΆέΈέΉίϊΐΊόΌύΰϋΎΫάέίόύΏĂÂÊÔƠƯăâêôơư1234567890‘?’“!”(%)[#]{@}/&\\<-+÷×=>®©\$€£¥¢:;,.*";
//   List<int> o = [];
//   var drawfonts = img.arial_24;
//   var font5 = img.BitmapFont.fromZip(
//       File('font/Roboto-Black.ttf.zip').readAsBytesSync());
//   drawfonts = font5;
//   drawfonts.bold = true;

//   var fontindex = 24;

//   for (int i = 0; i < s.length; i++) {
//     img.Image imageg = img.Image(fontindex, fontindex);

//     img.fill(imageg, 0xffffffff);

//     img.drawString(imageg, drawfonts, 0, 0, s[i], color: 0xff000000);
//     var photodata = imageg.data;
//     var width = 24;
//     var sum = 0;
//     for (int j = 0; j < 24; j++) {
//       for (int k = 0; k < 24; k++) {
//         int red = photodata[k * width + j] & 0xff;
//         int green = (photodata[k * width + j] >> 8) & 0xff;
//         int blue = (photodata[k * width + j] >> 16) & 0xff;
//         sum += (red + green + blue);
//       }
//     }
//     var avg = sum / (24 * 24);
//     o.add(avg.round());
//   }
//   var res = '';
//   while (o.isNotEmpty) {
//     var i = o.indexOf(o.reduce(min));
//     print(i);
//     var m = s[i];
//     o.removeAt(i);
//     res = res + m;
//   }

//   print(res);

//   File fl = File('list.txt');

//   await fl.writeAsString("$res \n", mode: FileMode.append);

class Colors {
  int black1 = rtog(0x003C4043);
  int red1 = rtog(0x00F28B82);
  int green1 = rtog(0x00137356);
  int yellow1 = rtog(0x00E37400);
  int blue1 = rtog(0x00E37400);
  int magtena1 = rtog(0x00EE5FFA);
  int cyan1 = rtog(0x0003BFC8);
  int white1 = rtog(0x00FFFFFF);

  int bblack1 = rtog(0x009AA0A6);
  int bred1 = rtog(0x00F6AEA9);
  int bgreen1 = rtog(0x0087FFC5);
  int byellow1 = rtog(0x00FDD663);
  int bblue1 = rtog(0x00AECBFA);
  int bmagtena1 = rtog(0x00F4B5FB);
  int bcyan1 = rtog(0x0080F9F9);
  int bwhite1 = rtog(0x00F8F9FA);

  int black2 = rtog(0x00000000);
  int red2 = rtog(0x00CC0000);
  int green2 = rtog(0x004E9A06);
  int yellow2 = rtog(0x00C4A000);
  int blue2 = rtog(0x003465A4);
  int magtena2 = rtog(0x0075507B);
  int cyan2 = rtog(0x0006989A);
  int white2 = rtog(0x00D3D7CF);

  int bblack2 = rtog(0x00555753);
  int bred2 = rtog(0x00EF2929);
  int bgreen2 = rtog(0x0000BA13);
  int byellow2 = rtog(0x00FCE94F);
  int bblue2 = rtog(0x00729FCF);
  int bmagtena2 = rtog(0x00F200CB);
  int bcyan2 = rtog(0x0000B5BD);
  int bwhite2 = rtog(0x00EEEEEC);
}

class Imgfilterobj {
  final String gscale1 =
      "\$@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft/|()1{}[]?-_+~<>i!lI;:,\"^`'. ";

  final String gscale1s =
      "\$@ß%8&WM#*ö	õäåhkbdpqwmZÖØ0QLÇJÜÝXzçvünxrjft/|()1{}[]?-_+~<>i!lI;:,\"^`'. ";
  final String gscale1s2 = "ßöõäåÖØÇJÜÝçü ";
  final String coolscale1 = "\$@B%8&WM#kbdpqwmZO0QLCJUYX/|+<>i!I;:,\". ";
  final String gscale1s3 =
      "ABCČĆDĐEFGHIJKLMNOPQRSŠTUVWXYZŽabcčćdđefghijklmnopqrsštuvwxyzžАБВГҐДЂЕЁЄЖЗЅИІЇЙЈКЛЉМНЊОПРСТЋУЎФХЦЧЏШЩЪЫЬЭЮЯабвгґдђеёєжзѕиіїйјклљмнњопрстћуўфхцчџшщъыьэюяΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩαβγδεζηθικλμνξοπρστυφχψωάΆέΈέΉίϊΐΊόΌύΰϋΎΫάέίόύΏĂÂÊÔƠƯăâêôơư1234567890‘?’“!”(%)[#]{@}/&\\<-+÷×=>®©\$€£¥¢:;,.*";

  final String gscale2 = '#*+=-:';

  final String gscale3 = "BWMoahkbdpqwmZOQLCJUYXzcvnxrjftilI ";

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
  double? vacom;
  double? vablur;
  Map<String, bool>? filters;
  Map<String, bool>? brc;
  Map<String, bool>? fonts;
  Map<String, bool>? symbols;
  int? c;
  bool? q;

  Imgfilterobj(this.bytes, this.vacom, this.vablur, this.filters, this.brc,
      this.fonts, this.symbols, this.c, this.q);
}

class Imgfilterobjtxt {
  final String gscale1 =
      "\$@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft/|()1{}[]?-_+~<>i!lI;:,\"^`'. ";
  final String coolscale1 = "\$@B%8&WM#kbdpqwmZO0QLCJUYX/|+<>i!I;:,\". ";

  final String gscale2 = '@%# += :. ';

  final String gscale3 = "BWMoahkbdpqwmZOQLCJUYXzcvunxrjftilI ";
  Uint8List? bytes;
  Map<String, bool>? symbols;
  int clos = 100;
  int? c;

  Imgfilterobjtxt(this.bytes, this.clos, this.symbols, this.c) {
    // Ignored
  }
}
