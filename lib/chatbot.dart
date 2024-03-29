import 'package:flutter/material.dart';

void main() {
  runApp(ChatBotScreen());
}

class ChatBotScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(

          title: Text('Chat with Doctor'),

        ),
        body: ChatBotBody(),
      ),
    );
  }
}

class ChatBotBody extends StatefulWidget {
  @override
  _ChatBotBodyState createState() => _ChatBotBodyState();
}

class _ChatBotBodyState extends State<ChatBotBody> {
  final TextEditingController _controller = TextEditingController();
  List<String> _chatMessages = [];

  void _handleSubmitted(String text) {
    _controller.clear();
    setState(() {
      _chatMessages.add('You: $text');
      // Here you can implement your chatbot logic to generate responses
      // For a simple example, let's just echo back the user's message
      _chatMessages.add('Doctor: $text');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          child: ListView.builder(
            padding: EdgeInsets.all(8.0),
            reverse: true,
            itemCount: _chatMessages.length,
            itemBuilder: (_, int index) => _buildMessage(_chatMessages[index]),
          ),
        ),
        Divider(height: 1.0),
        Container(
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: _buildTextComposer(),
        ),
      ],
    );
  }

  Widget _buildMessage(String message) {
    return ListTile(
      title: Text(
        message,
        textAlign: message.startsWith('You:') ? TextAlign.end : TextAlign.start,
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).focusColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _controller,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(hintText: 'Send a message'),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () => _handleSubmitted(_controller.text),
            ),
          ],
        ),
      ),
    );
  }
}
