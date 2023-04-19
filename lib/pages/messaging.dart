import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:perfect_flatmate/services/chats.dart';
import 'package:perfect_flatmate/services/auth.dart';

class Messaging extends StatefulWidget {
  final String otherEmail;
  final String otherName;
  const Messaging(
      {super.key, required this.otherEmail, required this.otherName});

  @override
  State<Messaging> createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
  final TextEditingController _textEditingController = TextEditingController();
  // widget.otherEmail
  final _firebase = FirebaseFirestore.instance;
  late final Future<List> _chats;

  @override
  void initState() {
    // Set up chat stream
    _chats = MessageHelper.getChats(widget.otherEmail);
    
    
    // _chatStream2 = _firebase
    //     .collection('messages')
    //     .where('FromID', isEqualTo: Auth.getCurrentUser())
    //     .get();
    //_chatStream = await Future.wait([_chatStream1,_chatStream2]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) 
  {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.otherName),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
              future: _chats,
              builder: (context, AsyncSnapshot<List> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator(
                  ));
                }
                if(snapshot.hasError)
                {
                  return Center(child: Text(snapshot.error.toString()),);
                }

                final chatDocs = snapshot.data!;
                return ListView.builder(
                  reverse: true,
                  itemCount: chatDocs.length,
                  itemBuilder: (context, index) {
                    final chatDoc = chatDocs[index].data()!;
                    final isSelf = chatDoc['FromID'] == Auth.getCurrentUser();
                    return ListTile(
                      title: Text(chatDoc['content']),
                      subtitle: Text(chatDoc['timestamp'].toString()),
                      trailing: isSelf
                          ? null
                          : CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://picsum.photos/64?random=$index'),
                            ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Enter a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _sendMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    if (_textEditingController.text.isEmpty) {
      return;
    }

    final chatRef = FirebaseFirestore.instance.collection('messages').doc();
    final currentUser = Auth.getCurrentUser();
    await chatRef.set({
      'content': _textEditingController.text,
      'FromID': Auth.getCurrentUser(),
      'ToID': widget.otherEmail,
      'timestamp': FieldValue.serverTimestamp(),
    });

    _textEditingController.clear();
  }
}
