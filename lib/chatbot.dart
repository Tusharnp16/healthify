import 'package:flutter/material.dart';

void main() {
  runApp(ChatScreen());
}

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatScreenPage(),
    );
  }
}

class ChatScreenPage extends StatefulWidget {
  @override
  _ChatScreenPageState createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreenPage> {
  TextEditingController _controller = TextEditingController();
  List<String> _messages = [];

  Map<String, String> _responses = {
  'how can we book appoiment?': 'you can book via appoiment page!',
  'what if my i cancel my appoiment?': 'you will get all refund within 7 buissness days',
  'tell me founder name?': 'it was founded by three genius students from sdj named tony,kony,hony',
  'what happens if I miss my scheduled appointment?': 'You have to schedule again and you can not get refund',
  'what is the process for booking an appointment through the app?': 'You can simply book through appoiment page from homw screen',
  'is it possible to cancel or reschedule an existing appointment?': 'yes, it is as simple as drinking water',
  'can I book appointments for multiple family members?':'Yes,why not you can even schedule your neighbour appoiment!!!',
   ' Can I book appointments with multiple doctors in one session?':'Currently, our system allows booking appointments with one doctor at a time. If you need appointments with multiple doctors, you''ll need to book them separately.',
'Are virtual or telemedicine appointments available?':'Yes, we offer virtual appointments through telemedicine services. You can book a virtual appointment with a healthcare provider through our application.',
'What information do I need to provide during the appointment booking process?' : 'During the booking process, you''ll need to provide basic information such as your name, contact details, reason for the appointment, and any relevant medical history.'
  };

void _sendMessage() {
  setState(() {
    String message = _controller.text.toLowerCase();
    _messages.add(message);
    if (_responses.containsKey(message)) {
      _messages.add(_responses[message]!);
    } else {
      _messages.add(
          "I'm sorry, I don't understand. Or you can contact healthifycomplain@gmail.com");
    }
    _controller.clear();
  });
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Color.fromARGB(220, 59, 206, 255),
      title: const Text(
        "Healthify",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    body: Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_messages[index]),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}}
