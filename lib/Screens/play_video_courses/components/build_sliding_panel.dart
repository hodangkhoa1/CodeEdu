import 'package:code_edu/Screens/settings_screen/components/header_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class BuildSlidingPanel extends StatefulWidget {
  final Function onTap;

  const BuildSlidingPanel({
    Key key,
    @required this.onTap,
  }) : super(key: key);

  @override
  _BuildSlidingPanelState createState() => _BuildSlidingPanelState();
}

class _BuildSlidingPanelState extends State<BuildSlidingPanel> {
  final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Icon(
          Icons.drag_handle,
          color: Colors.grey,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(12),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 16,
              left: 15,
              right: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Description content",
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black54,
                    fontSize: 15
                  ),
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Icon(
                    Icons.close,
                    color: isDarkMode ? Colors.white : Colors.black54,
                  ),
                )
              ],
            ),
          )
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 10,
            bottom: 15
          ),
          child: Column(
            children: [
              Text(
                "Chào dân chuyên ngữ đến với workshop OOP Java\n\nVideo này nằm trong chuỗi bài giúp bạn từ Zero to Pro trong tiến trình chinh phục kiến thức Lập trình Hướng đối tượng sử dụng ngôn ngữ Java\n\nBạn sẽ được chỉ dẫn theo kiểu step by step, vừa thông lí thuyết vừa thạo thực hành, lập trình vui như showbiz...\n\n"
                + "▶ Nội dung video:\n* Gà gáy báo thức\n* Định hướng học hành: suy nghĩ đúngg, làm điều đúng, tránh xa xàm xí \n* Các đồ chơi công cụ cần thiết để bắt đầu làm việc với Java\n* App Java đầu tay\n* Code, code và code...\n\n▶ Cơm thêm - tài nguyên để dành: https://github.com/doit-now/java-oop-...\n\n▶ Lời cảm ơn:"
                + "Cảm ơn các thế hệ sinh viên đã nhiệt tình, kiên nhẫn & chịu đựng khi tham gia bài giảng. Các bạn mãi là niềm cảm hứng bất tận cho ngọn lửa nhiệt huyết trong giáo.làng luôn luôn bùng cháy!\nWelcome mọi feedback!\n\nHAPPY CODE - HAPPY MONEY",
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  height: 1.4
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "© Copyright by giáo.làng",
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black54
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}