import 'package:code_edu/components/build_form_field_custom.dart';
import 'package:code_edu/components/form_error.dart';
import 'package:code_edu/validators/reg_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  TextEditingController urlImageQuizEditingController;
  TextEditingController titleQuizTextEditingController;
  TextEditingController descriptionQuizTextEditingController;
  TextEditingController numberQuestionTextEditingController;
  String urlImageQuiz;
  String titleQuizText;
  String descriptionQuizText;
  String numberQuestionText;
  final List<String> urlImageQuizErrors = [];
  final List<String> titleQuizErrors = [];
  final List<String> descriptionQuizErrors = [];
  final List<String> numberQuestionErrors = [];
  FocusNode _urlImageFocus;
  FocusNode _nameTitleFocus;
  FocusNode _descriptionQuizFocus;
  FocusNode _numberQuestionFocus;
  int currentStep = 0;
  bool isCompleted = false;
  AnimationController _notFoundUrlController;

  @override
  void initState() {
    urlImageQuizEditingController = TextEditingController();
    titleQuizTextEditingController = TextEditingController();
    descriptionQuizTextEditingController = TextEditingController();
    numberQuestionTextEditingController = TextEditingController();
    _urlImageFocus = FocusNode();
    _urlImageFocus.addListener(() {
      if (!_urlImageFocus.hasFocus) {
        if (urlImageQuizEditingController.text.trim().isEmpty && !(AppLocalizations.of(context).language == "English" ? urlImageQuizErrors.contains(urlImageQuizNullError) : urlImageQuizErrors.contains(AppLocalizations.of(context).urlImageQuizNullError)) && !(AppLocalizations.of(context).language == "English" ? urlImageQuizErrors.contains(invalidUrlError) : urlImageQuizErrors.contains(AppLocalizations.of(context).invalidUrlError))) {
          setState(() {
            AppLocalizations.of(context).language == "English" ? urlImageQuizErrors.add(urlImageQuizNullError) : urlImageQuizErrors.add(AppLocalizations.of(context).urlImageQuizNullError);
          });
        } else if(!urlValidatorRegExp.hasMatch(urlImageQuizEditingController.text.trim()) && !(AppLocalizations.of(context).language == "English" ? urlImageQuizErrors.contains(invalidUrlError) : urlImageQuizErrors.contains(AppLocalizations.of(context).invalidUrlError)) && !(AppLocalizations.of(context).language == "English" ? urlImageQuizErrors.contains(urlImageQuizNullError) : urlImageQuizErrors.contains(AppLocalizations.of(context).urlImageQuizNullError))) {
          setState(() {
            AppLocalizations.of(context).language == "English" ? urlImageQuizErrors.add(invalidUrlError) : urlImageQuizErrors.add(AppLocalizations.of(context).invalidUrlError);
          });
        }
      }
    });
    _nameTitleFocus = FocusNode();
    _nameTitleFocus.addListener(() {
      if (!_nameTitleFocus.hasFocus) {
        if (titleQuizTextEditingController.text.trim().isEmpty && !(AppLocalizations.of(context).language == "English" ? titleQuizErrors.contains(titleQuizNullError) : titleQuizErrors.contains(AppLocalizations.of(context).titleNullError))) {
          setState(() {
            AppLocalizations.of(context).language == "English" ? titleQuizErrors.add(titleQuizNullError) : titleQuizErrors.add(AppLocalizations.of(context).titleNullError);
          });
        }
      }
    });
    _descriptionQuizFocus = FocusNode();
    _descriptionQuizFocus.addListener(() {
      if (!_descriptionQuizFocus.hasFocus) {
        if (descriptionQuizTextEditingController.text.trim().isEmpty && !(AppLocalizations.of(context).language == "English" ? descriptionQuizErrors.contains(descriptionQuizNullError) : descriptionQuizErrors.contains(AppLocalizations.of(context).descriptionQuizNullError))) {
          setState(() {
            AppLocalizations.of(context).language == "English" ? descriptionQuizErrors.add(descriptionQuizNullError) : descriptionQuizErrors.add(AppLocalizations.of(context).descriptionQuizNullError);
          });
        }
      }
    });
    _numberQuestionFocus = FocusNode();
    _numberQuestionFocus.addListener(() {
      if (numberQuestionTextEditingController.text.trim().isEmpty && !(AppLocalizations.of(context).language == "English" ? numberQuestionErrors.contains(numberQuestionNullError) : numberQuestionErrors.contains(AppLocalizations.of(context).numberQuestionNullError))) {
        setState(() {
          AppLocalizations.of(context).language == "English" ? numberQuestionErrors.add(numberQuestionNullError) : numberQuestionErrors.add(AppLocalizations.of(context).numberQuestionNullError);
        });
      }
    });
    _notFoundUrlController = AnimationController(
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    urlImageQuizEditingController.dispose();
    titleQuizTextEditingController.dispose();
    descriptionQuizTextEditingController.dispose();
    numberQuestionTextEditingController.dispose();
    _urlImageFocus.addListener(() {
      super.dispose();
    });
    _nameTitleFocus.addListener(() {
      super.dispose();
    });
    _descriptionQuizFocus.addListener(() {
      super.dispose();
    });
    _numberQuestionFocus.addListener(() {
      super.dispose();
    });
    _notFoundUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 210,
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Color(0xFF202020),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border: Border.all(color: Colors.grey, width: 0.5),
                    image: DecorationImage(
                      image: urlImageQuizEditingController.text.trim().isNotEmpty
                      ? NetworkImage(urlImageQuizEditingController.text.trim())
                      : AssetImage("assets/images/image-not-found.png"),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(height: 620),
                  child: Stepper(
                    physics: NeverScrollableScrollPhysics(),
                    type: StepperType.horizontal,
                    steps: getSteps(),
                    currentStep: currentStep,
                    onStepContinue: () {
                      final isLastStep = currentStep == getSteps().length - 1;
                      if(isLastStep) {
                        setState(() => isCompleted = true);
                        print("Completed");
                      } else {
                        if(_formKey.currentState.validate()) {
                          if(urlImageQuizErrors.isEmpty && titleQuizErrors.isEmpty && descriptionQuizErrors.isEmpty) {
                            setState(() => currentStep += 1);
                          }
                        }
                      }
                    },
                    onStepTapped: (step) {
                      if(_formKey.currentState.validate()) {
                        if(urlImageQuizErrors.isEmpty && titleQuizErrors.isEmpty && descriptionQuizErrors.isEmpty) {
                          setState(() => currentStep = step);
                        }
                      }
                    },
                    onStepCancel: currentStep == 0 ? null : () => setState(() => currentStep -= 1),
                    controlsBuilder: (context, {onStepCancel, onStepContinue}) {
                      final isLastStep = currentStep == getSteps().length - 1;
                
                      return Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: onStepContinue,
                                  child: Text(
                                    isLastStep ? "CONFIRM" : "NEXT",
                                    style: TextStyle(
                                      fontSize: 16
                                    ),
                                  )
                                ),
                              )
                            ),
                            const SizedBox(width: 12),
                            if(currentStep != 0)
                              Expanded(
                                child: Container(
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: onStepCancel,
                                    child: Text("BACK")
                                  ),
                                )
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ),
            )
          ],
        )
      ),
    );
  }

  List<Step> getSteps() => [
    Step(
      state: currentStep > 0 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 0,
      title: Text(
        "Step 1"
      ),
      content: Column(
        children: [
          buildFormFieldCustom(
            urlImageQuizErrors,
            _urlImageFocus,
            1,
            1,
            urlImageQuizEditingController,
            BorderRadius.circular(10),
            (AppLocalizations.of(context).language == "English" ? (urlImageQuizErrors.contains(urlImageQuizNullError) || urlImageQuizErrors.contains(invalidUrlError)) : (urlImageQuizErrors.contains(AppLocalizations.of(context).urlImageQuizNullError) || urlImageQuizErrors.contains(AppLocalizations.of(context).invalidUrlError))) ? Colors.red : Colors.green,
            TextInputType.url,
            false,
            urlImageQuiz,
            (value) {
              if (value.isNotEmpty && (AppLocalizations.of(context).language == "English" ? urlImageQuizErrors.contains(urlImageQuizNullError) : urlImageQuizErrors.contains(AppLocalizations.of(context).urlImageQuizNullError)) && (AppLocalizations.of(context).language == "English" ? urlImageQuizErrors.contains(invalidUrlError) : urlImageQuizErrors.contains(AppLocalizations.of(context).invalidUrlError))) {
                setState(() {
                  AppLocalizations.of(context).language == "English" ? urlImageQuizErrors.remove(urlImageQuizNullError) : urlImageQuizErrors.remove(AppLocalizations.of(context).urlImageQuizNullError);
                });
              } else if(urlValidatorRegExp.hasMatch(value) && (AppLocalizations.of(context).language == "English" ? urlImageQuizErrors.contains(invalidUrlError) : urlImageQuizErrors.contains(AppLocalizations.of(context).invalidUrlError)) && (AppLocalizations.of(context).language == "English" ? urlImageQuizErrors.contains(urlImageQuizNullError) : urlImageQuizErrors.contains(AppLocalizations.of(context).urlImageQuizNullError))) {
                setState(() {
                  AppLocalizations.of(context).language == "English" ? urlImageQuizErrors.remove(invalidUrlError) : urlImageQuizErrors.remove(AppLocalizations.of(context).invalidUrlError);
                });
              }
              urlImageQuiz = value;
              return null;
            },
            (value) {
              if (value.isEmpty && !(AppLocalizations.of(context).language == "English" ? urlImageQuizErrors.contains(urlImageQuizNullError) : urlImageQuizErrors.contains(AppLocalizations.of(context).urlImageQuizNullError)) && !(AppLocalizations.of(context).language == "English" ? urlImageQuizErrors.contains(invalidUrlError) : urlImageQuizErrors.contains(AppLocalizations.of(context).invalidUrlError))) {
                setState(() {
                  AppLocalizations.of(context).language == "English" ? urlImageQuizErrors.add(urlImageQuizNullError) : urlImageQuizErrors.add(AppLocalizations.of(context).urlImageQuizNullError);
                });
              } else if(!urlValidatorRegExp.hasMatch(value) && !(AppLocalizations.of(context).language == "English" ? urlImageQuizErrors.contains(invalidUrlError) : urlImageQuizErrors.contains(AppLocalizations.of(context).invalidUrlError)) && !(AppLocalizations.of(context).language == "English" ? urlImageQuizErrors.contains(urlImageQuizNullError) : urlImageQuizErrors.contains(AppLocalizations.of(context).urlImageQuizNullError))) {
                setState(() {
                  AppLocalizations.of(context).language == "English" ? urlImageQuizErrors.add(invalidUrlError) : urlImageQuizErrors.add(AppLocalizations.of(context).invalidUrlError);
                });
              }
              return null;
            },
            "Quiz Image Url",
            FontAwesomeIcons.link,
            (AppLocalizations.of(context).language == "English" ? (urlImageQuizErrors.contains(urlImageQuizNullError) || urlImageQuizErrors.contains(invalidUrlError)) : (urlImageQuizErrors.contains(AppLocalizations.of(context).urlImageQuizNullError) || urlImageQuizErrors.contains(AppLocalizations.of(context).invalidUrlError))) ? Colors.red : Colors.green,
            (urlImageQuizEditingController.text.trim().isNotEmpty || urlImageQuizErrors.isNotEmpty)
              ? ((AppLocalizations.of(context).language == "English" ? (urlImageQuizErrors.contains(urlImageQuizNullError) || (urlImageQuizErrors.contains(invalidUrlError))) : (urlImageQuizErrors.contains(AppLocalizations.of(context).urlImageQuizNullError) || urlImageQuizErrors.contains(AppLocalizations.of(context).invalidUrlError)))
                ? Icon(
                    Icons.error_outline,
                    size: 30,
                    color: Colors.red,
                  )
                : Icon(
                    Icons.check,
                    size: 30,
                    color: Colors.green,
                  )
            ) : null,
          ),
          FormError(errors: urlImageQuizErrors),
          buildFormFieldCustom(
            titleQuizErrors,
            _nameTitleFocus,
            1,
            1,
            titleQuizTextEditingController,
            BorderRadius.circular(10),
            (AppLocalizations.of(context).language == "English" ? titleQuizErrors.contains(titleQuizNullError) : titleQuizErrors.contains(AppLocalizations.of(context).titleNullError)) ? Colors.red : Colors.green,
            TextInputType.text,
            false,
            titleQuizText,
            (value) {
              if (value.isNotEmpty && (AppLocalizations.of(context).language == "English" ? titleQuizErrors.contains(titleQuizNullError) : titleQuizErrors.contains(AppLocalizations.of(context).titleNullError))) {
                setState(() {
                  AppLocalizations.of(context).language == "English" ? titleQuizErrors.remove(titleQuizNullError) : titleQuizErrors.remove(AppLocalizations.of(context).titleNullError);
                });
              }
              titleQuizText = value;
              return null;
            },
            (value) {
              if (value.isEmpty && !(AppLocalizations.of(context).language == "English" ? titleQuizErrors.contains(titleQuizNullError) : titleQuizErrors.contains(AppLocalizations.of(context).titleNullError))) {
                setState(() {
                  AppLocalizations.of(context).language == "English" ? titleQuizErrors.add(titleQuizNullError) : titleQuizErrors.add(AppLocalizations.of(context).titleNullError);
                });
              }
              return null;
            },
            "Quiz Title",
            Icons.title,
            (AppLocalizations.of(context).language == "English" ? titleQuizErrors.contains(titleQuizNullError) : titleQuizErrors.contains(AppLocalizations.of(context).titleNullError)) ? Colors.red : Colors.green,
            ((titleQuizTextEditingController.text.trim().isNotEmpty || titleQuizErrors.isNotEmpty))
              ? ((AppLocalizations.of(context).language == "English" ? titleQuizErrors.contains(titleQuizNullError) : titleQuizErrors.contains(AppLocalizations.of(context).titleNullError))
              ? Icon(
                  Icons.error_outline,
                  size: 30,
                  color: Colors.red,
                )
              : Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.green,
                )
            ) : null,
          ),
          FormError(errors: titleQuizErrors),
          buildFormFieldCustom(
            descriptionQuizErrors,
            _descriptionQuizFocus,
            1,
            5,
            descriptionQuizTextEditingController,
            BorderRadius.circular(10),
            (AppLocalizations.of(context).language == "English" ? descriptionQuizErrors.contains(descriptionQuizNullError) : descriptionQuizErrors.contains(AppLocalizations.of(context).descriptionQuizNullError)) ? Colors.red : Colors.green,
            TextInputType.multiline,
            false,
            descriptionQuizText,
            (value) {
              if (value.isNotEmpty && (AppLocalizations.of(context).language == "English" ? descriptionQuizErrors.contains(descriptionQuizNullError) : descriptionQuizErrors.contains(AppLocalizations.of(context).descriptionQuizNullError))) {
                setState(() {
                  AppLocalizations.of(context).language == "English" ? descriptionQuizErrors.remove(descriptionQuizNullError) : descriptionQuizErrors.remove(AppLocalizations.of(context).descriptionQuizNullError);
                });
              }
              descriptionQuizText = value;
              return null;
            },
            (value) {
              if (value.isEmpty && !(AppLocalizations.of(context).language == "English" ? descriptionQuizErrors.contains(descriptionQuizNullError) : descriptionQuizErrors.contains(AppLocalizations.of(context).descriptionQuizNullError))) {
                setState(() {
                  AppLocalizations.of(context).language == "English" ? descriptionQuizErrors.add(descriptionQuizNullError) : descriptionQuizErrors.add(AppLocalizations.of(context).descriptionQuizNullError);
                });
              }
              return null;
            },
            "Quiz Description",
            Icons.description,
            (AppLocalizations.of(context).language == "English" ? descriptionQuizErrors.contains(descriptionQuizNullError) : descriptionQuizErrors.contains(AppLocalizations.of(context).descriptionQuizNullError)) ? Colors.red : Colors.green,
            ((descriptionQuizTextEditingController.text.trim().isNotEmpty || descriptionQuizErrors.isNotEmpty))
              ? ((AppLocalizations.of(context).language == "English" ? descriptionQuizErrors.contains(descriptionQuizNullError) : descriptionQuizErrors.contains(AppLocalizations.of(context).descriptionQuizNullError))
                ? Icon(
                    Icons.error_outline,
                    size: 30,
                    color: Colors.red,
                  )
                : Icon(
                    Icons.check,
                    size: 30,
                    color: Colors.green,
                  )
            ) : null,
          ),
          FormError(errors: descriptionQuizErrors),
          buildFormFieldCustom(
            numberQuestionErrors,
            _numberQuestionFocus,
            1,
            1,
            numberQuestionTextEditingController,
            BorderRadius.circular(10),
            (AppLocalizations.of(context).language == "English" ? numberQuestionErrors.contains(numberQuestionNullError) : numberQuestionErrors.contains(AppLocalizations.of(context).numberQuestionNullError)) ? Colors.red : Colors.green,
            TextInputType.number,
            false,
            numberQuestionText,
            (value) {
              if (value.isNotEmpty && (AppLocalizations.of(context).language == "English" ? numberQuestionErrors.contains(numberQuestionNullError) : numberQuestionErrors.contains(AppLocalizations.of(context).numberQuestionNullError))) {
                setState(() {
                  AppLocalizations.of(context).language == "English" ? numberQuestionErrors.remove(numberQuestionNullError) : numberQuestionErrors.remove(AppLocalizations.of(context).numberQuestionNullError);
                });
              }
              numberQuestionText = value;
              return null;
            },
            (value) {
              if (value.isEmpty && !(AppLocalizations.of(context).language == "English" ? numberQuestionErrors.contains(numberQuestionNullError) : numberQuestionErrors.contains(AppLocalizations.of(context).numberQuestionNullError))) {
                setState(() {
                  AppLocalizations.of(context).language == "English" ? numberQuestionErrors.add(numberQuestionNullError) : numberQuestionErrors.add(AppLocalizations.of(context).numberQuestionNullError);
                });
              }
              return null;
            },
            "Quiz Description",
            FontAwesomeIcons.listOl,
            (AppLocalizations.of(context).language == "English" ? numberQuestionErrors.contains(numberQuestionNullError) : numberQuestionErrors.contains(AppLocalizations.of(context).numberQuestionNullError)) ? Colors.red : Colors.green,
            ((numberQuestionTextEditingController.text.trim().isNotEmpty || numberQuestionErrors.isNotEmpty))
              ? ((AppLocalizations.of(context).language == "English" ? numberQuestionErrors.contains(numberQuestionNullError) : numberQuestionErrors.contains(AppLocalizations.of(context).numberQuestionNullError))
                ? Icon(
                    Icons.error_outline,
                    size: 30,
                    color: Colors.red,
                  )
                : Icon(
                    Icons.check,
                    size: 30,
                    color: Colors.green,
                  )
            ) : null,
          ),
          FormError(errors: numberQuestionErrors),
        ],
      )
    ),
    Step(
      state: currentStep > 1 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 1,
      title: Text(
        "Step 2"
      ),
      content: Column(
        children: [
          SizedBox(
            height: 400,
            child: ListView.builder(
              itemCount: numberQuestionTextEditingController.text.trim().isNotEmpty ? int.parse(numberQuestionTextEditingController.text) : 0,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(
                    top: 10,
                    bottom: 10
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1
                    )
                  ),
                  child: Column(
                    children: [
                      Text("Hello")
                    ],
                  ),
                );
              },
            ),
          )
        ],
      )
    ),
    Step(
      isActive: currentStep >= 2,
      title: Text(
        "Complete"
      ),
      content: Container()
    )
  ];
}
