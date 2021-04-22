import 'package:flutter/material.dart';
// import 'package:sky_engine/js/js.dart' as js;
import 'package:url_launcher/url_launcher.dart';
// import 'responsive_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Footer extends StatelessWidget {
  final String github = "https://github.com/sscast/onlinetranslator";

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not open $url";
    }
  }

  List<Widget> socialMediaWidgets() {
    return [
      IconButton(
        icon: FaIcon(FontAwesomeIcons.github),
        onPressed: () {
          _launchURL(github);
        },
        color: Colors.blue[100],
      ),
    ];
  }

  Widget copyRightText() => Text(
        "DA2021",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: socialMediaWidgets(),
        ),
        Container(
          child: copyRightText(),
          padding: EdgeInsets.only(right: 20),
        ),
      ],
    );
  }
}
