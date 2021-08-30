import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class AddMicDialog extends StatefulWidget {
  final Function closeOnPressed;
  final String text;
  final bool isListening;
  final Function micOnPressed;
  final Function flatButtonSearch;

  const AddMicDialog({
    Key key,
    @required this.closeOnPressed,
    @required this.text,
    @required this.isListening,
    @required this.micOnPressed,
    @required this.flatButtonSearch
  }) : super(key: key);

  @override
  _AddMicDialogState createState() => _AddMicDialogState();
}

class _AddMicDialogState extends State<AddMicDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 1,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: widget.closeOnPressed,
          icon: Icon(
            Icons.close,
            color: Colors.grey,
          ),
        ),
        actions: [
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: widget.flatButtonSearch,
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  size: 26,
                ),
                SizedBox(width: 5),
                Text(
                  "Search",
                  style: TextStyle(
                    fontSize: 18
                  ),
                )
              ],
            )
          )
        ],
      ),
      body: SingleChildScrollView(
        reverse: true,
        padding: const EdgeInsets.all(30).copyWith(bottom: 150),
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
            fontWeight: FontWeight.w400
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: AvatarGlow(
          animate: widget.isListening,
          endRadius: 75,
          glowColor: Colors.green,
          child: FloatingActionButton(
            onPressed: widget.micOnPressed,
            child: Icon(
              widget.isListening ? Icons.mic : Icons.mic_none,
              size: 36,
            ),
          ),
        ),
      ),
      
    );
  }
}