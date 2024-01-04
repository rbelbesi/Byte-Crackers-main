import 'package:flutter/material.dart';
import 'Registers.dart'; // Import the CodePage widget from codepage.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
class AppPage extends StatefulWidget{
  const AppPage({super.key});

  @override
  _AppPageState createState() =>_AppPageState();
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

        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            'images/image-12.png',
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        ),

        Positioned(
          bottom: 345,
          child: Image.asset(
            'images/image-1.png',
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.5,
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          bottom: 410,
          child: TextButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(const Size(200, 36)),
              backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromARGB(255, 255, 193, 59),
              ),
              foregroundColor: MaterialStateProperty.all<Color>(
                const Color.fromARGB(255, 255, 255, 255),
              ),
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return const Color.fromARGB(255, 255, 255, 255);
                  }
                  if (states.contains(MaterialState.focused) ||
                      states.contains(MaterialState.pressed)) {
                    return const Color.fromARGB(255, 255, 255, 255);
                  }
                  return null;
                },
              ),
            ),
            onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Register(),
                ),
              );
            },
            child: const Text(
              'Start Coding',
              style: TextStyle(
                fontSize: 19.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      
      ],
    );
  }
}
