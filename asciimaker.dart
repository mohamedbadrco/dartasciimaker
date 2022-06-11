import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'dart:io';
import 'dart:math';



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
      this.brc, this.fonts, this.symbols, this.c,this.q) {
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

















  if(imgfobj.q! == true){

    for (int i = 0; i < height; i++) {
      for (int j = 0; j < width; j++) { 
           
             var g = Random(i * j); 
             

        int index =  g.nextInt(37) ;

        if ( index > 32 ){
           
          index = index - 32 ;

          img.drawLine(imageg, j * fontindex  , i * fontindex - 6 
        , j * fontindex + index * 13  , i * fontindex - 6,
         imgfobj.rainbow[g.nextInt(7)] ^ 0x88000000 , thickness: 13);

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
        double avg = (blue + red + green ) / 3;

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
    
    if(imgfobj.filters!['Rainbow Flag'] == true || imgfobj.filters!['Rainbow Flag Reversed'] == true) {
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

          int alpha = (((photodata[i * width + j] >> 24) & 0xff) << 24);

          img.drawString(imageg, drawfonts, j * fontindex, i * fontindex, k,
              color: (rainbow0[i ~/ (height/7)] ^ alpha));
        }
      }

    }

    if(imgfobj.filters!['Rainbow Random'] == true ) {

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

    if(imgfobj.filters!['Random colors'] == true ) {

      var g = Random(photodata[Random(56).nextInt(256)]);

        for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
          //get pixle colors

          int red = photodata[i * width + j] & 0xff;
          int green = (photodata[i * width + j] >> 8) & 0xff;
          int blue = (photodata[i * width + j] >> 16) & 0xff;


          //cal avg
          double avg = (blue + red + green) / 3;



          
      var  color = 0X00000000  | g.nextInt(256) | (  g.nextInt(256)) << 8 | ( g.nextInt(256) << 16);
       

          var k = gscale[((avg * gscalelen) / 255).round()];

          int alpha = (((photodata[i * width + j] >> 24) & 0xff) << 24);

          img.drawString(imageg, drawfonts, j * fontindex, i * fontindex, k,
              color: (color ^ alpha));
        }
      }

    }
    if(imgfobj.filters!['cmatrix'] == true ) {

      var g = Random(56);

      int index =  g.nextInt(21) + 20 ;

      bool visable = true;

      var color = 0X0026F64A ;

        for (int i = 0; i < width; i++) {
        for (int j = 0; j < height; j++) {
          //get pixle colors

          int red = photodata[j * width + i] & 0xff;
          int green = (photodata[j * width + i] >> 8) & 0xff;
          int blue = (photodata[j * width + i] >> 16) & 0xff;


          //cal avg
          double avg = (blue + red + green) / 3;

          index = index - 1;

          if (index == 0){
            
            if (visable == true){
                   index =  g.nextInt(21) + 2;
                   visable =false;
            }else{
                 index =  g.nextInt(21) + 20 ;
                   visable = true;
            }
          }

       

          var k = gscale[((avg * gscalelen) / 255).round()];

          int alpha = (((photodata[j * width + i] >> 24) & 0xff) << 24);

          if (visable == true){
            if(index == 1 ){
              img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
              color: (0X00ffffff ^ alpha));

            }else{

            
          img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
              color: (color ^ alpha)); }
          }


        }
      }

    }

    if(imgfobj.filters!['cmatrix full colors'] == true ) {

      var g = Random(56);

      int index =  g.nextInt(21) + 20 ;

      bool visable = true;

      var color = 0X0026F64A ;

        for (int i = 0; i < width; i++) {
        for (int j = 0; j < height; j++) {
          //get pixle colors

          int red = photodata[j * width + i] & 0xff;
          int green = (photodata[j * width + i] >> 8) & 0xff;
          int blue = (photodata[j * width + i] >> 16) & 0xff;


          //cal avg
          double avg = (blue + red + green) / 3;

          index = index - 1;

          if (index == 0){
            
            if (visable == true){
                   index =  g.nextInt(21) + 2;
                   visable =false;
            }else{
                 index =  g.nextInt(21) + 20 ;
                   visable = true;
            }
          }

       

          var k = gscale[((avg * gscalelen) / 255).round()];

          int alpha = (((photodata[j * width + i] >> 24) & 0xff) << 24);

          if (visable == true){
            if(index == 1 ){
              img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
              color: (0X00ffffff ^ alpha));

            }else{

            
          img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
              color: (photodata[j * width + i] )); }
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

  int fconter = 0 ;
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

      int index =  g.nextInt(21) + 20 ;

      bool visable = true;


      var color = 0X0026F64A ;

        for (int i = 0; i < width; i++) {

          List<List<int>> line = [];
            line.add([1,index]);

        for (int j = 0; j < height; j++) {
          //get pixle colors

            

          int red = photodata[j * width + i] & 0xff;
          int green = (photodata[j * width + i] >> 8) & 0xff;
          int blue = (photodata[j * width + i] >> 16) & 0xff;


          //cal avg
          double avg = (blue + red + green) / 3;

          index = index - 1;

          if (index == 0){
            
            if (visable == true){
                   index =  g.nextInt(21) + 2;
                   visable =false;
                  
            }else{
                 index =  g.nextInt(21) + 20 ;
                   visable = true;
            }
          }

  
          var k = gscale[((avg * gscalelen) / 255).round()];
          

          

          // int alpha = (((photodata[j * width + i] >> 24) & 0xff) << 24);

          if (visable == true){
                       
            if(index == 1 ){
              line.add([2,((avg * gscalelen) / 255).round() ]); 
              // img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
              // color: (0X00ffffff ^ alpha));

            }else{
            line.add([1,((avg * gscalelen) / 255).round() ]); 
            
          // img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
          //     color: (color ^ alpha)); 
          }
          }else{
            line.add([0,((avg * gscalelen) / 255).round() ]);
          }


        }
        matrix.add(line);
      }

      // File('haha/fram${fconter}.png').writeAsBytesSync(img.encodePng(imageg));
      // fconter += 1;

      for(int o = 0; o < height ;o++){

        img.Image imageg = img.Image(width * fontindex, height * fontindex);
        
        img.fill(imageg, fillcolor);
        

        for (int i = 0; i < width; i++) {

          var tem = matrix[i][height-1][0];

          matrix[i][height-1][0] = matrix[i][0][0];

          

        for (int j = 0; j < height-2; j++) {  
           matrix[i][j][0] = matrix[i][j+1][0];
        }

        matrix[i][height- 2][0] = tem;
        }
        


         for (int i = 0; i < width; i++) {
           
        for (int j = 0; j < height; j++) {
          //get pixle colors

          var k = gscale[matrix[i][j][1]];
          int alpha = (((photodata[j * width + i] >> 24) & 0xff) << 24);

          if (matrix[i][j][0] != 0){
            if(matrix[i][j][0] == 2 ){
              img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
              color: (0X00ffffff ^ alpha));

            }else{
            
          img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
              color: (color ^ alpha)); }
          }


        }
      }

      File('haha/frame${fconter}.png').writeAsBytesSync(img.encodePng(imageg));
      fconter += 1;

      }

    //  print(matrix[0].last[0]);

}


