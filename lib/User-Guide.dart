import 'package:flutter/material.dart';
class UserGuide extends StatelessWidget {
  const UserGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 91, 139, 243),
        body: AppPage(),
      ),
    );
  }
}

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
 alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'images/image-3.png',
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          
        ]
        
    );
}}