import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'codepage.dart';


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

List<int> Registers = createRegisterList(8);//create list of register

List<int> createRegisterList(int count) { //fill the list of register with 0
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
       Scaffold(
         backgroundColor: const Color.fromARGB(255, 91, 139, 243),
        
         body: 
         SafeArea(
          
           child: SingleChildScrollView(
            child: 
            Stack(
              children:[ 
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'images/image-3.png',
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
                Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                     Container(
                alignment: Alignment.center,
                width:290,
                height: 60,
                child: Row(children: [
                  const SizedBox(height: 30),
                  Text(
                    'Enter Register Values:',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ]),
              ),
                  for (int i = 0; i < 8; i++)
                    Row(
                      crossAxisAlignment :CrossAxisAlignment.center, 
                      children: [
                        SizedBox(width: 50,),
                        
                        Container(
                          width: 300,
                           decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.025),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                          child: 
                          Row(
              
                            children: [
                              SizedBox(width: 20,),
                              Text('\$t$i: ',style: const TextStyle(
                      fontSize: 18,),),
                              Expanded(
                              child: TextField(
                                controller: registerControllers[i],
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                decoration: const InputDecoration(
                                  labelText: 'Enter A Decimal Value',
                                    border: InputBorder.none,
                                ),
                              ),
                            ),
                      ]),
                        ),
                        SizedBox(height: 70,),
                      ],
                    ),
                  const SizedBox(height: 10),
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
                    child: const Text('Next',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17
                    ),
                    ),
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(const Size(150, 36)),
                     backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                      
                        return Color.fromARGB(255, 255, 193, 59).withOpacity(0.8);
                      }
                  
                      return Color.fromARGB(255, 255, 193, 59);
                    },
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                
                        return Colors.white.withOpacity(0.8);
                      }
              
                      return Colors.white;
                    },
                  ),
                    ),
                  ),
                ],
              ),
              ],
            ),
                 ),
         ),
       );
    
  }

  bool isValidValue(String value) {
    try {
      int intValue = int.parse(value);
      return intValue >= 0 && intValue <= 255;
    } catch (e) {
      return false;
    }
  }
}