void cmatrixframscolor(Imgfilterobj imgfobj) {

  int fconter = 0 ;
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

      int index =  g.nextInt(21) + 20 ;

      bool visable = true;


      var color = 0X0026F64A ;

        for (int i = 0; i < width; i++) {

          List<List<int>> line = [];
            line.add([1,index]);

        for (int j = 0; j < height; j++) {
          //get pixle colors

            

          int red = photodata[j * width + i] & 0xff;
          int green = (photodata[j * width + i] >> 8) & 0xff;
          int blue = (photodata[j * width + i] >> 16) & 0xff;


          //cal avg
          double avg = (blue + red + green) / 3;

          index = index - 1;

          if (index == 0){
            
            if (visable == true){
                   index =  g.nextInt(21) + 2;
                   visable =false;
                  
            }else{
                 index =  g.nextInt(21) + 20 ;
                   visable = true;
            }
          }

  
          var k = gscale[((avg * gscalelen) / 255).round()];
          

          

          // int alpha = (((photodata[j * width + i] >> 24) & 0xff) << 24);

          if (visable == true){
                       
            if(index == 1 ){
              line.add([2,((avg * gscalelen) / 255).round() ]); 
              // img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
              // color: (0X00ffffff ^ alpha));

            }else{
            line.add([1,((avg * gscalelen) / 255).round() ]); 
            
          // img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
          //     color: (color ^ alpha)); 
          }
          }else{
            line.add([0,((avg * gscalelen) / 255).round() ]);
          }


        }
        matrix.add(line);
      }

      // File('haha/fram${fconter}.png').writeAsBytesSync(img.encodePng(imageg));
      // fconter += 1;

      for(int o = 0; o < height ;o++){

        img.Image imageg = img.Image(width * fontindex, height * fontindex);
        
        img.fill(imageg, fillcolor);
        

        for (int i = 0; i < width; i++) {

          var tem = matrix[i][height-1][0];

          matrix[i][height-1][0] = matrix[i][0][0];

          

        for (int j = 0; j < height-2; j++) {  
           matrix[i][j][0] = matrix[i][j+1][0];
        }

        matrix[i][height- 2][0] = tem;
        }
        


         for (int i = 0; i < width; i++) {
           
        for (int j = 0; j < height; j++) {
          //get pixle colors

          var k = gscale[matrix[i][j][1]];
          int alpha = (((photodata[j * width + i] >> 24) & 0xff) << 24);

          if (matrix[i][j][0] != 0){
            if(matrix[i][j][0] == 2 ){
              img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
              color: (0X00ffffff ^ alpha));

            }else{
            
          img.drawString(imageg, drawfonts, i * fontindex, j * fontindex, k,
              color: photodata[j * width + i] ); }
          }


        }
      }

      File('haha/frame${fconter}.png').writeAsBytesSync(img.encodePng(imageg));
      fconter += 1;

      }

    //  print(matrix[0].last[0]);

}


