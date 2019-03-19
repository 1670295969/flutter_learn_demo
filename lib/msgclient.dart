import 'package:flutter/material.dart';

void main(){
  runApp(AppStart());
}

class Message {
  final String msg;
  final int timestamp;

  Message(this.msg, this.timestamp);

  @override
  String toString() {
    // TODO: implement toString
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
                  Message(editController.text,
                      DateTime.now().millisecondsSinceEpoch));
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
  final messageListKey = GlobalKey<_MessageListState>(debugLabel: "messageListKey");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Echo client"),
      ),
      body: MessageList(key:messageListKey),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddMessageScreen()));
//          debugPrint(result);
          if(result is Message){
            messageListKey.currentState.addMessage(result);
          }
        },
        tooltip: "Add Message",
        child: Icon(Icons.add),
      ),
    );
  }
}

class MessageList extends StatefulWidget{

  MessageList({Key key}) :super(key:key);
  @override
  State<StatefulWidget> createState() {
    return _MessageListState();
  }

}


class _MessageListState extends State<MessageList>{
  final List<Message> messageList = [];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messageList.length,
      itemBuilder: (context,index){
        final msg = messageList[index];
        final subTitle = DateTime.fromMicrosecondsSinceEpoch(msg.timestamp).toLocal().toIso8601String();
        return ListTile(
          title: Text(msg.msg),
          subtitle: Text(subTitle),
        );
      },
    );
  }


  void addMessage(Message msg){
    setState(() {
      messageList.add(msg);
    });
  }

}



















































