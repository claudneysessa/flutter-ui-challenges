/// Remote imagery for the demos.
///
/// Every URL here used to point at the original author's Firebase Storage
/// bucket. Google withdrew Cloud Storage from the no-cost Spark plan, so that
/// bucket now answers every request with HTTP 402 and the artwork is gone. The
/// demos are drawn almost entirely out of these images, so most of the app
/// rendered as blank rectangles.
///
/// They are replaced with two services that need no account and no key:
///
/// * https://picsum.photos — seeded, so a given seed always returns the same
///   photo and the demos stay visually stable between runs.
/// * https://i.pravatar.cc — portrait avatars, which is what the profile and
///   chat screens expect in those slots.
///
/// Sizes match roughly how each image is used, so the device is not asked to
/// decode a 4K photo for a 40px avatar. Everything remote lives in this file,
/// so pointing the app at a bucket of your own is a single-file change.
///
/// Note that the original set was themed — Nepali landmarks, specific dishes,
/// cut-out product shots for the grocery app. That artwork was lost with the
/// bucket and cannot be reproduced; these are photographs in its place.
library;

const String appLogo = 'assets/icon/icon.png';
const String appFeatureImage = 'assets/icon/feature_store.jpg';

const String _photo = 'https://picsum.photos/seed';

// Travel
const String fishtail = '$_photo/fishtail/800/1200';
const String mountEverest = '$_photo/everest/800/1200';
const String tokyo = '$_photo/tokyo/800/1200';
const String fewalake = '$_photo/fewalake/800/1200';
const String kathmandu1 = '$_photo/kathmandu1/800/1200';
const String kathmandu2 = '$_photo/kathmandu2/800/1200';
const String pashupatinath = '$_photo/pashupatinath/800/1200';

// Food
const String avocadoF = '$_photo/avocado/800/800';
const String breakfast = '$_photo/breakfast/800/800';
const String burger = '$_photo/burger/800/800';
const String burger1 = '$_photo/burger1/800/800';
const String burger2 = '$_photo/burger2/800/800';
const String cake = '$_photo/cake/800/800';
const String cherry = '$_photo/cherry/800/800';
const String eggs = '$_photo/eggs/600/600';
const String foodLogo = '$_photo/foodlogo/300/300';
const String sugar = '$_photo/sugar/600/600';
const String vanilla = '$_photo/vanilla/600/600';
const String map = '$_photo/map/800/800';
const String cupcake = '$_photo/cupcake/800/800';
const String frenchFries = '$_photo/frenchfries/800/800';
const String fries = '$_photo/fries/800/800';
const String meal = '$_photo/meal/800/800';
const String pancake = '$_photo/pancake/800/800';

const String _avatar = 'https://i.pravatar.cc/300?img=';

const List<String> avatars = [
  '${_avatar}12',
  '${_avatar}32',
  '${_avatar}47',
  '${_avatar}68',
  '${_avatar}11',
  '${_avatar}52',
  '${_avatar}15',
];

const List<String> images = [
  '$_photo/gallery1/1000/1000',
  '$_photo/gallery2/1000/1000',
  '$_photo/gallery3/1000/1000',
  '$_photo/gallery4/1000/1000',
  '$_photo/gallery5/1000/1000',
  '$_photo/gallery6/1000/1000',
  '$_photo/gallery7/1000/1000',
];

const List<String> backgroundImages = [
  '$_photo/background1/1000/1600',
  '$_photo/background2/1000/1600',
  '$_photo/background3/1000/1600',
];

const String backdrop = '$_photo/backdrop/1000/1600';

const String infoIcon = '$_photo/infoicon/200/200';
const String origami = '$_photo/origami/600/600';
const String rocket = '$_photo/rocket/600/600';
const String ledge = '$_photo/ledge/1000/1400';
const String photographer = '$_photo/photographer/1000/1400';

const String loginBack = '$_photo/loginback/1000/1600';

const List<String> sidVideoThumbs = [
  '$_photo/video1/640/360',
  '$_photo/video2/640/360',
  '$_photo/video3/640/360',
  '$_photo/video4/640/360',
];

const String devDamodar = '${_avatar}13';
const String devSudip = '${_avatar}53';
const String devArpana =
    'https://avatars.githubusercontent.com/u/55906788?s=400&u=755774d7c380cd7bbaf7e158bef74fc275853f17&v=4';
const String devSid = '${_avatar}60';

// Grocery app
const String brocoli = '$_photo/brocoli/600/600';
const String cabbage = '$_photo/cabbage/600/600';
const String capsicum = '$_photo/capsicum/600/600';
const String chatIcon = '$_photo/chaticon/200/200';
const String deliveryIcon = '$_photo/deliveryicon/200/200';
const String fruit = '$_photo/fruit/600/600';
const String homeIcon = '$_photo/homeicon/200/200';
const String mango = '$_photo/mango/600/600';
const String mortar = '$_photo/mortar/600/600';
const String pineapple = '$_photo/pineapple/600/600';
const String vegetables = '$_photo/vegetables/600/600';

const INVITE_ILLUSTRATION = '$_photo/invite/800/800';

const String bike = '$_photo/bike/1000/700';

const String room4 = "assets/hotel/room4.jpg";

const List<String> introIllus = [
  '$_photo/intro1/800/800',
  '$_photo/intro2/800/800',
  '$_photo/intro3/800/800',
];
