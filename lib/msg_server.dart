import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:flutter_app/msgclient.dart';

class HttpEchoServer {
  static const GET = "GET";
  static const POST = "POST";

  static const tableName = 'History';
  static const columnId = 'id';
  static const columnMsg = 'msg';
  static const columnTimestamp = "timestamp";

  String historyFilePath;

  final int port;

  HttpServer httpServer;
  Database database;

  Map<String, void Function(HttpRequest)> routes;
  final List<Message> messages = [];

  HttpEchoServer(this.port) {
    _initRoutes();
  }

  Future start() async {
    historyFilePath = await _historyPath();
    await _initDatabase();
    await _loadMessages();
    httpServer = await HttpServer.bind(InternetAddress.loopbackIPv4, port);

    //开始监听请求
    return httpServer.listen((request) {
      final path = request.uri.path;
      final handler = routes[path];
      if (handler != null) {
        handler(request);
      } else {
        request.response.statusCode = HttpStatus.notFound;
        request.response.close();
      }
    });
  }

  Future<String> _historyPath() async {
    final directory = await path_provider.getApplicationDocumentsDirectory();
    return directory.path + "/messages.json";
  }

  void _initDatabase() async {
    var path = await getDatabasesPath() + "/history.db";
    database =
        await openDatabase(path, version: 1, onCreate: (db, version) async {
      var sql = '''
            CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY,
            $columnMsg TEXT,
            $columnTimestamp INTEGER
            )
            ''';
      await db.execute(sql);
    });
  }

  void _unsupportedMethod(HttpRequest request) {
    request.response.statusCode = HttpStatus.methodNotAllowed;
    request.response.close();
  }

  void _history(HttpRequest request) {
    if (request.method != GET) {
      _unsupportedMethod(request);
      return;
    }
    String historyData = json.encode(messages);
    request.response.write(historyData);
  }

  Future<bool> _storeMessages() async {
    try {
      final data = json.encode(messages);
      final file = File(historyFilePath);
      final exits = await file.exists();
      if (!exits) {
        await file.create();
      }
      file.writeAsString(data);
      return true;
    } catch (e) {
      print("_storeMessages:$e");
      return false;
    }
  }

  void _echo(HttpRequest request) async {
    if (request.method != POST) {
      _unsupportedMethod(request);
      return;
    }

    String body = await request.transform(utf8.decoder).join();
    if (body != null) {
      var message = Message.create(body);
      messages.add(message);
      request.response.statusCode = HttpStatus.ok;
      // json 是 convert 包里的对象，encode 方法还有第二个参数 toEncodable。当遇到对象不是
      // Dart 的内置对象时，如果提供这个参数，就会调用它对对象进行序列化；这里我们没有提供，
      // 所以 encode 方法会调用对象的 toJson 方法，这个方法在前面我们已经定义了
      var data = json.encode(message);
      // 把响应写回给客户端
      request.response.write(data);
      _storeMessage(message);
    } else {
      request.response.statusCode = HttpStatus.badRequest;
    }
    request.response.close();
    _storeMessages();
  }

  void _storeMessage(Message msg) {
    database.insert(tableName, msg.toJson());
  }

  void _loadMessages() async {
    var list = await database.query(tableName,
        columns: [columnMsg, columnTimestamp], orderBy: columnId);
    for (var item in list) {
      var msg = Message.fromJson(item);
      messages.add(msg);
    }
  }

  void close() async {
    var server = httpServer;
    httpServer = null;
    await server?.close();
    var db = database;
    database = null;
    db?.close();
  }

  void _initRoutes() {
    routes = {
      '/history': _history,
      '/echo': _echo,
    };
  }
}
