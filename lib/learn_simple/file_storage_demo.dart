import 'dart:io';
import 'dart:convert';

//https://juejin.im/post/5bf13747e51d4552ee424078

//TODO 文件、存储和网络

void main() async {
//  foo();
  testJson();
}

void foo() async {
  const filePath = "file_storage.txt";
  var dir = Directory("lib");

  print(dir.absolute.path);

  var file = File(dir.absolute.path + "\\" + filePath);
  IOSink sink;
  try {
    bool exists = await file.exists();
    if (!exists) {
      await file.create();

//     file.writeAsStringSync("haha first write");
      // ignore: close_sinks

    }

    sink = file.openWrite();
    sink.writeln("sink write");
  } catch (e) {
    print(e);
  } finally {
    sink?.close();
  }
}

//json

class Point {
  final int x;
  final int y;
  final String desc;

  Point(this.x, this.y, this.desc);

  Map<String, dynamic> toJson() {
    return {'x': x, 'y': y, 'desc': desc};
  }

   static Point fromJson(Map<String, dynamic> map) {
    return Point(map['x'], map['y'], map['desc']);
  }
}

void testJson() {
  var point = Point(1, 2, "point");
  print(point.toJson());
  var jsonStr = json.encode(point);
  print(jsonStr);
  var decodeMap =  json.decode(jsonStr);
  point = Point.fromJson(decodeMap);
  print(point);
}

//http


















