import 'package:code_edu/components/button_Custom.dart';
import 'package:code_edu/components/form_error.dart';
import 'package:code_edu/components/input_field.dart';
import 'package:code_edu/controllers/task_controller.dart';
import 'package:code_edu/model/task.dart';
import 'package:code_edu/model/theme.dart';
import 'package:code_edu/validators/reg_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Body extends StatefulWidget {
  final bool isDarkMode;

  const Body({
    Key key,
    @required this.isDarkMode,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  //final TaskController _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = "9:30 PM";
  int _selectedRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];
  String _selectedRepeat = "None";
  List<String> repeatList = [
    "None",
    "Daily",
    "Weekly",
    "Monthly"
  ];
  int _selectedColor = 0;
  String titleText;
  String noteText;
  TextEditingController titleTextEditingController;
  TextEditingController noteEditingController;
  TextEditingController dateEditingController;
  TextEditingController startDateEditingController;
  TextEditingController endDateEditingController;
  TextEditingController remindEditingController;
  TextEditingController repeatEditingController;
  final List<String> titleTextErrors = [];
  final List<String> noteTextErrors = [];
  final List<String> dateTextErrors = [];
  final List<String> startDateTextErrors = [];
  final List<String> endDateTextErrors = [];
  final List<String> remindTextErrors = [];
  final List<String> repeatTextErrors = [];

  @override
  void initState() {
    titleTextEditingController = TextEditingController();
    noteEditingController = TextEditingController();
    dateEditingController = TextEditingController();
    startDateEditingController = TextEditingController();
    endDateEditingController = TextEditingController();
    remindEditingController = TextEditingController();
    repeatEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleTextEditingController.dispose();
    noteEditingController.dispose();
    dateEditingController.dispose();
    startDateEditingController.dispose();
    endDateEditingController.dispose();
    remindEditingController.dispose();
    repeatEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: headingStyle,
              ),
              InputField(
                title: "Title",
                hint: "Enter your title",
                isDarkMode: widget.isDarkMode,
                obscureText: false,
                textEditingController: titleTextEditingController,
                keyboardType: TextInputType.name,
                onSaved: (newValue) => titleText = newValue,
                onChanged: (value) {
                  if(value.isNotEmpty && (AppLocalizations.of(context).language == "English" ? titleTextErrors.contains(titleTaskNullError) : titleTextErrors.contains(AppLocalizations.of(context).titleTaskNullError))) {
                    setState(() {
                      AppLocalizations.of(context).language == "English" ? titleTextErrors.remove(titleTaskNullError) : titleTextErrors.remove(AppLocalizations.of(context).titleTaskNullError);
                    });
                  }
                  titleText = value;
                  return null;
                },
                validator: (value) {
                  if(value.isEmpty && !(AppLocalizations.of(context).language == "English" ? titleTextErrors.contains(titleTaskNullError) : titleTextErrors.contains(AppLocalizations.of(context).titleTaskNullError))) {
                    setState(() {
                      AppLocalizations.of(context).language == "English" ? titleTextErrors.add(titleTaskNullError) : titleTextErrors.add(AppLocalizations.of(context).titleTaskNullError);
                    });
                  }
                  return null;
                },
                errors: titleTextErrors,
                color: (AppLocalizations.of(context).language == "English" ? titleTextErrors.contains(titleTaskNullError) : titleTextErrors.contains(AppLocalizations.of(context).titleTaskNullError)) ? Colors.red : Colors.green,
              ),
              titleTextErrors.isNotEmpty ? Padding(
                padding: const EdgeInsets.only(top: 15),
                child: FormError(errors: titleTextErrors),
              ) : Container(),
              InputField(
                title: "Note",
                hint: "Enter note here",
                isDarkMode: widget.isDarkMode,
                obscureText: false,
                textEditingController: noteEditingController,
                keyboardType: TextInputType.text,
                onSaved: (newValue) => noteText = newValue,
                onChanged: (value) {
                  if (value.isNotEmpty && (AppLocalizations.of(context).language == "English" ? noteTextErrors.contains(noteTaskNullError) : noteTextErrors.contains(AppLocalizations.of(context).noteTaskNullError))) {
                    setState(() {
                      AppLocalizations.of(context).language == "English" ? noteTextErrors.remove(noteTaskNullError) : noteTextErrors.remove(AppLocalizations.of(context).noteTaskNullError);
                    });
                  }
                  noteText = value;
                  return null;
                },
                validator: (value) {
                  if(value.isEmpty && !(AppLocalizations.of(context).language == "English" ? noteTextErrors.contains(noteTaskNullError) : noteTextErrors.contains(AppLocalizations.of(context).noteTaskNullError))) {
                    setState(() {
                      AppLocalizations.of(context).language == "English" ? noteTextErrors.add(noteTaskNullError) : noteTextErrors.add(AppLocalizations.of(context).noteTaskNullError);
                    });
                  }
                },
                errors: noteTextErrors,
                color: (AppLocalizations.of(context).language == "English" ? noteTextErrors.contains(noteTaskNullError) : noteTextErrors.contains(AppLocalizations.of(context).noteTaskNullError)) ? Colors.red : Colors.green,
              ),
              noteTextErrors.isNotEmpty ? Padding(
                padding: const EdgeInsets.only(top: 15),
                child: FormError(errors: noteTextErrors),
              ) : Container(),
              InputField(
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                isDarkMode: widget.isDarkMode,
                textEditingController: dateEditingController,
                errors: dateTextErrors,
                obscureText: false,
                widget: IconButton(
                  onPressed: () {
                    _getDateFromUser();
                  },
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  )
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: "Start Date",
                      hint: _startTime,
                      isDarkMode: isDarkMode,
                      errors: startDateTextErrors,
                      textEditingController: startDateEditingController,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        )
                      ),
                    )
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: InputField(
                      title: "End Date",
                      hint: _endTime,
                      isDarkMode: isDarkMode,
                      errors: endDateTextErrors,
                      textEditingController: endDateEditingController,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        )
                      ),
                    )
                  )
                ],
              ),
              InputField(
                title: "Remind",
                hint: "$_selectedRemind minutes early",
                isDarkMode: isDarkMode,
                errors: remindTextErrors,
                obscureText: false,
                textEditingController: remindEditingController,
                widget: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: DropdownButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    style: subTitleStyle,
                    underline: Container(height: 0),
                    onChanged: (String newValue) {
                      setState(() {
                        _selectedRemind = int.parse(newValue);
                      });
                    },
                    items: remindList.map<DropdownMenuItem<String>>((int value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(value.toString())
                      );
                    }).toList(),
                  ),
                ),
              ),
              InputField(
                title: "Repeat",
                hint: "$_selectedRepeat",
                isDarkMode: isDarkMode,
                obscureText: false,
                errors: repeatTextErrors,
                textEditingController: repeatEditingController,
                widget: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: DropdownButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    style: subTitleStyle,
                    underline: Container(height: 0),
                    onChanged: (String newValue) {
                      setState(() {
                        _selectedRepeat = newValue;
                      });
                    },
                    items: repeatList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Colors.grey
                          ),
                        )
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPallete(),
                  ButtonCustom(
                    label: "Create Task",
                    onTap: () {
                      setState(() {
                        if(_formKey.currentState.validate()) {
                          if(titleTextErrors.isEmpty && noteTextErrors.isEmpty && dateTextErrors.isEmpty && startDateTextErrors.isEmpty && endDateTextErrors.isEmpty
                              && remindTextErrors.isEmpty && repeatTextErrors.isEmpty) {
                            //_addTaskToDb();
                            Get.back();
                          } else {
                            Get.snackbar(
                              "Required",
                              "All fields are required !",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.black,
                              colorText: Color(0xFFFF4667),
                              icon: Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.red,
                              ),
                            );
                          }
                        }
                      });
                    }
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // _addTaskToDb() async {
  //   await _taskController.addTask(
  //     task: Task(
  //       title: titleTextEditingController.text,
  //       note: noteEditingController.text,
  //       isCompleted: 0,
  //       date: DateFormat.yMd().format(_selectedDate),
  //       startTime: _startTime,
  //       endTime: _endTime,
  //       color: _selectedColor,
  //       remind: _selectedRemind,
  //       repeat: _selectedRepeat
  //     )
  //   );
  // }

  _colorPallete() {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Color",
            style: titleStyle,
          ),
          SizedBox(height: 8),
          Wrap(
            children: List<Widget>.generate(
              3,
              (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: index == 0 ? Color(0xFF4e5ae8) : index == 1 ? Color(0xFFFF4667) : Color(0xFFFFB746),
                      child: _selectedColor == index ? Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 16,
                      ) : null,
                    ),
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }

  _getDateFromUser() async {
    DateTime _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2121)
    );

    if(_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      _selectedDate = DateTime.now();
    }
  }

  _getTimeFromUser({@required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime == null ? (isStartTime == true ? DateFormat("hh:mm a").format(DateTime.now()).toString() : _endTime) : pickedTime.format(context);

    if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if(isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0])
      )
    );
  }
}