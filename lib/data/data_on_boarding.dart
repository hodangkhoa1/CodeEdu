class SliderModel {
  String imagePath;
  String title;
  String desc;

  SliderModel({
    this.imagePath,
    this.title,
    this.desc
  });

  void setImageAssetPath(String getImagePath){
    imagePath = getImagePath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imagePath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }
}

// ignore: missing_return
List<SliderModel> getSlides(){
  // ignore: deprecated_member_use
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  // Set ô thứ nhất
  sliderModel.setImageAssetPath("assets/images/learn-code.png");
  sliderModel.setTitle("Learn code");
  sliderModel.setDesc("Learn code anytime, anywhere.");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  // Set ô thứ hai
  sliderModel.setImageAssetPath("assets/images/code-editor.png");
  sliderModel.setTitle("Code editing");
  sliderModel.setDesc("You will experience coding after learning a certain lesson.");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  // Set ô thứ ba
  sliderModel.setImageAssetPath("assets/images/online-quiz-app.png");
  sliderModel.setTitle("Quiz code");
  sliderModel.setDesc("After each lesson, you will be given a quiz to review your knowledge.");
  slides.add(sliderModel);

  return slides;
}