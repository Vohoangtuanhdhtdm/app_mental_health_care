import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void register() {
    popPage();
  }

  void popPage() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Register")));
  }
}
