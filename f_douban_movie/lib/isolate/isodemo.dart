import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/foundation.dart';

void main() async {
  print(await asyncFib(30));
//  Future.delayed
}

Future asyncFib(int n) async {
  final response = ReceivePort();

  await Isolate.spawn(_isolate, response.sendPort);

  final sendPort = await response.first as SendPort;

  final answer = new ReceivePort();
  sendPort.send([n, answer.sendPort]);

  return answer.first;
}

void _isolate(SendPort initReplayTo) {
  final port = new ReceivePort();
  initReplayTo.send(port.sendPort);
  port.listen((message) {
    final data = message[0] as int;
    final send = message[1] as SendPort;

    send.send(syncFibonacci(data));
  });
}

int syncFibonacci(int n) {
  return n < 2 ? n : syncFibonacci(n - 2) + syncFibonacci(n - 1);
}


Future fib() async{
  return compute(syncFibonacci, 20);
}

