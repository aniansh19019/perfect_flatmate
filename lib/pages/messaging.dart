import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:perfect_flatmate/services/chats.dart';
import 'package:perfect_flatmate/services/auth.dart';
import 'package:perfect_flatmate/util/theme.dart';
import 'package:intl/intl.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.otherName),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
              future: _chats,
              builder: (context, AsyncSnapshot<List> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }

                final chatDocs = snapshot.data!;
                return ListView.builder(
                  reverse: true,
                  itemCount: chatDocs.length,
                  itemBuilder: (context, index) {
                    final chatDoc = chatDocs[index].data()!;
                    final isSelf = chatDoc['FromID'] == Auth.getCurrentUser();
                    return Align(
                      alignment:
                          isSelf ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isSelf
                              ? CustomTheme.primaryPink
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              chatDoc['content'],
                              style: TextStyle(
                                color: isSelf ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              DateFormat('hh:mm')
                                  .format(chatDoc['timestamp'].toDate()),
                              style: TextStyle(
                                color: isSelf ? Colors.white70 : Colors.black45,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
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
                      hintText: 'Type your message',
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