void fadeframes(Imgfilterobj imgfobj) {


  int fconter = 0 ;
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

  
  List<int> lints = [1,2,4,8,16,32,64,height*width];

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
        double avg = (blue + red + green ) / 3;

        var k = gscale[((avg * gscalelen) / 255).round()];
       if (i % lints[o] == 0 && j % lints[o] == 0){
        img.drawString(imageg, drawfonts, j * fontindex, i * fontindex, k,
            color: photodata[i * width + j]);  }
            
            }}  

         File('sframes/frame${fconter}.png').writeAsBytesSync(img.encodePng(imageg));
      fconter += 1;
   }


}



void shiftframes(Imgfilterobj imgfobj) {
  
  
final folderName="shift${imgfobj.c}";
final path= Directory("$folderName");
path.create();


  int fconter = 0 ;
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

  var rainbow = imgfobj.rainbow ;
  

   for (int o = 0; o < 7 ; o++) {
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
        double avg = (blue + red + green ) / 3;

        var k = gscale[((avg * gscalelen) / 255).round()];
        
        img.drawString(imageg, drawfonts, j * fontindex, i * fontindex, k,
            color: (rainbow[((avg * 6) / 255).round()]) ^ alpha );  
            
            }
            }  
          rainbow.insert(0, rainbow[6]);
          rainbow.removeLast();
          print(rainbow);
         File('${folderName}/frame${fconter}.png').writeAsBytesSync(img.encodePng(imageg));
      fconter += 1;
   }


}


Future<void> main(List<String> arguments) async {

  print(arguments);
  int counter = 1;

  double _valuecom = 0.25;

  double _valueblur = 0.0;
  bool qouting = true;
  Map<String, bool> filtersmap = {
    'Grey scale': false,
    'Normal colors': false,
    'sepia': false,
    'terminal green text': true,
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
    'Rainbow Flag':false,
    'Rainbow Flag Reversed':false,
    'Rainbow Random':false,
    'Random colors':false,
    'cmatrix':false,
    'cmatrix full colors': false

    
  };

  // Map<String, bool> typemap = {
  //   'image': true,
  //   'text': false,
  // };

  Map<String, bool> brcmap = {
    'white': false,
    'black': true,
  };

  Map<String, bool> fontmap = {'14 px': true, '24 px': false};

  Map<String, bool> symbolsmap = {
    'letters and symbols': true,
    'only symbols': false,
    'only letters': false
  };

  int? columns = 120;

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
                filtersmap, brcmap, fontmap, symbolsmap, counter,qouting);
            // photohash(imgfobj);
            fadeframes(imgfobj);
            shiftframes(imgfobj);
            // cmatrixframscolor(imgfobj);
                      // var imgfobjtxt =  Imgfilterobjtxt(imagebytes!, columns!, symbolsmap);

     
                      //      photohashtxt(imgfobjtxt); 

                    counter++;
      //     }
      //   }
      // }
    }
  });
}