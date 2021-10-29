import 'dart:async';
import 'dart:io';

import 'package:code_edu/Screens/settings_screen/components/header_page.dart';
import 'package:code_edu/Screens/settings_screen/components/profile_pic.dart';
import 'package:code_edu/Screens/settings_screen/function/get_value_database.dart';
import 'package:code_edu/components/display_toast_message.dart';
import 'package:code_edu/components/form_error.dart';
import 'package:code_edu/components/input_field.dart';
import 'package:code_edu/components/show_dialog_error.dart';
import 'package:code_edu/model/theme.dart';
import 'package:code_edu/requestAPI/upload_images.dart';
import 'package:code_edu/validators/reg_validator.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class EditProfile extends StatefulWidget {
  final String urlImage;
  final String uid;

  const EditProfile({
    Key key,
    @required this.urlImage,
    @required this.uid,
  }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  String nameUser;
  String email;
  String phoneNumber;
  TextEditingController nameUserTextEditingController;
  TextEditingController emailTextEditingController;
  TextEditingController phoneNumberTextEditingController;
  TextEditingController dateEditingController;
  TextEditingController addressTextEditingController;
  TextEditingController universityTextEditingController;
  TextEditingController sexTextEditingController;
  final List<String> nameUserErrors = [];
  final List<String> emailErrors = [];
  final List<String> phoneNumberErrors = [];
  final List<String> dateTextErrors = [];
  final List<String> addressTextErrors = [];
  final List<String> universityTextErrors = [];
  final List<String> sexTextErrors = [];
  bool isoffline = false;
  StreamSubscription internetconnection;
  final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);
  File _pickedImage;
  UploadTask task;
  String _urlDownload;
  DateTime _selectedDate;
  String _dateFormate = "MM/DD/YYYY";
  String _selectedUniversity = "Select University";
  String _selectedAddress = "Select Address";
  String _selectedSex = "Select Sex";
  List<String> university = [
    "Select University",
    "Bách khoa",
    "Sư phạm kỹ thuật",
    "Công nghệ thông tin",
    "FPT",
    "Khoa học Tự nhiên",
    "Công nghệ Sài Gòn",
    "Công Gia Định",
    "Hoa Sen",
    "Other"
  ];
  List<String> address = [
    "Select Address",
    "TP HCM",
    "TP Hà Nội"
  ];
  List<String> sex = [
    "Select Sex",
    "Nam",
    "Nữ"
  ];

  Future takePhoto(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker.pickImage(
        source: source
      );

      if(pickedImage == null) return;

      final imageTemporary = File(pickedImage.path);
      setState(() => this._pickedImage = imageTemporary);
      uploadFile(_pickedImage, 'Avatar', '${widget.uid}', task);
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Future uploadFile(File file, String folderName, String imageID, UploadTask task) async {
    if(file == null) return;

    final fileName = basename(file.path);
    final destination = '$folderName/$imageID/$fileName';
    UploadImages.uploadFile(destination, file);
    task = UploadImages.uploadFile(destination, file);
    setState(() {});

    if(task == null) return;

    final snapshot = await task.whenComplete(() {});
    _urlDownload = await snapshot.ref.getDownloadURL().toString();
  }

  @override
  void initState() {
    nameUserTextEditingController = TextEditingController();
    emailTextEditingController = TextEditingController();
    phoneNumberTextEditingController = TextEditingController();
    dateEditingController = TextEditingController();
    addressTextEditingController = TextEditingController();
    universityTextEditingController = TextEditingController();
    sexTextEditingController = TextEditingController();
    internetconnection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(result == ConnectivityResult.none){
        setState(() {
          isoffline = true;
        });
      }else if(result == ConnectivityResult.mobile){
        setState(() {
          isoffline = false;
        });
      }else if(result == ConnectivityResult.wifi){
        setState(() {
          isoffline = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    internetconnection.cancel();
    nameUserTextEditingController.dispose();
    emailTextEditingController.dispose();
    phoneNumberTextEditingController.dispose();
    dateEditingController.dispose();
    addressTextEditingController.dispose();
    sexTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: (){
            setState(() {
              Navigator.pop(context);
            });
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.blue,
          ),
        ),
        title: Text(
          AppLocalizations.of(context).editProfile,
          style: TextStyle(
            fontSize: 20
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Align(
                    alignment: Alignment.center,
                    child: ProfilePic(
                      avatarImage: widget.urlImage,
                      fileImage: _pickedImage,
                      onPressedCamera: () {
                        setState(() {
                          Navigator.of(context).pop();
                          takePhoto(ImageSource.camera);
                        });
                      },
                      onPressedGallery: (){
                        setState(() {
                          Navigator.of(context).pop();
                          takePhoto(ImageSource.gallery);
                        });
                      },
                    ),
                  ),
                ),
                InputField(
                  title: "Username",
                  hint: AppLocalizations.of(context).yourUserName,
                  isDarkMode: isDarkMode,
                  keyboardType: TextInputType.name,
                  textEditingController: nameUserTextEditingController,
                  onSaved: (newValue) => nameUser = newValue,
                  onChanged: (value) {
                    if(value.isNotEmpty && (AppLocalizations.of(context).language == "English" ? nameUserErrors.contains(nameUserNullError) : nameUserErrors.contains(AppLocalizations.of(context).pleaseEnterYourUsername)) && !(AppLocalizations.of(context).language == "English" ? nameUserErrors.contains(shortUserNameError) : nameUserErrors.contains(AppLocalizations.of(context).shortUsername))){
                      setState(() {
                        AppLocalizations.of(context).language == "English" ? nameUserErrors.remove(nameUserNullError) : nameUserErrors.remove(AppLocalizations.of(context).pleaseEnterYourUsername);
                      });
                    } else if(value.length.toInt() >= 5 && (AppLocalizations.of(context).language == "English" ? nameUserErrors.contains(shortUserNameError) : nameUserErrors.contains(AppLocalizations.of(context).shortUsername)) && !(AppLocalizations.of(context).language == "English" ? nameUserErrors.contains(nameUserNullError) : nameUserErrors.contains(AppLocalizations.of(context).pleaseEnterYourUsername))) {
                      setState(() {
                        AppLocalizations.of(context).language == "English" ? nameUserErrors.remove(shortUserNameError) : nameUserErrors.remove(AppLocalizations.of(context).shortUsername);
                      });
                    }
                    nameUser = value;
                    return null;
                  },
                  validator: (value) {
                    if(value.isEmpty && !(AppLocalizations.of(context).language == "English" ? nameUserErrors.contains(nameUserNullError) : nameUserErrors.contains(AppLocalizations.of(context).pleaseEnterYourUsername)) && !(AppLocalizations.of(context).language == "English" ? nameUserErrors.contains(shortUserNameError) : nameUserErrors.contains(AppLocalizations.of(context).shortUsername))){
                      setState(() {
                        AppLocalizations.of(context).language == "English" ? nameUserErrors.add(nameUserNullError) : nameUserErrors.add(AppLocalizations.of(context).pleaseEnterYourUsername);
                      });
                    } else if(value.length.toInt() < 5 && !(AppLocalizations.of(context).language == "English" ? nameUserErrors.contains(shortUserNameError) : nameUserErrors.contains(AppLocalizations.of(context).shortUsername)) && !(AppLocalizations.of(context).language == "English" ? nameUserErrors.contains(nameUserNullError) : nameUserErrors.contains(AppLocalizations.of(context).pleaseEnterYourUsername))) {
                      setState(() {
                        AppLocalizations.of(context).language == "English" ? nameUserErrors.add(shortUserNameError) : nameUserErrors.add(AppLocalizations.of(context).shortUsername);
                      });
                    }
                    return null;
                  },
                  errors: nameUserErrors,
                  obscureText: false,
                  color: (AppLocalizations.of(context).language == "English" ? (nameUserErrors.contains(nameUserNullError) || nameUserErrors.contains(shortUserNameError)) : (nameUserErrors.contains(AppLocalizations.of(context).pleaseEnterYourUsername) || nameUserErrors.contains(AppLocalizations.of(context).shortUsername))) ? Colors.red : Colors.green,
                ),
                nameUserErrors.isNotEmpty ? Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: FormError(errors: nameUserErrors),
                ) : Container(),
                InputField(
                  title: "Sex",
                  hint: "$_selectedSex",
                  isDarkMode: isDarkMode,
                  errors: sexTextErrors,
                  textEditingController: sexTextEditingController,
                  obscureText: false,
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
                          _selectedSex = newValue;
                        });
                      },
                      items: sex.map<DropdownMenuItem<String>>((String value) {
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
                InputField(
                  title: "Email",
                  hint: AppLocalizations.of(context).yourEmail,
                  isDarkMode: isDarkMode,
                  keyboardType: TextInputType.emailAddress,
                  textEditingController: emailTextEditingController,
                  onSaved: (newValue) => email = newValue,
                  onChanged: (value) {
                    if(value.isNotEmpty && (AppLocalizations.of(context).language == "English" ? emailErrors.contains(emailNullError) : emailErrors.contains(AppLocalizations.of(context).pleaseEnterYourEmail)) && !(AppLocalizations.of(context).language == "English" ? emailErrors.contains(invalidEmailError) : emailErrors.contains(AppLocalizations.of(context).pleaseEnterValidEmail))) {
                      setState(() {
                        AppLocalizations.of(context).language == "English" ? emailErrors.remove(emailNullError) : emailErrors.remove(AppLocalizations.of(context).pleaseEnterYourEmail);
                      });
                    } else if(emailValidatorRegExp.hasMatch(value) && (AppLocalizations.of(context).language == "English" ? emailErrors.contains(invalidEmailError) : emailErrors.contains(AppLocalizations.of(context).pleaseEnterValidEmail)) && !(AppLocalizations.of(context).language == "English" ? emailErrors.contains(emailNullError) : emailErrors.contains(AppLocalizations.of(context).pleaseEnterYourEmail))){
                      setState(() {
                        AppLocalizations.of(context).language == "English" ? emailErrors.remove(invalidEmailError) : emailErrors.remove(AppLocalizations.of(context).pleaseEnterValidEmail);
                      });
                    }
                    email = value;
                    return null;
                  },
                  validator: (value) {
                    if(value.isEmpty && !(AppLocalizations.of(context).language == "English" ? emailErrors.contains(emailNullError) : emailErrors.contains(AppLocalizations.of(context).pleaseEnterYourEmail)) && !(AppLocalizations.of(context).language == "English" ? emailErrors.contains(invalidEmailError) : emailErrors.contains(AppLocalizations.of(context).pleaseEnterValidEmail))) {
                      setState(() {
                        AppLocalizations.of(context).language == "English" ? emailErrors.add(emailNullError) : emailErrors.add(AppLocalizations.of(context).pleaseEnterYourEmail);
                      });
                    } else if(!emailValidatorRegExp.hasMatch(value) && !(AppLocalizations.of(context).language == "English" ? emailErrors.contains(invalidEmailError) : emailErrors.contains(AppLocalizations.of(context).pleaseEnterValidEmail)) && !(AppLocalizations.of(context).language == "English" ? emailErrors.contains(emailNullError) : emailErrors.contains(AppLocalizations.of(context).pleaseEnterYourEmail))){
                      setState(() {
                        AppLocalizations.of(context).language == "English" ? emailErrors.add(invalidEmailError) : emailErrors.add(AppLocalizations.of(context).pleaseEnterValidEmail);
                      });
                    }
                    return null;
                  },
                  errors: emailErrors,
                  obscureText: false,
                  color: (AppLocalizations.of(context).language == "English" ? (emailErrors.contains(invalidEmailError) || emailErrors.contains(emailNullError)) : (emailErrors.contains(AppLocalizations.of(context).pleaseEnterValidEmail) || emailErrors.contains(AppLocalizations.of(context).pleaseEnterYourEmail))) ? Colors.red : Colors.green,
                ),
                emailErrors.isNotEmpty ? Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: FormError(errors: emailErrors),
                ) : Container(),
                InputField(
                  title: "Phone Number",
                  hint: AppLocalizations.of(context).yourPhoneNumber,
                  isDarkMode: isDarkMode,
                  keyboardType: TextInputType.phone,
                  textEditingController: phoneNumberTextEditingController,
                  onSaved: (newValue) => phoneNumber = newValue,
                  onChanged: (value) {
                    if(value.isNotEmpty && (AppLocalizations.of(context).language == "English" ? phoneNumberErrors.contains(phoneNumberNullError) : phoneNumberErrors.contains(AppLocalizations.of(context).pleaseEnterYourPhoneNumber)) && !(AppLocalizations.of(context).language == "English" ? phoneNumberErrors.contains(shortPhoneNumberError) : phoneNumberErrors.contains(AppLocalizations.of(context).shortPhoneNumber))){
                      setState(() {
                        AppLocalizations.of(context).language == "English" ? phoneNumberErrors.remove(phoneNumberNullError) : phoneNumberErrors.remove(AppLocalizations.of(context).pleaseEnterYourPhoneNumber);
                      });
                    } else if(value.length.toInt() == 10 && (AppLocalizations.of(context).language == "English" ? phoneNumberErrors.contains(shortPhoneNumberError) : phoneNumberErrors.contains(AppLocalizations.of(context).shortPhoneNumber)) && !(AppLocalizations.of(context).language == "English" ? phoneNumberErrors.contains(phoneNumberNullError) : phoneNumberErrors.contains(AppLocalizations.of(context).pleaseEnterYourPhoneNumber))) {
                      setState(() {
                        AppLocalizations.of(context).language == "English" ? phoneNumberErrors.remove(shortPhoneNumberError) : phoneNumberErrors.remove(AppLocalizations.of(context).shortPhoneNumber);
                      });
                    }
                    phoneNumber = value;
                    return null;
                  },
                  validator: (value) {
                    if(value.isEmpty && !(AppLocalizations.of(context).language == "English" ? phoneNumberErrors.contains(phoneNumberNullError) : phoneNumberErrors.contains(AppLocalizations.of(context).pleaseEnterYourPhoneNumber)) && !(AppLocalizations.of(context).language == "English" ? phoneNumberErrors.contains(shortPhoneNumberError) : phoneNumberErrors.contains(AppLocalizations.of(context).shortPhoneNumber))){
                      setState(() {
                        AppLocalizations.of(context).language == "English" ? phoneNumberErrors.add(phoneNumberNullError) : phoneNumberErrors.add(AppLocalizations.of(context).pleaseEnterYourPhoneNumber);
                      });
                    } else if(value.length.toInt() != 10 && !(AppLocalizations.of(context).language == "English" ? phoneNumberErrors.contains(shortPhoneNumberError) : phoneNumberErrors.contains(AppLocalizations.of(context).shortPhoneNumber)) && !(AppLocalizations.of(context).language == "English" ? phoneNumberErrors.contains(phoneNumberNullError) : phoneNumberErrors.contains(AppLocalizations.of(context).pleaseEnterYourPhoneNumber))) {
                      setState(() {
                        AppLocalizations.of(context).language == "English" ? phoneNumberErrors.add(shortPhoneNumberError) : phoneNumberErrors.add(AppLocalizations.of(context).shortPhoneNumber);
                      });
                    }
                    return null;
                  },
                  errors: phoneNumberErrors,
                  obscureText: false,
                  color: (AppLocalizations.of(context).language == "English" ? (phoneNumberErrors.contains(phoneNumberNullError) || phoneNumberErrors.contains(shortPhoneNumberError)) : (phoneNumberErrors.contains(AppLocalizations.of(context).pleaseEnterYourPhoneNumber)) || phoneNumberErrors.contains(AppLocalizations.of(context).shortPhoneNumber)) ? Colors.red : Colors.green,
                ),
                phoneNumberErrors.isNotEmpty ? Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: FormError(errors: phoneNumberErrors),
                ) : Container(),
                InputField(
                  title: "Birthday",
                  hint: _selectedDate == null ? _dateFormate : DateFormat.yMd().format(_selectedDate),
                  isDarkMode: isDarkMode,
                  textEditingController: dateEditingController,
                  errors: dateTextErrors,
                  obscureText: false,
                  widget: IconButton(
                    onPressed: () {
                      _getDateFromUser(context);
                    },
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    )
                  ),
                ),
                InputField(
                  title: "University",
                  hint: "$_selectedUniversity",
                  isDarkMode: isDarkMode,
                  errors: universityTextErrors,
                  obscureText: false,
                  textEditingController: universityTextEditingController,
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
                          _selectedUniversity = newValue;
                        });
                      },
                      items: university.map<DropdownMenuItem<String>>((String value) {
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
                InputField(
                  title: "Address",
                  hint: "$_selectedAddress",
                  isDarkMode: isDarkMode,
                  errors: addressTextErrors,
                  obscureText: false,
                  textEditingController: addressTextEditingController,
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
                          _selectedAddress = newValue;
                        });
                      },
                      items: address.map<DropdownMenuItem<String>>((String value) {
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
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    color: isDarkMode ? Color(0xFF313131) : Colors.grey[200],
                    onPressed: (){
                      if(isoffline == false) {
                        setState(() {
                          if(_formKey.currentState.validate()){
                            if(emailErrors.isEmpty && nameUserErrors.isEmpty && phoneNumberErrors.isEmpty){
                              if (!_selectedSex.contains("Select Sex")) {
                                if(_selectedDate != null) {
                                  if(!_selectedUniversity.contains("Select University")) {
                                    if(!_selectedAddress.contains("Select Address")) {
                                      // GetValueDatabase(
                                      //   context,
                                      //   widget.uid,
                                      //   isDarkMode,
                                      //   isoffline,
                                      //   "Thành công",
                                      //   "Bạn cập nhật thông tin của bạn thành công. Vui lòng khởi động lại để có được thông tin mới nhất",
                                      //   emailTextEditingController.text.trim(),
                                      //   nameUserTextEditingController.text.trim(),
                                      //   _selectedUniversity,
                                      //   phoneNumberTextEditingController.text.trim(),
                                      //   _urlDownload,
                                      //   _selectedDate,
                                      //   "Lỗi",
                                      //   "Không thể cập nhật thông tin của bạn."
                                      // );
                                    } else {
                                      Get.snackbar(
                                        "Required",
                                        AppLocalizations.of(context).addressNullError,
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.black,
                                        colorText: Color(0xFFFF4667),
                                        icon: Icon(
                                          Icons.warning_amber_rounded,
                                          color: Colors.red,
                                        ),
                                      );
                                    }
                                  } else {
                                    Get.snackbar(
                                      "Required",
                                      AppLocalizations.of(context).universityNullError,
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.black,
                                      colorText: Color(0xFFFF4667),
                                      icon: Icon(
                                        Icons.warning_amber_rounded,
                                        color: Colors.red,
                                      ),
                                    );
                                  }
                                } else {
                                  Get.snackbar(
                                    "Required",
                                    AppLocalizations.of(context).birthdayNullError,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.black,
                                    colorText: Color(0xFFFF4667),
                                    icon: Icon(
                                      Icons.warning_amber_rounded,
                                      color: Colors.red,
                                    ),
                                  );
                                }
                              } else {
                                Get.snackbar(
                                  "Required",
                                  "Vui lòng chọn giới tính.",
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
                          }
                        });
                      } else {
                        displayToastMessage(context, AppLocalizations.of(context).pleaseConnectToTheInternet);
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context).save
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getDateFromUser(BuildContext context) async {
    DateTime _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 100)
    );

    if(_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      _selectedDate = DateTime.now();
    }
  }
}