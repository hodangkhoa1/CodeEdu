import 'package:code_edu/Screens/score_screen/score_screen.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class QuestionController extends GetxController with SingleGetTickerProviderMixin{
  AnimationController _animationController;
  Animation _animation;
  Animation get animation => this._animation;
  // List<Question> _questions = question_data.map(
  //   (question) => Question(
  //     id: question['id'],
  //     question: question['question'],
  //     code: question['code'],
  //     options: question['options'],
  //     answer: question['answer_index'],
  //   )).toList();
  // List<Question> get questions => this._questions;

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  int _correctAnswered;
  int get correctAnswered => this._correctAnswered;

  int _selectedAnswered;
  int get selectedAnswered => this._selectedAnswered;

  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => this._numOfCorrectAns;

  PageController _pageController;
  PageController get pageController => this._pageController;

  @override
  void onInit() {
    _animationController = AnimationController(
      duration: Duration(
        seconds: 60,
      ),
      vsync: this
    );
    _animation = Tween<double>(
      begin: 1,
      end: 0
    ).animate(_animationController..addListener(() {
      update();
    }));
    _animationController.forward();
    _animationController.forward().whenComplete(nextPage);
    _pageController = PageController();
    super.onInit();
  }

  //Called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void checkAns(int question, int selectedString) {
    _isAnswered = true;
    _correctAnswered = question;
    _selectedAnswered = selectedString;

    if(_correctAnswered == _selectedAnswered) {
      _numOfCorrectAns++;
    }

    // _animationController.stop();
    // update();

    //Khi người dùng chọn đáp án thì sau 3s nó sẽ chuyển qua câu tiếp theo
    // Future.delayed(Duration(seconds: 3), (){
    //  nextQuestion();
    // });
  }

  void nextPage() {
    Get.to(ScoreScreen());
  }

  // void nextQuestion() {
  //   if(_questionNumber.value != _questions.length) {
  //      _isAnswered = false;
  //     _pageController.nextPage(
  //       duration: Duration(milliseconds: 250),
  //       curve: Curves.ease
  //     );
  //     //Reset lại thời gian
  //     // _animationController.reset();
  //     //Dùng để bắt đầu lại thời gian đếm
  //     //Khi thời gian kết thúc thì tự động qua câu hỏi mới
  //     // _animationController.forward().whenComplete(nextQuestion);
  //   } else {
  //     //Get package provide us simple way to navigate another page
  //     Get.to(ScoreScreen());
  //   }
  // }

  // void updateTheQuestionsNumber(int index) {
  //   _questionNumber.value = index + 1;
  // }
}