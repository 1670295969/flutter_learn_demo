import 'package:flutter/material.dart';
import 'package:flutter_app/learn_simple/msg_client.dart';
import 'package:flutter_app/learn_simple/msg_server.dart';

HttpEchoServer _server;
HttpEchoClient _client;

void main() {
  runApp(AppStart());
}

class Message {
  final String msg;
  final int timestamp;

  Message(this.msg, this.timestamp);

  Message.create(String msg)
      : msg = msg,
        timestamp = DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toJson() => {"msg": "$msg", "timestamp": timestamp};

  Message.fromJson(Map<String, dynamic> map)
      : msg = map["msg"],
        timestamp = map["timestamp"];

  @override
  String toString() {
    return "Message{msg:$msg, timestamp:$timestamp}";
  }
}

class MessageForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MessageFormState();
  }
}

class _MessageFormState extends State<MessageForm> {
  final editController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    editController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Input message",
                  contentPadding: EdgeInsets.all(0.0),
                ),
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.black54,
                ),
                controller: editController,
                autofocus: true,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(
                  context,
                  editController.text
                     );
            },
            onDoubleTap: () => debugPrint("double tapped"),
            onLongPress: () => debugPrint("long pressed"),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5.0)),
              child: Text("Send"),
            ),
          ),
        ],
      ),
    );
  }
}

class AppStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter UX demo",
      home: MessageListScreen(),
    );
  }
}

class AddMessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add message"),
      ),
      body: MessageForm(),
    );
  }
}

class MessageListScreen extends StatelessWidget {
  final messageListKey =
      GlobalKey<_MessageListState>(debugLabel: "messageListKey");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Echo client"),
      ),
      body: MessageList(key: messageListKey),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddMessageScreen()));

          if(_client == null){
            return;
          }

          var msg = await _client.send(result);

          if(msg!=null){
            messageListKey.currentState.addMessage(msg);
          }else{
            debugPrint('fail to send $result');
          }
        },
        tooltip: "Add Message",
        child: Icon(Icons.add),
      ),
    );
  }
}

class MessageList extends StatefulWidget {
  MessageList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MessageListState();
  }
}

class _MessageListState extends State<MessageList> with WidgetsBindingObserver {
  final List<Message> messageList = [];


  @override
  void initState() {
    super.initState();
    const port = 6060;
    _server = HttpEchoServer(port);
    _server.start().then((_){
      _client = HttpEchoClient(port);
      _client.getHistory().then((list){
        setState(() {
          messageList.addAll(list);
        });
      });

      WidgetsBinding.instance.addObserver(this);


    });
  }


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messageList.length,
      itemBuilder: (context, index) {
        final msg = messageList[index];
        final subTitle = DateTime.fromMicrosecondsSinceEpoch(msg.timestamp)
            .toLocal()
            .toIso8601String();
        return ListTile(
          title: Text(msg.msg),
          subtitle: Text(subTitle),
        );
      },
    );
  }

  void addMessage(Message msg) {
    setState(() {
      messageList.add(msg);
    });
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if(state == AppLifecycleState.paused){
      var server = _server;
      _server = null;
      server?.close();
    }



  }




}
