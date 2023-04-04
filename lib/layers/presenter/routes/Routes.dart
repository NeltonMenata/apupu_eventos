// ignore_for_file: constant_identifier_names

import 'package:apupu_eventos/layers/presenter/ui/login/login_page.dart';
import 'package:apupu_eventos/layers/presenter/ui/register_in_or_out_guest/register_in_or_out_guest_page.dart';
import 'package:apupu_eventos/layers/presenter/ui/search_guest/search_guest_page.dart';
import 'package:apupu_eventos/layers/presenter/ui/splash/splash_page.dart';
import 'package:flutter/material.dart';

import '../ui/add_event/add_event_page.dart';
import '../ui/add_guest/add_guest_page.dart';
import '../ui/home/home_page.dart';
import '../ui/manager_event/manager_event_page.dart';
import '../ui/result_search_guest/result_search_guest.dart';

abstract class Routes {
  static const SPLASH = "/splash";
  static const HOME = "/home";
  static const ADD_EVENT = "/add_event";
  static const ADD_GUEST = "/add_guest";
  static const MANAGER_EVENT = "/manager_event";

  static const REGISTER_GUEST = "/register_guest";
  static const SEARCH_GUEST = "/search_guest";
  static const RESULT_SEARCH_GUEST = "/result_search_guest";
  static const LOGIN = "/login";

  // Routers for Worker

  static Map<String, Widget Function(BuildContext)> routes(
      BuildContext context) {
    return {
      SPLASH: (context) => const SplashPage(),
      HOME: (context) => const HomePage(),
      ADD_EVENT: (context) => const AddEventPage(),
      ADD_GUEST: (context) => const AddGuestPage(),
      MANAGER_EVENT: (context) => const ManagerEventPage(),
      REGISTER_GUEST: (context) => RegisterInOrOutGuestPage(),
      SEARCH_GUEST: (context) => const SearchGuestPage(),
      RESULT_SEARCH_GUEST: (context) => const ResultSearchGuestPage(),
      LOGIN: (context) => LoginPage()
    };
  }
}
