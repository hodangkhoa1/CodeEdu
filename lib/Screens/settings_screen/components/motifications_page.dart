import 'package:code_edu/Screens/settings_screen/components/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({ 
    Key key
  }) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
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
          "Notifications",
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
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "GENERAL",
              style: TextStyle(
                fontSize: 20
              ),
            ),
            Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            SizedBox(width: 30),
            SwitchListTile(
              title: Row(
                children: [
                  IconWidget(
                    icon: FontAwesomeIcons.userCircle,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 15),
                  Text(
                    "Profile Updates",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                ],
              ),
              value: true,
              onChanged: (value) {
                setState(() {
                  
                });
              }
            )
          ],
        ),
      ),
    );
  }
}

// class NotificationsPage extends StatelessWidget {
//   static const keyProfileUpdates = 'key-profile-updates';
//   static const keyLessons = 'key-lessons';
//   static const keyPostComments = 'key-post-comments';

//   const NotificationsPage({
//     Key key
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SimpleSettingsTile(
//       title: "Notifications",
//       subtitle: "Profile Updates, Lessons",
//       leading: IconWidget(
//         icon: Icons.notifications,
//         color: Colors.redAccent
//       ),
//       child: SettingsScreen(
//         title: "Notifications",
//         children: [
//           SwitchSettingsTile(
//             title: "Profile Updates",
//             settingKey: keyProfileUpdates,
//             leading: IconWidget(
//               icon: FontAwesomeIcons.userCircle,
//               color: Colors.blue
//             ),
//           ),
//           SwitchSettingsTile(
//             title: "Lessons",
//             settingKey: keyLessons,
//             leading: IconWidget(
//               icon: FontAwesomeIcons.book,
//               color: Colors.orangeAccent
//             ),
//           ),
//           SwitchSettingsTile(
//             title: "Post Comments",
//             settingKey: keyPostComments,
//             leading: IconWidget(
//               icon: FontAwesomeIcons.comments,
//               color: Colors.redAccent
//             ),
//           ),
//         ]
//       ),
//     );
//   }
// }