import 'package:flutter/material.dart';
import 'package:mips/Registers.dart';
import 'Step-By-Step.dart';
import 'Complete-Run.dart';
class CodePage extends StatelessWidget {
  final List<int> Registers;
  const CodePage({Key? key, required this.Registers}) : super(key: key);

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
  String enteredText = '';
  List<String> lines=[];
class _AppPageState extends State<AppPage> {

void handleButtonPress() {
  lines = enteredText.split('\n');
  RegExp pattern =
     RegExp(r'^(add|sub|and|slt|sll)\s*\$t[0-7],\s*\$t[0-7],\s*\$t[0-7]$');
  bool allLinesFollowFormat = true;

  for (String line in lines) {
    if (!pattern.hasMatch(line)) {
      allLinesFollowFormat = false;
      break;
    }
  }

  if (allLinesFollowFormat) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Assemble Succeed',
            style: TextStyle(
              color: Color.fromARGB(255, 11, 185, 5),
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Choose Run-Option',
            style: TextStyle(
              color: Color.fromARGB(255, 161, 160, 160),
              fontSize: 15.0,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StepByStep(lines: lines, Registers: Registers),// Pass your Registers list here if needed
                  
                ),
                );
              },
              child: const Text(
                'Step-By-Step',
                style: TextStyle(
                  color: Color.fromARGB(255, 91, 139, 243),
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CompleteRun(lines: lines, Registers: Registers),
                    
                  ),
                );
              },
              child: const Text(
                'Complete',
                style: TextStyle(
                  color: Color.fromARGB(255, 91, 139, 243),
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Error',
            style: TextStyle(
              color: Colors.red,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Make sure that your code\nfollow the rules.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); 
              },
              child: const Text(
                'Back To Editor',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
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
         
        
          Column(
            children: [
              Container(
  margin: EdgeInsets.fromLTRB(0, 0, 190, 0
  ),
    width: 90.0, 
    height: 90.0, 
    child: Image.asset('images/image-9.png'
    ),
  ),

              Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 300,
              child: TextField(
                maxLines: null,
                style: const TextStyle(),
                onChanged: (text) {
                  setState(() {
                    enteredText = text;
                  });
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  hintText: 'write your code...',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
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
                  handleButtonPress();
                },
                child: const Text(
                  'Assemble',
                  style: TextStyle(
                    fontSize: 19.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),],
          ),
        
          
        ],
        
      ),
    );
  }
}
