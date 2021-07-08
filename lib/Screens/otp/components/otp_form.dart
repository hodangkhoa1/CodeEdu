import 'package:code_edu/Screens/sign_up_success/sign_up_success_screen.dart';
import 'package:flutter/material.dart';

class OtpForm extends StatefulWidget {
  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    super.dispose();
  }

  void nextField({String value, FocusNode focusNode}) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 60,
                child: TextFormField(
                  autofocus: true,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xFF8B8B8B))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.orange)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  onChanged: (value) {
                    nextField(value: value, focusNode: pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xFF8B8B8B))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.orange)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.orange)),
                  ),
                  onChanged: (value) {
                    nextField(value: value, focusNode: pin3FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xFF8B8B8B))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.orange)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.orange)),
                  ),
                  onChanged: (value) {
                    nextField(value: value, focusNode: pin4FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xFF8B8B8B))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.orange)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.orange)),
                  ),
                  onChanged: (value) {
                    pin4FocusNode.unfocus();
                  },
                ),
              )
            ],
          ),
          SizedBox(height: size.height * 0.15),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: size.width * 0.9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              // ignore: deprecated_member_use
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                color: Colors.blue,
                onPressed: onPressedButton,
                child: Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onPressedButton(){
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpSuccessScreen()));
    });
  }
}