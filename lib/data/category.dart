class Category {
  String nameCourses;
  String images;
  double rating;
  int numCourses;
  String fullNameCourses;
  int numberVisitors;

  Category.fromMap(Map<String, dynamic> data) {
    nameCourses = data['nameCourse'];
    images = data['images'];
    rating = data['rating'];
    numCourses = data['numCourses'];
    fullNameCourses = data['fullNameCourse'];
    numberVisitors = data['NumberVisitors'];
  }
  
}