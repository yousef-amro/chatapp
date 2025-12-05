import 'package:flutter/material.dart';
import 'package:chatapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class ChatScreen extends StatefulWidget {
  @override
  static const String id = "chatScreen";
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextControler = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String? messageText;

  @override
  void initState() {
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser?.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessage() async {
  //   await for (var snapshot
  //       in _firestore.collection('messages').snapshots()) {
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

  void messagesStream() async {
    final snapshots = await _firestore.collection('messages').get();
    for (var message in snapshots.docs) {
      print(message.data());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              // _auth.signOut();
              // Navigator.pop(context);
              messagesStream();
            },
          ),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextControler,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      messageTextControler.clear();
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser?.email,
                      });
                      print('pressed');
                    },
                    child: Text('Send', style: kSendButtonTextStyle),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').snapshots(),
        builder: (context, snapshot) {
          // 1️⃣ While loading
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // 2️⃣ We are sure snapshot.data is not null here
          final messages = snapshot.data!.docs;
          List<Widget> messageWidgets = [];

          for (var message in messages) {
            // message.data() is Object? so we cast it
            final data = message.data() as Map<String, dynamic>;
            final messageText = data['text'] ?? '';
            final messageSender = data['sender'] ?? 'Unknown';

            final currentUser = loggedInUser?.email;
            if (currentUser == messageSender) {
              // The message is from the logged-in user
            }
            final messageWidget = MessageBubble(
              message: messageText,
              sender: messageSender,
              isMe: currentUser == messageSender,
            );

            messageWidgets.add(messageWidget);
          }

          // 3️⃣ Return a widget with the messages
          return ListView(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 20),
            children: messageWidgets,
          );
        },
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final String sender;
  final bool isMe;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.sender,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: isMe ? Colors.black54 : Colors.blueGrey,
            ),
          ),
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$message',
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
