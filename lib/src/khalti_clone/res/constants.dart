/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
  */
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../model/home_menu_item.dart';
import '../model/introitem.dart';
const String logo = "assets/smwallet/logo.png";

final List<IntroItem> introItems = [
  IntroItem(image: logo,title: "Load Fund", subtitle: "Load funds in your khalti from your Bank account"),
  IntroItem(image: logo,title: "Pay on the go", subtitle: "Recharge, make gene service payment bills and much more"),
  IntroItem(image: logo,title: "Fund transfer", subtitle: "Request send money to your friends."),
];

final List<HomeMenuItem> homeMenuItems = [
  HomeMenuItem("Topup",FontAwesomeIcons.mobileAlt.data, subtitle: "CASHBACK 2%"),
  HomeMenuItem("RC Card",FontAwesomeIcons.addressCard.data, subtitle: "CASHBACK 2-3%"),
  HomeMenuItem("Landline",FontAwesomeIcons.intercom.data, subtitle: "CASHBACK 2%"),
  HomeMenuItem("Electricity",FontAwesomeIcons.idBadge.data),
  HomeMenuItem("Khanepani",FontAwesomeIcons.water.data),
  HomeMenuItem("TV",FontAwesomeIcons.tv.data, subtitle: "CASHBACK 2%"),
  HomeMenuItem("Internet",FontAwesomeIcons.globe.data, subtitle: "CASHBACK 0.5-5%"),
  HomeMenuItem("E-Learning",FontAwesomeIcons.readme.data, subtitle: "CASHBACK 2%"),
  HomeMenuItem("Antivirus",FontAwesomeIcons.shieldAlt.data, subtitle: "CASHBACK 30%"),
  HomeMenuItem("Insurance",FontAwesomeIcons.userShield.data),
  HomeMenuItem("Ride",FontAwesomeIcons.motorcycle.data, subtitle: "CASHBACK 5%"),
  HomeMenuItem("Share",FontAwesomeIcons.shareSquare.data),
  HomeMenuItem("Newspaper",FontAwesomeIcons.newspaper.data),
  HomeMenuItem("Credit Card",FontAwesomeIcons.creditCard.data),
];
final List<HomeMenuItem> homeBookingsItems = [
  HomeMenuItem("Flight",FontAwesomeIcons.plane.data),
  HomeMenuItem("Movie",FontAwesomeIcons.ticketAlt.data, subtitle: "CASHBACK 2%"),
  HomeMenuItem("Hotel",FontAwesomeIcons.hotel.data),
  HomeMenuItem("Event",FontAwesomeIcons.calendarCheck.data)
];