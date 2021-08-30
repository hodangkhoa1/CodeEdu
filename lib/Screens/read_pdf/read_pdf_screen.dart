import 'package:code_edu/Screens/read_pdf/components/body.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ReadPDFScreen extends StatefulWidget {
  final String urlPDF;

  const ReadPDFScreen({
    Key key,
    @required this.urlPDF,
  }) : super(key: key);

  @override
  _ReadPDFScreenState createState() => _ReadPDFScreenState();
}

class _ReadPDFScreenState extends State<ReadPDFScreen> {
  PdfViewerController _pdfViewerController;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "ReadPDF",
              style: TextStyle(
                fontSize: 20
              ),
            ),
            Container(
              width: 45,
              height: 45,
              child: InkWell(
                onTap: (){
                  setState(() {
                    _pdfViewerController.zoomLevel = 1.25;
                  });
                },
                child: Icon(
                  Icons.zoom_in,
                  size: 33,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
            )
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 1,
          ),
        ),
      ),
      body: Body(
        pdfViewerController: _pdfViewerController,
        urlPDF: widget.urlPDF,
      ),
    );
  }
}