/// Imagery for the demos, all of it stored in this repository.
///
/// It did not start out that way. Every path here was a URL into the original
/// author's Firebase Storage bucket, which Google withdrew from its no-cost
/// plan; those now return HTTP 402. Pointing them at a placeholder service
/// instead only moved the problem, and a handful of the remaining third-party
/// URLs scattered through the demos had already gone the same way — two
/// pixabay images returning 403, one host no longer resolving at all.
///
/// So the images live in assets/images/ and are declared in pubspec.yaml. The
/// app now renders identically with no network at all, and nothing outside
/// this repository can break it again.
///
/// The original artwork was themed — Nepali landmarks, specific dishes, cut-out
/// product shots for the grocery app — and was lost with the bucket. These are
/// stand-in photographs, sized to roughly how each one is used.
library;

const String appLogo = 'assets/icon/icon.png';
const String appFeatureImage = 'assets/icon/feature_store.jpg';

// Travel
const String fishtail = 'assets/images/fishtail.jpg';
const String mountEverest = 'assets/images/mountEverest.jpg';
const String tokyo = 'assets/images/tokyo.jpg';
const String fewalake = 'assets/images/fewalake.jpg';
const String kathmandu1 = 'assets/images/kathmandu1.jpg';
const String kathmandu2 = 'assets/images/kathmandu2.jpg';
const String pashupatinath = 'assets/images/pashupatinath.jpg';

// Food
const String avocadoF = 'assets/images/avocadoF.jpg';
const String breakfast = 'assets/images/breakfast.jpg';
const String burger = 'assets/images/burger.jpg';
const String burger1 = 'assets/images/burger1.jpg';
const String burger2 = 'assets/images/burger2.jpg';
const String cake = 'assets/images/cake.jpg';
const String cherry = 'assets/images/cherry.jpg';
const String eggs = 'assets/images/eggs.jpg';
const String foodLogo = 'assets/images/foodLogo.jpg';
const String sugar = 'assets/images/sugar.jpg';
const String vanilla = 'assets/images/vanilla.jpg';
const String map = 'assets/images/map.jpg';
const String cupcake = 'assets/images/cupcake.jpg';
const String frenchFries = 'assets/images/frenchFries.jpg';
const String fries = 'assets/images/fries.jpg';
const String meal = 'assets/images/meal.jpg';
const String pancake = 'assets/images/pancake.jpg';

const List<String> avatars = [
  'assets/images/avatars_1.jpg',
  'assets/images/avatars_2.jpg',
  'assets/images/avatars_3.jpg',
  'assets/images/avatars_4.jpg',
  'assets/images/avatars_5.jpg',
  'assets/images/avatars_6.jpg',
  'assets/images/avatars_7.jpg',
];

const List<String> images = [
  'assets/images/images_1.jpg',
  'assets/images/images_2.jpg',
  'assets/images/images_3.jpg',
  'assets/images/images_4.jpg',
  'assets/images/images_5.jpg',
  'assets/images/images_6.jpg',
  'assets/images/images_7.jpg',
];

const List<String> backgroundImages = [
  'assets/images/backgroundimages_1.jpg',
  'assets/images/backgroundimages_2.jpg',
  'assets/images/backgroundimages_3.jpg',
];

const String backdrop = 'assets/images/backdrop.jpg';

const String infoIcon = 'assets/images/infoIcon.jpg';
const String origami = 'assets/images/origami.jpg';
const String rocket = 'assets/images/rocket.jpg';
const String ledge = 'assets/images/ledge.jpg';
const String photographer = 'assets/images/photographer.jpg';

const String loginBack = 'assets/images/loginBack.jpg';

const List<String> sidVideoThumbs = [
  'assets/images/sidvideothumbs_1.jpg',
  'assets/images/sidvideothumbs_2.jpg',
  'assets/images/sidvideothumbs_3.jpg',
  'assets/images/sidvideothumbs_4.jpg',
];

const String devDamodar = 'assets/images/devDamodar.jpg';
const String devSudip = 'assets/images/devSudip.jpg';
const String devArpana = 'assets/images/devArpana.jpg';
const String devSid = 'assets/images/devSid.jpg';

// Grocery app
const String brocoli = 'assets/images/brocoli.jpg';
const String cabbage = 'assets/images/cabbage.jpg';
const String capsicum = 'assets/images/capsicum.jpg';
const String chatIcon = 'assets/images/chatIcon.jpg';
const String deliveryIcon = 'assets/images/deliveryIcon.jpg';
const String fruit = 'assets/images/fruit.jpg';
const String homeIcon = 'assets/images/homeIcon.jpg';
const String mango = 'assets/images/mango.jpg';
const String mortar = 'assets/images/mortar.jpg';
const String pineapple = 'assets/images/pineapple.jpg';
const String vegetables = 'assets/images/vegetables.jpg';

const INVITE_ILLUSTRATION = 'assets/images/inviteIllustration.jpg';

const String bike = 'assets/images/bike.jpg';

const String room4 = "assets/hotel/room4.jpg";

const List<String> introIllus = [
  'assets/images/introillus_1.jpg',
  'assets/images/introillus_2.jpg',
  'assets/images/introillus_3.jpg',
];
