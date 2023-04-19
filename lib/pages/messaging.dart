import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:perfect_flatmate/services/chats.dart';

class Messaging extends StatefulWidget {
  final String otherEmail;
  const Messaging({super.key, required this.otherEmail, required});

  @override
  State<Messaging> createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
  final TextEditingController _textEditingController = TextEditingController();
  // widget.otherEmail
  final List<String> _messages = [
    'Hello!',
    'Hi there!',
    'How are you?',
    'I\'m doing well, thanks. How about you?',
    'I\'m good too, thanks for asking.',
    'Great!'
  ];

  void _sendMessage(String message) {
    setState(() {
      _messages.add(message);
      _textEditingController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    //MessageHelper.getAllMessages();
    //log(messages.toString());
    //debugPrint(messages);
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text(widget.otherEmail ?? "No parameter passed"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = _messages[index];
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                    alignment: message.startsWith('I')
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: message.startsWith('I')
                            ? Colors.grey[300]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        message,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    onSubmitted: (message) {
                      _sendMessage(message);
                    },
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final message = _textEditingController.text.trim();
                    if (message.isNotEmpty) {
                      _sendMessage(message);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
