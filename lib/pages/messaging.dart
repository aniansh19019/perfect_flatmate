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
  late final Future<QuerySnapshot<Map<String, dynamic>>> _chatStream;
  late final Future<QuerySnapshot<Map<String, dynamic>>> _chatStream1;
  late final Future<QuerySnapshot<Map<String, dynamic>>> _chatStream2;
  late final Future<QuerySnapshot<Map<String, dynamic>>> _chatStream3;

  @override
  void initState() {
    // Set up chat stream
    _chatStream = _firebase
        .collection('messages')
        .where('FromID', isEqualTo: widget.otherEmail)
        .where('toID', isEqualTo: Auth.getCurrentUser())
        .get();
    // _chatStream2 = _firebase
    //     .collection('messages')
    //     .where('FromID', isEqualTo: Auth.getCurrentUser())
    //     .get();
    //_chatStream = await Future.wait([_chatStream1,_chatStream2]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.otherName),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: _chatStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final chatDocs = snapshot.data!.docs;
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
