import 'package:code_edu/data/university.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    Key key
  }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  List<University> _university = University.getUniversity();
  List<DropdownMenuItem<University>> _dropdownMenuItem;
  University _selectUniversity;

  @override
  void initState() {
    _dropdownMenuItem = buildDropdownMenuItems(_university);
    _selectUniversity = _dropdownMenuItem[0].value;
    super.initState();
  }

  List<DropdownMenuItem<University>> buildDropdownMenuItems(List universities) {
    // ignore: deprecated_member_use
    List<DropdownMenuItem<University>> items = List();
    for(University university in universities) {
      items.add(
        DropdownMenuItem(
          value: university,
          child: Text(university.name),
        )
      );
    }
    return items;
  }

  onChangeDropdownItem(University selectedUniversity) {
    setState(() {
      _selectUniversity = selectedUniversity;
    });
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
          "Edit Profile",
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
            TextField(
              decoration: InputDecoration(
                hintText: "Enter your name",
                icon: Icon(
                  Icons.person,
                  size: 30,
                )
              ),
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter your email",
                icon: Icon(
                  Icons.email,
                  size: 30,
                )
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter your phone number",
                icon: Icon(
                  Icons.phone,
                  size: 30,
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter your address",
                icon: Icon(
                  FontAwesomeIcons.mapMarkerAlt,
                  size: 30,
                ),
              ),
              keyboardType: TextInputType.streetAddress,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.university,
                  size: 30,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        isExpanded: true,
                        value: _selectUniversity,
                        items: _dropdownMenuItem,
                        onChanged: onChangeDropdownItem,
                      )
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              // ignore: deprecated_member_use
              child: FlatButton(
                color: Color(0xFF313131),
                onPressed: (){},
                child: Text(
                  "SAVE"
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}