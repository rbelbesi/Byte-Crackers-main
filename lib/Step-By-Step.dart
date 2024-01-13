import 'package:flutter/material.dart';

class StepByStep extends StatelessWidget {

  //two parameters their values passed by the previous page (codepage)
  final List<String> lines;
  final List<int> Registers;
  const StepByStep({
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

class _MIPSArchitectureState extends State<MIPSArchitecture> {
  int fetchIndex = 0;
  List<int> pipelineIndices = [-1, -1, -1, -1, -1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 91, 139, 243),
      body: SafeArea(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 265,
                  height: 80,
                  child: Row(children: [
                    const SizedBox(width: 17
                    ),
                    Text(
                      'Step By Step',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ]),
                ),
                for (int stage = 0; stage < 5; stage++)//Build the 5 stages structure
                  Container(
                    alignment: Alignment.center,
                    width: 350,
                    height: 65,
                    margin: const EdgeInsets.symmetric(vertical: 5),
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
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 25,
                          child: Text(
                            getStageName(stage),//Fetch-Decode-Excecute-Memory-WriteBack
                            style: const TextStyle(
                              color: Color.fromARGB(255, 91, 139, 243),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        buildStageContent(stage),//Where is every instruction
                      ],
                    ),
                  ),
                Container(
                  alignment: Alignment.center,
                  width: 350,
                  height: 80,
                  child: Row(
                    children: [
                      const SizedBox(width: 30),
                      for (int i = 0; i < 4; i++)//build the first 4 Temporery Registers
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
                                '\$t$i',//Register Name
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 91, 139, 243),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                '${widget.Registers[i]}',//Register value
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
                const SizedBox(
                  width: 400,
                  height: 5,
                ),
                Container(
                  alignment: Alignment.center,
                  width: 350,
                  height: 60,
                  child: Row(
                    children: [
                      const SizedBox(width: 30),
                      for (int i = 4; i < 8; i++)//build the rest of registers
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
                                '\$t$i',//Register name
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 91, 139, 243),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                '${widget.Registers[i]}',//Register Value
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
              run();//on every Run every instruction will pass to the next stage
            } catch (e) {
              print('Error: $e');//to catch any error 
            }
          },
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 30,
          ),
        ),
        SizedBox(
          height: 110,
        ),
      ],
      ),
      
    
    );
  }

  void run() {
    if (pipelineIndices[4] < widget.lines.length) {
      // Move instructions through the pipeline
      for (int i = 4; i > 0; i--) {
        pipelineIndices[i] = pipelineIndices[i - 1];
      }
      pipelineIndices[0] = fetchIndex++;

      //update the UI with every new Run
       setState(() {
        print('UI updated');
      });
    }
    //just chaange the values of temporery registrers which
    //involved wit the instruction in the writeback stage
    if(pipelineIndices[4]!=-1){
    Instruction inst = decode(widget.lines[pipelineIndices[4]]);
    ExcuteWriteBack(inst);
    };
     
    

  }

  String getStageName(int stage) {
    switch (stage) {
      case 0:
        return 'Fetch';
      case 1:
        return 'Decode';
      case 2:
        return 'Execute';
      case 3:
        return 'Memory';
      case 4:
        return 'Write Back';
      default:
        return '';
    }
  }

  Widget buildStageContent(int stage) {
    if (pipelineIndices[stage] != -1 && //check if stage empty
        pipelineIndices[stage] < widget.lines.length) { //do not proceed if all instructions exected
      String currentInstruction = '';
      currentInstruction = widget.lines[pipelineIndices[stage]];//get the instruction of this stage
      Instruction inst = decode(currentInstruction);
      //fill every stage with the information of its instruction
      switch (stage) {
        case 0:
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
                width: 20,
              ),
              Text(
                'PC= ${pipelineIndices[stage]}    ,',
                style: const TextStyle(
                  color: Color.fromARGB(255, 91, 139, 243),
                  fontSize: 17,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                'inst: $currentInstruction',
                style: const TextStyle(
                  color: Color.fromARGB(255, 91, 139, 243),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          );

        case 1:
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                'OP: ${inst.GetInstructionName()}   ,',
                style: const TextStyle(
                  color: Color.fromARGB(255, 91, 139, 243),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'Dist: ${inst.GetDist()}   ,',
                style: const TextStyle(
                  color: Color.fromARGB(255, 91, 139, 243),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'src1: ${inst.GetSrc1()}   ,',
                style: const TextStyle(
                  color: Color.fromARGB(255, 91, 139, 243),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'src2: ${inst.GetSrc2()}',
                style: const TextStyle(
                  color: Color.fromARGB(255, 91, 139, 243),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          );

        case 2:
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 8,
              ),
              Text(
                '  ${inst.GetDist()} = ${inst.GetSrc1()} ${inst.GetInstructionName()} ${inst.GetSrc2()} ',
                style: const TextStyle(
                  color: Color.fromARGB(255, 91, 139, 243),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          );

        case 3:
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 8,
              ),
              Text(
                '  No Need To Access',
                style: TextStyle(
                  color: Color.fromARGB(255, 91, 139, 243),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          );

        case 4:
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 8,
              ),
              Text(
                '${inst.GetDist()} = ${widget.Registers[getRegisterIndex(inst.GetDist())]}',
                style: const TextStyle(
                  color: Color.fromARGB(255, 91, 139, 243),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          );

        default:
          return Container();
      }
    } else {
      return Container();
    }
  }

  Instruction decode(String instr) {
    RegExp pattern = RegExp(
    r'^(add|sub|and|slt|sll)\s*(\$t[0-7]),\s*(\$t[0-7]),\s*(\$t[0-7])$');
    //devide the string input instruction to multiple groups of matches dependeng on instruction class
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
    //get the inedices of registers
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
    
    //applay the operation on the distenation register
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
//class for the instruction
class Instruction {
  String Inst;
  String dist;
  String src1;
  String src2;
  Instruction(this.Inst, this.dist, this.src1, this.src2);//constructor

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