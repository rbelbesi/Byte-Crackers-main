import 'package:flutter/material.dart';
import 'codepage.dart';
import 'package:flutter/services.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: RegisterInputPage(),
      ),
    );
  }
}

class RegisterInputPage extends StatefulWidget {
  const RegisterInputPage({Key? key}) : super(key: key);

  @override
  _RegisterInputPageState createState() => _RegisterInputPageState();
}

List<int> Registers = createRegisterList(8);

List<int> createRegisterList(int count) {
  List<int> registers = List<int>.filled(count, 0);
  return registers;
}

class _RegisterInputPageState extends State<RegisterInputPage> {
  List<TextEditingController> registerControllers = List.generate(
    8,
    (index) => TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
    return 
    SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 8; i++)
              Row(
                children: [
                  Text('\$t$i: '),
                  Expanded(
                    child: TextField(
                      controller: registerControllers[i],
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        labelText: 'Enter A Decimal value',
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                List<int> updatedRegisters = [];
                bool isValid = true;
                for (int i = 0; i < 8; i++) {
                  String registerValue = registerControllers[i].text.trim();
      
                  if (isValidValue(registerValue)) {
                    updatedRegisters.add(int.parse(registerValue));
                  } else {
                    isValid = false;
                    break;
                  }
                }
      
                if (isValid) {
                  // Update Registers with the new values
                  Registers = updatedRegisters;
      
                  // Navigate to CodePage with the updated Registers list
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CodePage(Registers: Registers),
                    ),
                  );
                } else {
                  // Show an error message
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Please enter A valid Decimal values From 0 to 255.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  bool isValidValue(String value) {
    try {
      int intValue = int.parse(value);
      return intValue >= 0 && intValue <= 255;
    } catch (e) {
      return false; // Not a valid integer
    }
  }
}
