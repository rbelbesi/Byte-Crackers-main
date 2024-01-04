import 'package:flutter/material.dart';
import 'Registers.dart';
import 'codepage.dart';

void main() {
  runApp(StepByStep(
    lines: [],
    Registers: [0, 0, 0, 0, 0, 0, 0, 0],
  ));
}

class StepByStep extends StatelessWidget {
  final List<String> lines;
  final List<int> Registers;
  const StepByStep({Key? key, required this.lines, required this.Registers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 91, 139, 243),
        body: MIPSArchitecture(lines: lines, Registers: Registers),
      ),
    );
  }
}

class MIPSArchitecture extends StatefulWidget {
  final List<String> lines;
  final List<int> Registers;
  const MIPSArchitecture({
    Key? key,
    required this.lines,
    required this.Registers,
  }) : super(key: key);

  @override
  _MIPSArchitectureState createState() => _MIPSArchitectureState();
}

class Instruction {
  String Inst;
  String dist;
  String src1;
  String src2;
  Instruction(this.Inst, this.dist, this.src1, this.src2);
  String GetInstructionName() {
    return Inst;
  }

  String GetDist() {
    return dist;
  }

  String GetSrc1() {
    return src1;
  }

  String GetSrc2() {
    return src2;
  }
}

class _MIPSArchitectureState extends State<MIPSArchitecture> {
  Instruction Decode(String instr) {
    RegExp pattern = RegExp(
        r'^(add|sub|and|slt|sll)\s*(\$t[0-7]),\s*(\$t[0-7]),\s*(\$t[0-7])$');
    Iterable<RegExpMatch> matches = pattern.allMatches(instr);

    String instruction = '';
    String operand1 = '';
    String operand2 = '';
    String operand3 = '';

    for (RegExpMatch match in matches) {
      instruction = match.group(1)!;
      operand1 = match.group(2)!;
      operand2 = match.group(3)!;
      operand3 = match.group(4)!;
    }

    return Instruction(instruction, operand1, operand2, operand3);
  }

  void ExcuteWriteBack(Instruction inst) {
    int distindex = 0;
    int src1index = 0;
    int src2index = 0;

    for (int i = 0; i < 8; i++) {
      if ("\$t${i}" == inst.GetDist()) {
        distindex = i;
      }
      if ("\$t${i}" == inst.GetSrc1()) {
        src1index = i;
      }
      if ("\$t${i}" == inst.GetSrc2()) {
        src2index = i;
      }
    }

    print('distindex: $distindex');
    print('src1index: $src1index');
    print('src2index: $src2index');

    if (inst.GetInstructionName() == 'add') {
      widget.Registers[distindex] =
          widget.Registers[src1index] + widget.Registers[src2index];
    }
    if (inst.GetInstructionName() == 'sub') {
      widget.Registers[distindex] =
          widget.Registers[src1index] - widget.Registers[src2index];
    }
    if (inst.GetInstructionName() == 'and') {
      widget.Registers[distindex] =
          widget.Registers[src1index] & widget.Registers[src2index];
    }
    if (inst.GetInstructionName() == 'slt') {
      widget.Registers[distindex] =
          widget.Registers[src1index] < widget.Registers[src2index] ? 1 : 0;
    }
    if (inst.GetInstructionName() == 'sll') {
      widget.Registers[distindex] =
          widget.Registers[src1index] << widget.Registers[src2index];
    }
    setState(() {
      print('UI updated');
    });
  }

  void Run() {
    int numberOfInst = widget.lines.length;
    Instruction inst = Instruction('', '', '', '');

    for (int i = 0; i < numberOfInst; i++) {
      print('${widget.lines[i]}');
      inst = Decode(widget.lines[i]);
      ExcuteWriteBack(inst);
    }
    print('Run completed.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: 350,
              height: 80,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(children: [
                SizedBox(
                  width: 15,
                  height: 70,
                ),
                Container(
                  alignment: Alignment.center,
                  width: 70,
                  height: 70,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                SizedBox(
                  width: 15,
                  height: 70,
                ),
                Container(
                  alignment: Alignment.center,
                  width: 35,
                  height: 70,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                SizedBox(
                  width: 15,
                  height: 70,
                ),
                Container(
                  alignment: Alignment.center,
                  width: 70,
                  height: 70,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                SizedBox(
                  width: 15,
                  height: 70,
                ),
                Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 35,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ]),
            ),
            SizedBox(
              width: 400,
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              width: 350,
              height: 80,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 400,
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              width: 350,
              height: 80,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 400,
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              width: 350,
              height: 80,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 400,
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              width: 350,
              height: 80,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 400,
              height: 5,
            ),
            Container(
              alignment: Alignment.center,
              width: 350,
              height: 80,
              child: Row(children: [
                SizedBox(
                  width: 30,
                ),
                for (int i = 0; i < 4; i++)
                  Container(
                    alignment: Alignment.center,
                    width: 72.5,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '\$t$i',
                          style: TextStyle(
                            color: Color.fromARGB(255, 91, 139, 243),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '${widget.Registers[i]}',
                          style: TextStyle(
                            color: Color.fromARGB(255, 91, 139, 243),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ]),
            ),
            Container(
              alignment: Alignment.center,
              width: 350,
              height: 65,
              child: Row(children: [
                SizedBox(
                  width: 30,
                ),
                for (int i = 4; i < 8; i++)
                  Container(
                    alignment: Alignment.center,
                    width: 72.5,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '\$t$i',
                          style: TextStyle(
                            color: Color.fromARGB(255, 91, 139, 243),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '${widget.Registers[i]}',
                          style: TextStyle(
                            color: Color.fromARGB(255, 91, 139, 243),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ]),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          try {
            Run();
          } catch (e) {
            print('Error: $e');
          }
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}

class RegisterBox extends StatelessWidget {
  final String registerName;
  final int registerValue;

  const RegisterBox({
    Key? key,
    required this.registerName,
    required this.registerValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            registerName,
            style: TextStyle(
              color: Color.fromARGB(255, 91, 139, 243),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            '$registerValue',
            style: TextStyle(
              color: Color.fromARGB(255, 91, 139, 243),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
