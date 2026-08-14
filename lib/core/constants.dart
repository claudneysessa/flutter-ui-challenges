import 'package:flutter_ui_challenges/core/presentation/res/assets.dart';

import 'data/models/developer.dart';

/// This fork. The in-app "view source" links resolve against it, so it has to
/// be the repository the running code actually came from.
const String githubRepo =
    "https://github.com/claudneysessa/flutter-ui-challenges";

/// Where the project came from. Archived by its author in 2024, which is why
/// this fork exists.
const String upstreamRepo =
    "https://github.com/lohanidamodar/flutter_ui_challenges";

const String youtubeChannel = "https://youtube.com/c/reactbits";

/// Whoever is keeping this fork alive.
const Developer MAINTAINER = Developer(
  name: "Claudney Sarti Sessa",
  profession: "Senior Developer — 2026 revival",
  address: "Brazil",
  github: "https://github.com/claudneysessa",
  imageUrl: devClaudney,
);

const String maintainerLinkedIn =
    "https://www.linkedin.com/in/claudneysessa";
const String maintainerEmail = "claudneysartisessa@gmail.com";

const List<Developer> DEVELOPERS = [
  Developer(
    name: "Damodar Lohani",
    profession: "Full Stack Developer",
    address: "Kathmandu, Nepal",
    github: "https://github.com/lohanidamodar",
    imageUrl: devDamodar,
  ),
  Developer(
    name: "Sudip Thapa",
    profession: "Flutter & React Developer",
    address: "Kathmandu, Nepal",
    github: "https://github.com/sudeepthapa",
    imageUrl: devSudip,
  ),
  Developer(
    name: "Arpana Dulal",
    profession: "Flutter Developer",
    address: "Kathmandu, Nepal",
    github: "https://github.com/ambikadulal",
    imageUrl: devArpana,
  ),
];

const String privacyUrl = "https://popupbits.com/contact/flutter-ui-challenges-privacy-policy/";