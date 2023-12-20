import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class CodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 91, 139, 243),
        body: AppPage(),
      ),
    );
  }
}

class AppPage extends StatefulWidget {
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
          print('Assemble button tapped');
        },
        confirmBtnTextStyle: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        confirmBtnColor: Color.fromARGB(255, 91, 139, 243),
        cancelBtnText: 'Complete', // Second button text
        onCancelBtnTap: () {
          print('Cancel button tapped');
        },
        cancelBtnTextStyle: TextStyle(
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
        confirmBtnTextStyle: TextStyle(
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
            child: Container(
              width: 300,
              child: TextField(
                maxLines: null,
                style: TextStyle(),
                onChanged: (text) {
                  setState(() {
                    enteredText = text;
                  });
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white),
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
                  minimumSize: MaterialStateProperty.all<Size>(Size(200, 36)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 255, 193, 59),
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 255, 255, 255),
                  ),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered))
                        return Color.fromARGB(255, 255, 255, 255);
                      if (states.contains(MaterialState.focused) ||
                          states.contains(MaterialState.pressed))
                        return Color.fromARGB(255, 255, 255, 255);
                      return null;
                    },
                  ),
                ),
                onPressed: () {
                  handleButtonPress();
                },
                child: Text(
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
