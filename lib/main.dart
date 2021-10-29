import 'package:flutter/material.dart';
import 'dart:io';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    ),
  );
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  List<String> text = [
    '8',
    '7',
    '9',
    '=',
    '4',
    '5',
    '6',
    '.',
    '1',
    '2',
    '3',
    '+',
    '0 ',
    'C ',
    '-',
    '* '
  ];
  List<Color> colors = [
    Color(0xffA6A6A6),
    Color(0xffA6A6A6),
    Color(0xffA6A6A6),
    Color(0xffFFA008),
    Color(0xff343434),
    Color(0xff343434),
    Color(0xff343434),
    Color(0xffFFA008),
    Color(0xff343434),
    Color(0xff343434),
    Color(0xff343434),
    Color(0xffFFA008),
    Color(0xff343434),
    Color(0xffFFA008),
    Color(0xffFFA008),
    Color(0xffFFA008),
  ];

  final _controller = TextEditingController();
  List<String> value = [];
  String result = '';
  String operation = '';

  setResult(String operation, List<String> value) {
    switch (operation) {
      case 'add':
        int sum = 0;
        value.forEach((e) {
          sum = sum + int.parse(e);
        });
        setState(() {
          result = sum.toString();
        });

        break;
      case 'sub':
        List<int> intValues = value.map((e) => int.parse(e)).toList();

        int sub = intValues.reduce((value, e) => value - e);

        setState(() {
          result = sub.toString();
        });

        // do something else
        break;
      case 'mul':
        List<int> intValues1 = value.map((e) => int.parse(e)).toList();
        final multiplication =
            intValues1.reduce((value, element) => value * element);

        setState(() {
          result = multiplication.toString();
        });
        //
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff020202),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,

          ),
          Container(
            height: 200,
            padding: EdgeInsets.only(top: 0, left: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(49)),
              color: Color(0xff020202),
            ),
            child: Container(
              padding: EdgeInsets.only(top: 60, left: 40),
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 65,
                    color: Colors.white),
                controller: _controller,
                cursorWidth: 520,
                cursorHeight: 90,
                cursorColor: Color(0xff020202),
                maxLength: 19,
                //	maxLengthEnforcement : false,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Calculator'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(result,
                style: TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
          Flexible(
            child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 60),
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.95,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 29.0,
                ),
                itemCount: 16,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      print(value);

                      setState(() {
                        if (i == 12 ||
                            i == 0 ||
                            i == 1 ||
                            i == 2 ||
                            i == 4 ||
                            i == 5 ||
                            i == 6 ||
                            i == 8 ||
                            i == 9 ||
                            i == 10) {
                          _controller.text = _controller.text + text[i];
                        }
                        if (i == 13) {
                          value = [];
                          _controller.clear();
                          result = '';
                        }
                        if (i == 14) {
                          value.add(_controller.text);
			  setState((){
                                  colors[i]=Colors.white;
                          });
                          operation = 'sub';
                          _controller.clear();
                        }
                        if (i == 11) {
                          value.add(_controller.text);
			  setState((){
				  colors[i]=Colors.white;
			  });
                          _controller.clear();

                          operation = 'add';
                        }
                        if (i == 15) {
                          value.add(_controller.text);
			  setState((){
                                  colors[i]=Colors.white;
                          });
                          _controller.clear();
                          operation = 'mul';
                        }
                        if (i == 3) {

				setState((){
				colors[11]=Color(0xffFFA008);
				colors[15]=Color(0xffFFA008);
				colors[14]=Color(0xffFFA008);
				
				});
                          value.add(_controller.text);
                          _controller.clear();
                          setResult(operation, value);
                        }
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        text[i],
                        style: TextStyle(
                          fontSize: 39,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: colors[i],
                          borderRadius: BorderRadius.circular(95)),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
