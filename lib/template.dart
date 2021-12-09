import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:share_plus/share_plus.dart';

import 'responsive_widget.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class Template extends ConsumerWidget {
  final Widget child;
  final String title;

  Template({
    Key? key,
    required this.child,
    required this.title,
  }) : super(key: key);
  final String github = "https://github.com/sscast/onlinetranslator";

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not open $url";
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveWidget(
      largeScreen: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              snap: false,
              floating: false,
              title: Text(title),
              elevation: 1.0,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    alignment: Alignment.topCenter,
                    // width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height * 0.5,
                    // padding: EdgeInsets.all(10),
                    child: child,
                  ),
                ],
              ),
            ),
          ],
        ),
        persistentFooterButtons: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.github),
            onPressed: () {
              _launchURL(github);
            },
            color: Colors.blue[100],
          ),
          Text(
            "DA2021",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
            ),
          )
        ],
      ),
      mediumScreen: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              snap: false,
              floating: false,
              title: Text(title),
              elevation: 1.0,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  alignment: Alignment.topCenter,
                  // width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height * 0.5,
                  // padding: EdgeInsets.all(10),
                  child: child,
                ),
              ]),
            ),
          ],
        ),
        persistentFooterButtons: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.github),
            onPressed: () {
              _launchURL(github);
            },
            color: Colors.blue[100],
          ),
          Text(
            "DA2021",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
            ),
          )
        ],
      ),
      smallScreen: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              snap: false,
              floating: false,
              title: Text(title),
              elevation: 1.0,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  alignment: Alignment.topCenter,
                  // width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height * 0.5,
                  // padding: EdgeInsets.all(10),
                  child: child,
                ),
              ]),
            ),
          ],
        ),
        persistentFooterButtons: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.github),
            onPressed: () {
              _launchURL(github);
            },
            color: Colors.blue[100],
          ),
          Text(
            "DA2021",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
