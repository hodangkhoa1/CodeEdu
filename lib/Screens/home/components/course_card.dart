// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:code_edu/notifier/category_notifier.dart';
// import 'package:flutter/material.dart';
// import 'package:code_edu/data/category.dart';
// import 'package:code_edu/Screens/detail_courses/detail_courses_screen.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';

// class CourseCard extends StatelessWidget {
//   const CourseCard({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     CategoryNotifier categoryNotifier = Provider.of<CategoryNotifier>(context);

//     return StaggeredGridView.countBuilder(
//       crossAxisCount: 2,
//       itemCount: categoryNotifier.categoryList.length,
//       crossAxisSpacing: 10,
//       mainAxisSpacing: 1,
//       itemBuilder: (context, index) {
//         return Container(
//           margin: EdgeInsets.only(bottom: 20),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: Colors.grey[200],
//           ),
//           child: Column(
//             children: [
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.pushNamed(
//                       context,
//                       DetailCoursesScreen.routeName,
//                       arguments:
//                           CourseDetailsArguments(course: courseCategory[index]),
//                     );
//                   },
//                   child: Container(
//                     margin: EdgeInsets.only(top: 0, bottom: 10),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(color: Colors.blue, width: 1),
//                       image: DecorationImage(
//                         image: NetworkImage(categoryNotifier.categoryList[index].images),
//                         fit: BoxFit.contain,
//                       ),
//                       color: Colors.white
//                     ),
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pushNamed(
//                     context,
//                     DetailCoursesScreen.routeName,
//                     arguments:
//                         CourseDetailsArguments(course: courseCategory[index]),
//                   );
//                 },
//                 child: Text(
//                   categoryNotifier.categoryList[index].nameCourses,
//                   style: TextStyle(
//                     fontSize: 18,
//                   ),
//                   maxLines: 2,
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(bottom: 8),
//                       child: Text(
//                         "${categoryNotifier.categoryList[index].numCourses} lessons",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.orange
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {},
//                       child: Container(
//                         padding: EdgeInsets.only(bottom: 7),
//                         width: 28,
//                         height: 28,
//                         child: SvgPicture.asset("assets/icons/Heart Icon_2.svg"),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         );
//       },
//       staggeredTileBuilder: (index) {
//         return new StaggeredTile.count(1, index.isEven ? 1.618 : 1.618);
//       }
//     );
//   }
// }

// // StaggeredGridView.countBuilder(
// //         crossAxisCount: 2,
// //         itemCount: courseCategory.length,
// //         crossAxisSpacing: 10,
// //         mainAxisSpacing: 1,
// //         itemBuilder: (context, index) {
// //           return Container(
// //             margin: EdgeInsets.only(bottom: 20),
// //             decoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(20),
// //               color: Colors.grey[200],
// //             ),
// //             child: Column(
// //               children: [
// //                 Expanded(
// //                   child: GestureDetector(
// //                     onTap: () {
// //                       Navigator.pushNamed(
// //                         context,
// //                         DetailCoursesScreen.routeName,
// //                         arguments:
// //                             CourseDetailsArguments(course: courseCategory[index]),
// //                       );
// //                     },
// //                     child: Container(
// //                       margin: EdgeInsets.only(top: 0, bottom: 10),
// //                       decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.circular(20),
// //                         border: Border.all(color: Colors.blue, width: 1),
// //                         image: DecorationImage(
// //                           image: NetworkImage(courseCategory[index].images[0]),
// //                           fit: BoxFit.contain,
// //                         ),
// //                         color: Colors.white
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 GestureDetector(
// //                   onTap: () {
// //                     Navigator.pushNamed(
// //                       context,
// //                       DetailCoursesScreen.routeName,
// //                       arguments:
// //                           CourseDetailsArguments(course: courseCategory[index]),
// //                     );
// //                   },
// //                   child: Text(
// //                     courseCategory[index].nameCourses,
// //                     style: TextStyle(
// //                       fontSize: 18,
// //                     ),
// //                     maxLines: 2,
// //                     textAlign: TextAlign.center,
// //                   ),
// //                 ),
// //                 SizedBox(height: 8),
// //                 Padding(
// //                   padding: EdgeInsets.symmetric(horizontal: 16),
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Padding(
// //                         padding: EdgeInsets.only(bottom: 8),
// //                         child: Text(
// //                           "${courseCategory[index].numCourses} lessons",
// //                           style: TextStyle(
// //                             fontSize: 16,
// //                             fontWeight: FontWeight.w600,
// //                             color: Colors.orange
// //                           ),
// //                         ),
// //                       ),
// //                       InkWell(
// //                         onTap: () {},
// //                         child: Container(
// //                           padding: EdgeInsets.only(bottom: 7),
// //                           width: 28,
// //                           height: 28,
// //                           child: SvgPicture.asset("assets/icons/Heart Icon_2.svg"),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 )
// //               ],
// //             ),
// //           );
// //         },
// //         staggeredTileBuilder: (index) {
// //           return new StaggeredTile.count(1, index.isEven ? 1.618 : 1.618);
// //         }
// //       ),



// // Expanded(
// //       child: StreamBuilder(
// //         stream: Firestore.instance.collection('Courses').snapshots(),
// //         builder: (context, snapshot) {
// //           if(!snapshot.hasData) return const Text("Loading...");
// //           return StaggeredGridView.countBuilder(
// //             crossAxisCount: 2,
// //             itemCount: snapshot.data.documents.length,
// //             crossAxisSpacing: 10,
// //             mainAxisSpacing: 1,
// //             itemBuilder: (context, index) {
// //               return Container(
// //                 margin: EdgeInsets.only(bottom: 20),
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(20),
// //                   color: Colors.grey[200],
// //                 ),
// //                 child: Column(
// //                   children: [
// //                     Expanded(
// //                       child: GestureDetector(
// //                         onTap: () {
// //                           Navigator.pushNamed(
// //                             context,
// //                             DetailCoursesScreen.routeName,
// //                             arguments:
// //                                 CourseDetailsArguments(course: snapshot.data.documents[index]),
// //                           );
// //                         },
// //                         child: Container(
// //                           margin: EdgeInsets.only(top: 0, bottom: 10),
// //                           decoration: BoxDecoration(
// //                             borderRadius: BorderRadius.circular(20),
// //                             border: Border.all(color: Colors.blue, width: 1),
// //                             image: DecorationImage(
// //                               image: NetworkImage(snapshot.data.documents[index]['images']),
// //                               fit: BoxFit.contain,
// //                             ),
// //                             color: Colors.white
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                     GestureDetector(
// //                       onTap: () {
// //                         Navigator.pushNamed(
// //                           context,
// //                           DetailCoursesScreen.routeName,
// //                           arguments:
// //                               CourseDetailsArguments(course: snapshot.data.documents[index]),
// //                         );
// //                       },
// //                       child: Text(
// //                         snapshot.data.documents[index]['nameCourse'],
// //                         style: TextStyle(
// //                           fontSize: 18,
// //                         ),
// //                         maxLines: 2,
// //                         textAlign: TextAlign.center,
// //                       ),
// //                     ),
// //                     SizedBox(height: 8),
// //                     Padding(
// //                       padding: EdgeInsets.symmetric(horizontal: 16),
// //                       child: Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: [
// //                           Padding(
// //                             padding: EdgeInsets.only(bottom: 8),
// //                             child: Text(
// //                               snapshot.data.documents[index]['numCourse'].toString(),
// //                               //snapshot.data.documents[index]['numCourse'] != null ? "${snapshot.data.documents[index]['numCourse'].toString()} lessons" : "0 lessons",
// //                               style: TextStyle(
// //                                 fontSize: 16,
// //                                 fontWeight: FontWeight.w600,
// //                                 color: Colors.orange
// //                               ),
// //                             ),
                            
// //                             // Text((() {
// //                             //     if(snapshot.data.documents[index]['numCourse'] == null){
// //                             //       return "0 lessons";
// //                             //     }
// //                             //     // ignore: dead_code
// //                             //     return "${snapshot.data.documents[index]['numCourse']} lessons";
// //                             //   })(),
// //                             //   style: TextStyle(
// //                             //     fontSize: 16,
// //                             //     fontWeight: FontWeight.w600,
// //                             //     color: Colors.orange
// //                             //   ),
// //                             // ),
// //                           ),
// //                           InkWell(
// //                             onTap: () {},
// //                             child: Container(
// //                               padding: EdgeInsets.only(bottom: 7),
// //                               width: 28,
// //                               height: 28,
// //                               child: SvgPicture.asset("assets/icons/Heart Icon_2.svg"),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     )
// //                   ],
// //                 ),
// //               );
// //             },
// //             staggeredTileBuilder: (index) {
// //               return new StaggeredTile.count(1, index.isEven ? 1.618 : 1.618);
// //             }
// //           );
// //         },
// //       )
// //     );