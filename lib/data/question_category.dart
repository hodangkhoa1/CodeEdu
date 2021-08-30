
class QuestionCategory {
  String question;
  int answer;
  List options;

  QuestionCategory.fromMap(Map<String, dynamic> data) {
    question = data['Question'];
    options = data['Options'];
    answer = data['answer'];
  }
}

class OptionsCategory {
  final String nameOption;
  final String detailOption;
  final int optionID;

  OptionsCategory({
    this.nameOption,
    this.detailOption,
    this.optionID
  });

  factory OptionsCategory.fromJson(Map<Object, dynamic> parsedJson){
    return OptionsCategory(
        nameOption: parsedJson['nameOption'],
        detailOption: parsedJson['detailOption'],
        optionID: parsedJson['optionID'],
    );
  }
}