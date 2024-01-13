import 'package:flutter/material.dart';

class CompleteRun extends StatelessWidget {
  final List<String> lines;
  final List<int> Registers;

  const CompleteRun({
    Key? key,
    required this.lines,
    required this.Registers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 91, 139, 243),
      body: SafeArea(
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Row(children: [
                  const SizedBox(height: 160
                  ),
                ]),
              ),
              Container(
                alignment: Alignment.center,
                width: 265,
                height: 80,
                child: Row(children: [
                  const SizedBox(height: 30),
                  Text(
                    'Complete Run',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ]),
              ),
              Container(
                alignment: Alignment.center,
                width: 350,
                height: 80,
                child: Row(
                  children: [
                    const SizedBox(width: 30),
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
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '\$t$i',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 91, 139, 243),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              '${widget.Registers[i]}',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 91, 139, 243),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                width: 400,
                height: 5,
              ),
              Container(
                alignment: Alignment.center,
                width: 350,
                height: 80,
                child: Row(
                  children: [
                    const SizedBox(width: 30),
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
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '\$t$i',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 91, 139, 243),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              '${widget.Registers[i]}',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 91, 139, 243),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          ]
        ),
      ),
      floatingActionButton:
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          width: 185,
        ),
        FloatingActionButton(
          splashColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 255, 193, 59),
          onPressed: () {
            try {
              run();
            } catch (e) {
              print('Error: $e');
            }
          },
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 30,
          ),
        ),
        SizedBox(
          height: 350,
        ),
      ]),
    );
  }

  void run() {
    int numberOfInst = widget.lines.length;
    Instruction inst = Instruction('', '', '', '');

    for (int i = 0; i < numberOfInst; i++) {
      inst = decode(widget.lines[i]);
      ExcuteWriteBack(inst);
    }

  }

  Instruction decode(String instr) {
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
      if ("\$t$i" == inst.GetDist()) {
        distindex = i;
      }
      if ("\$t$i" == inst.GetSrc1()) {
        src1index = i;
      }
      if ("\$t$i" == inst.GetSrc2()) {
        src2index = i;
      }
    }

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

  int getRegisterIndex(String registerName) {
    for (int i = 0; i < 8; i++) {
      if ("\$t$i" == registerName) {
        return i;
      }
    }
    return 0; 
  }
}
