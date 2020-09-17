import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssistantPage extends StatefulWidget {
  @override
  _AssistantPageState createState() => _AssistantPageState();
}

class _AssistantPageState extends State<AssistantPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          '扫码',
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: false,
      ),
      body: Text("哈哈"),
    );
  }
}
