import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Body extends StatefulWidget {
  final PdfViewerController pdfViewerController;
  final String urlPDF;

  const Body({
    Key key,
    @required this.pdfViewerController,
    @required this.urlPDF,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SfPdfViewer.network(
        widget.urlPDF,
        controller: widget.pdfViewerController,
      ),
    );
  }
}