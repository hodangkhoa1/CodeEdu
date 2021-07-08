import 'package:code_edu/Screens/policy_terms_screen/policy_screen.dart';
import 'package:code_edu/Screens/profile/profile_screen.dart';
import 'package:code_edu/Screens/settings_screen/setting_screen.dart';
import 'package:code_edu/Screens/to_do_app/home_to_do_page.dart';
import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    final name = "Khoa Ho";
    final email = "hodangkhoa110701";
    final urlImage = "assets/images/avatar.png";
    return Drawer(
      child: Material(
        color: Color.fromRGBO(50, 75, 205, 1),
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
              onClicked: (){}
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  SizedBox(height: 12),
                  buildMenuItem(
                    text: "My Account",
                    icon: Icons.person_outline,
                    color: Colors.white,
                    onTap: () => selectedItem(context, 0),
                  ),
                  SizedBox(height: 16),
                  buildMenuItem(
                    text: "Favourites",
                    icon: Icons.favorite_border,
                    color: Colors.pink
                  ),
                  SizedBox(height: 16),
                  buildMenuItem(
                    text: "Todoo",
                    icon: Icons.check_circle_outline,
                    color: Colors.white,
                    onTap: () => selectedItem(context, 2),
                  ),
                  SizedBox(height: 16),
                  buildMenuItem(
                    text: "Updates",
                    icon: Icons.update,
                    color: Colors.white
                  ),
                  SizedBox(height: 24),
                  Divider(
                    color: Colors.white70,
                  ),
                  SizedBox(height: 24),
                  buildMenuItem(
                    text: "Settings",
                    icon: Icons.settings,
                    color: Colors.white,
                    onTap: () => selectedItem(context, 4),
                  ),
                  SizedBox(height: 16),
                  buildMenuItem(
                    text: "Policy and terms",
                    icon: Icons.policy,
                    color: Colors.white,
                    onTap: () => selectedItem(context, 5),
                  ),
                  SizedBox(height: 166),
                  Text(
                    "© 2020 Existing Code Edu.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    @required String urlImage,
    @required String name,
    @required String email,
    @required VoidCallback onClicked,
  }) => InkWell(
    onTap: onClicked,
    child: Container(
      padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(urlImage),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
                ),
              ),
              SizedBox(height: 4),
              Text(
                email,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white
                ),
              )
            ],
          )
        ],
      ),
    ),
  );

  Widget buildMenuItem({
    @required String text,
    @required IconData icon,
    @required Color color,
    VoidCallback onTap,
  }) {
    final colorText = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(
        icon,
        color: color,
        size: 30,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: colorText,
          fontSize: 17,
          fontWeight: FontWeight.w500
        )
      ),
      hoverColor: hoverColor,
      onTap: onTap,
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProfileScreen(),
        ));
        break;
      case 1:
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ToDoPage(),
        ));
        break;
      case 3:
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SettingScreen(),
        ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PolicyScreen(),
        ));
        break;
    }
  }
}