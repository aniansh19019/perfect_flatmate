import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:perfect_flatmate/services/chats.dart';
import 'package:perfect_flatmate/services/auth.dart';

class Messaging extends StatefulWidget {
  final String otherEmail;
  const Messaging({super.key, required this.otherEmail, required});

  @override
  State<Messaging> createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
  final TextEditingController _textEditingController = TextEditingController();
  // widget.otherEmail
  final _firebase = FirebaseFirestore.instance;
  late final Stream<QuerySnapshot<Map<String, dynamic>>> _chatStream;

  @override
  void initState() {
    super.initState();
    // Set up chat stream
    _chatStream = _firebase
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.otherEmail),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _chatStream,
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
