/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
  */

import 'package:flutter/material.dart';
import 'package:flutter_ui_challenges/core/data/models/developer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.deepOrange),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('About Flutter UI Challenges'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(color: Colors.grey.shade200),
                  child: Text(
                      "Flutter UI Challenges is an effort to replicate various UIs in flutter and share it with you for free."),
                ),
                const SizedBox(height: 20.0),
                MaterialButton(
                  color: Colors.grey.shade200,
                  padding: const EdgeInsets.all(16.0),
                  onPressed: () async {
                    await _open(githubRepo);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          FaIcon(FontAwesomeIcons.github,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            "Github",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                          "Find the code for every UI in this fork's repository."),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                MaterialButton(
                  color: Colors.grey.shade200,
                  padding: const EdgeInsets.all(16.0),
                  onPressed: () async {
                    await _open(youtubeChannel);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          FaIcon(FontAwesomeIcons.youtube,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            "Youtube",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                          "Subscribe our youtube channel to see us build some of these UIs as well as other flutter tutorials and resources."),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  "Maintainer",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.0),
                Text(
                  "This fork brings the project from Flutter 2.5 up to current Flutter. The app and its UIs are the original authors' work.",
                  style: TextStyle(color: Colors.black54),
                ),
                SizedBox(height: 10.0),
                _buildHeader(MAINTAINER),
                Wrap(
                  spacing: 8.0,
                  children: <Widget>[
                    OutlinedButton.icon(
                      onPressed: () => _open(maintainerLinkedIn),
                      icon: FaIcon(FontAwesomeIcons.linkedin, size: 16.0),
                      label: Text("LinkedIn"),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _open("mailto:$maintainerEmail"),
                      icon: FaIcon(FontAwesomeIcons.envelope, size: 16.0),
                      label: Text("Email"),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _open(upstreamRepo),
                      icon: FaIcon(FontAwesomeIcons.codeBranch, size: 16.0),
                      label: Text("Original project"),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  "Original authors",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                ...DEVELOPERS.map((dev) => _buildHeader(dev)).toList(),
                const SizedBox(height: 10.0),
                MaterialButton(
                  color: Colors.grey.shade200,
                  onPressed: () async {
                    await _open(privacyUrl);
                  },
                  child: Text("Privacy Policy"),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildHeader(Developer developer) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: MaterialButton(
        padding: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: Colors.grey.shade200,
        onPressed: () => _open(developer.github!),
        child: Row(
          children: <Widget>[
            Container(
                width: 80.0,
                height: 80.0,
                child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(
                        radius: 35.0,
                        backgroundImage: AssetImage(developer.imageUrl!)))),
            SizedBox(width: 20.0),
            // Expanded so a long name or job title wraps instead of running off
            // the side of the card.
            Expanded(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  developer.name!,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Text(developer.profession!),
                SizedBox(height: 5.0),
                Row(
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.map,
                      size: 12.0,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        developer.address!,
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
