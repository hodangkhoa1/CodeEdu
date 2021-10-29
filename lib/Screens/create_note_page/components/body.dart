import 'package:code_edu/components/app_bar_note_button.dart';
import 'package:code_edu/components/display_toast_message.dart';
import 'package:code_edu/validators/reg_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FontStyle _textStyle;
  TextDecoration _textDecoration;
  FontWeight _fontWeight;
  Color textColor = Colors.black;
  String formattedDate = DateFormat('MMM d').format(DateTime.now());
  final _formKey = GlobalKey<FormState>();
  final List<String> titleErrors = [];
  String title;
  TextEditingController titleTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          leadingWidth: 74,
          leading: Row(
            children: [
              SizedBox(width: 10),
              AppBarNoteButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          actions: [
            AppBarNoteButton(
              onPressed: (){
                setState(() {
                  if(_formKey.currentState.validate()) {
                    if(titleErrors.isEmpty) {
                      
                    } else {
                      displayToastMessage(context, AppLocalizations.of(context).titleNoteNullError);
                    }
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Save",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              )
            ),
            SizedBox(width: 10)
          ],
        ),
        Expanded(
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: TextFormField(
                    controller: titleTextEditingController,
                    style: Theme.of(context).textTheme.headline3.copyWith(
                      color: Colors.white
                    ),
                    maxLines: null,
                    maxLength: 36,
                    // ignore: deprecated_member_use
                    maxLengthEnforced: true,
                    onSaved: (newValue) => title = newValue,
                    onChanged: (value) {
                      if(value.isNotEmpty && (AppLocalizations.of(context).language == "English" ? titleErrors.contains(titleNoteNullError) : titleErrors.contains(AppLocalizations.of(context).titleNoteNullError))) {
                        setState(() {
                          AppLocalizations.of(context).language == "English" ? titleErrors.remove(titleNoteNullError) : titleErrors.remove(AppLocalizations.of(context).titleNoteNullError);
                        });
                      }
                      title = value;
                      return null;
                    },
                    validator: (value) {
                      if(value.isEmpty && !(AppLocalizations.of(context).language == "English" ? titleErrors.contains(titleNoteNullError) : titleErrors.contains(AppLocalizations.of(context).titleNoteNullError))) {
                        setState(() {
                          AppLocalizations.of(context).language == "English" ? titleErrors.add(titleNoteNullError) : titleErrors.add(AppLocalizations.of(context).titleNoteNullError);
                        });
                      }
                      return null;
                    },
                    buildCounter: (context, {currentLength, isFocused, maxLength}) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formattedDate,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey
                            ),
                          ),
                          isFocused ? Text(
                            "$currentLength / $maxLength",
                            style: TextStyle(
                              color: Colors.grey
                            ),
                          ) : Container()
                        ],
                      );
                    },
                    decoration: InputDecoration.collapsed(
                      hintText: "Title",
                      hintStyle: Theme.of(context).textTheme.headline3.copyWith(
                        color: Colors.white54
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 15,
                    right: 15,
                    bottom: 50
                  ),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1
                        ),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  if(_fontWeight == FontWeight.bold) {
                                    _fontWeight = FontWeight.normal;
                                  } else {
                                    _fontWeight = FontWeight.bold;
                                  }
                                });
                              },
                              child: Icon(
                                FontAwesomeIcons.bold,
                                color: _fontWeight == FontWeight.bold ? Colors.blue : Colors.grey
                              ),
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if(_textStyle == FontStyle.italic) {
                                    _textStyle = FontStyle.normal;
                                  } else {
                                    _textStyle = FontStyle.italic;
                                  }
                                });
                              },
                              child: Icon(
                                FontAwesomeIcons.italic,
                                color: _textStyle == FontStyle.italic ? Colors.blue : Colors.grey
                              ),
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if(_textDecoration == TextDecoration.underline) {
                                    _textDecoration = TextDecoration.none;
                                  } else {
                                    _textDecoration = TextDecoration.underline;
                                  }
                                });
                              },
                              child: Icon(
                                FontAwesomeIcons.underline,
                                color: _textDecoration == TextDecoration.underline ? Colors.blue : Colors.grey
                              ),
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                      "Pick Your Color"
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ColorPicker(
                                          pickerColor: textColor,
                                          enableAlpha: false,
                                          showLabel: false,
                                          onColorChanged: (color) => setState(() => this.textColor = color)
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pop(),
                                          child: Text(
                                            "SELECT",
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          )
                                        ),
                                      ],
                                    ),
                                  )
                                );
                              },
                              child: Icon(
                                FontAwesomeIcons.palette,
                                color: textColor == Colors.black ? Colors.white : textColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1
                      )
                    ),
                    child: TextFormField(
                      style: TextStyle(
                        color: textColor,
                        fontSize: 30,
                        fontStyle: _textStyle,
                        decoration: _textDecoration,
                        fontWeight: _fontWeight,
                      ),
                      minLines: 6,
                      maxLines: null,
                      // ignore: deprecated_member_use
                      maxLengthEnforced: true,
                      buildCounter: (context, {currentLength, isFocused, maxLength}) {
                        return Text(
                          "$currentLength characters",
                          style: TextStyle(
                            color: Colors.grey
                          ),
                        );
                      },
                      decoration: InputDecoration.collapsed(
                        hintText: "Type something...",
                        hintStyle: Theme.of(context).textTheme.headline6.copyWith(
                          color: Colors.white38
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}