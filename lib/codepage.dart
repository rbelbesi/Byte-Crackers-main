import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'Step-By-Step.dart';
import 'Complete-Run.dart';
class CodePage extends StatelessWidget {
  const CodePage({super.key});

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
  String enteredText = '';
  void handleButtonPress() {
    List<String> lines = enteredText.split('\n');
    RegExp pattern =
        RegExp(r'^(add|sub|and|slt|sll) \$t[0-7], \$t[0-7], \$t[0-7]$');
    bool allLinesFollowFormat = true;
    // Iterate through each line
    for (String line in lines) {
      // Check if the line matches the desired format
      if (!pattern.hasMatch(line)) {
        allLinesFollowFormat = false;
        break; // No need to continue checking if one line does not follow the format
      }
    }

    // Show an alert based on the result
    if (allLinesFollowFormat) {
      QuickAlert.show(
        context: context,
        title: 'Assemble Succeed',
        text: 'Choose Run-Option',
        type: QuickAlertType.confirm,
        confirmBtnText: 'Step-By_Step',
        onConfirmBtnTap: () {
        
         Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StepByStep(),
                ),
              );
              
        },
        confirmBtnTextStyle: const TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        confirmBtnColor: const Color.fromARGB(255, 91, 139, 243),
        cancelBtnText: 'Complete', // Second button text
        onCancelBtnTap: () {
         Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CompleteRun(),
                ),
              );
              
        },
        cancelBtnTextStyle: const TextStyle(
          fontSize: 14,
          color: Color.fromARGB(255, 91, 139, 243),
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      QuickAlert.show(
        context: context,
        title: 'Error',
        text: 'Make sure that your code\nfollow the rules.',
        type: QuickAlertType.error,
        confirmBtnText: 'Back To Editor',
        confirmBtnTextStyle: const TextStyle(
          fontSize: 13,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
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
          Positioned(
            bottom: 300,
            left: 40,
            child: Image.asset(
              'images/image-5.png',
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.height * 0.25,
              fit: BoxFit.contain,
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
          ),
        ],
      ),
    );
  }
}
