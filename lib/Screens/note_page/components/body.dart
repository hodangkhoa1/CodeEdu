import 'package:code_edu/Screens/create_note_page/create_note_page.dart';
import 'package:code_edu/Screens/view_note_page/view_note_page.dart';
import 'package:code_edu/components/app_bar_note_button.dart';
import 'package:code_edu/components/note_tile.dart';
import 'package:code_edu/model/note_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Body extends StatefulWidget {
  final String urlImage;

  const Body({
    Key key,
    @required this.urlImage,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var notes = <NoteModel>[
    NoteModel(
      id: 1,
      title: "Note about tutorial",
      description: "adad ada a babll adad adafggh adad bbdjkadkjakjdjsdashldsjkhkjhkjhkjhfkjahkfjhsdkjh",
      createdat: DateTime.now(),
    ),
    NoteModel(
      id: 2,
      title: "Note about tutorial",
      description: "adad ada a babll adad adafggh adad",
      createdat: DateTime.now(),
    ),
    NoteModel(
      id: 3,
      title: "Note about tutorial",
      description: "adad ada a babll adad adafggh adad",
      createdat: DateTime.now(),
    ),
    NoteModel(
      id: 4,
      title: "Note about tutorial",
      description: "adad ada a babll adad adafggh adad",
      createdat: DateTime.now(),
    ),
    NoteModel(
      id: 5,
      title: "Note about tutorial",
      description: "adad ada a babll adad adafggh adad",
      createdat: DateTime.now(),
    ),
    NoteModel(
      id: 6,
      title: "Note about tutorial",
      description: "adad ada a babll adad adafggh adad",
      createdat: DateTime.now(),
    ),
    NoteModel(
      id: 7,
      title: "Note about tutorial",
      description: "adad ada a babll adad adafggh adad",
      createdat: DateTime.now(),
    ),
    NoteModel(
      id: 8,
      title: "Note about tutorial",
      description: "adad ada a babll adad adafggh adad",
      createdat: DateTime.now(),
    ),
    NoteModel(
      id: 9,
      title: "Note about tutorial",
      description: "adad ada a babll adad adafggh adad",
      createdat: DateTime.now(),
    ),
    NoteModel(
      id: 10,
      title: "Note about tutorial",
      description: "adad ada a babll adad adafggh adad",
      createdat: DateTime.now(),
    ),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 24),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1
                      )
                    )
                  ),
                  child: AppBar(
                    title: Text(
                      "Notes",
                      style: GoogleFonts.nunito(
                        fontSize: 24
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    actions: [
                      AppBarNoteButton(
                        child: Icon(
                          CupertinoIcons.search,
                          color: Colors.white,
                        ),
                        onPressed: (){}
                      )
                    ],
                    automaticallyImplyLeading: false,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                      itemCount: notes.length,
                      itemBuilder: (BuildContext context, int index) => NoteTile(
                        onTap: () {
                          setState(() {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewNotePage(
                              title: notes[1].title,
                              description: notes[1].description,
                            )));
                          });
                        },
                        noteModel: notes[index],
                      ),
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 100)
            ],
          ),
          Positioned(
            bottom: 110,
            right: 20,
            child: Container(
              width: 50,
              height: 50,
              child: FloatingActionButton(
                backgroundColor: Colors.green,
                onPressed: (){
                  setState(() {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CreateNotePage(),
                        maintainState: true
                      )
                    );
                  });
                },
                child: Icon(
                  FontAwesomeIcons.pencilAlt,
                  color: Colors.white,
                ),
                
              ),
            ),
          ),
        ],
      ),
    );
  }
}