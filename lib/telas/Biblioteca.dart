import 'package:flutter/material.dart';

class Biblioteca extends StatefulWidget {
  @override
  _BibliotecaState createState() => _BibliotecaState();
}

class _BibliotecaState extends State<Biblioteca> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Bibioteca",
          style: TextStyle(
            fontSize: 25
          ),
        ),
      ),
    );
  }
}