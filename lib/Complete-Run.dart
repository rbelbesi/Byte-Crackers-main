import 'package:flutter/material.dart';
class CompleteRun extends StatelessWidget {
  const CompleteRun({super.key});

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
                    Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
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
                 
                },
                child: const Text(
                  'complete',
                  style: TextStyle(
                    fontSize: 19.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ]

    );
}}