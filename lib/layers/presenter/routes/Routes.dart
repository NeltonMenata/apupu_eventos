// ignore_for_file: constant_identifier_names, file_names

import 'package:apupu_eventos/layers/presenter/ui/create_product/create_product_page.dart';
import 'package:apupu_eventos/layers/presenter/ui/create_worker/create_worker_page.dart';
import 'package:apupu_eventos/layers/presenter/ui/credit_and_sale_worker/credit_and_sale_worker_page.dart';
import 'package:apupu_eventos/layers/presenter/ui/login/login_page.dart';
import 'package:apupu_eventos/layers/presenter/ui/make_credit/make_credit_page.dart';
import 'package:apupu_eventos/layers/presenter/ui/make_sale/make_sale_page.dart';
import 'package:apupu_eventos/layers/presenter/ui/manager_worker/manager_worker_page.dart';
import 'package:apupu_eventos/layers/presenter/ui/register_in_or_out_guest/register_in_or_out_guest_page.dart';
import 'package:apupu_eventos/layers/presenter/ui/report_credit/report_credit_page.dart';
import 'package:apupu_eventos/layers/presenter/ui/report_event/report_event_page.dart';
import 'package:apupu_eventos/layers/presenter/ui/report_sale/report_sale_page.dart';
import 'package:apupu_eventos/layers/presenter/ui/search_guest/search_guest_page.dart';
import 'package:apupu_eventos/layers/presenter/ui/splash/splash_page.dart';
import 'package:flutter/material.dart';

import '../ui/add_event/add_event_page.dart';
import '../ui/add_guest/add_guest_page.dart';
import '../ui/create_manager/create_manager_page.dart';
import '../ui/home/home_page.dart';
import '../ui/manager_event/manager_event_page.dart';
import '../ui/menu_report_event/menu_report_event_page.dart';
import '../ui/result_search_guest/result_search_guest.dart';

abstract class Routes {
  static const SPLASH = "/splash";
  static const HOME = "/home";
  static const ADD_EVENT = "/add_event";
  static const ADD_GUEST = "/add_guest";
  static const MANAGER_EVENT = "/manager_event";
  static const CREATE_WORKER = "/create_worker";
  static const REGISTER_GUEST = "/register_guest";
  static const SEARCH_GUEST = "/search_guest";
  static const RESULT_SEARCH_GUEST = "/result_search_guest";
  static const LOGIN = "/login";
  static const MANAGER_WORKER = "/manager_worker";
  static const REPORT_EVENT = "/report_event";
  static const MAKE_SALE = "/make_sale";
  static const CREATE_PRODUCT = "/create_product";
  static const MAKE_CREDIT = "/make_credit";
  static const CREDIT_AND_SALE_WORKER = "/credit_and_sale_worker";
  static const MENU_REPORT_EVENT = "/menu_report_event";
  static const REPORT_SALE = "/report_sale";
  static const REPORT_CREDIT = "/report_credit";
  static const CREATE_MANAGER = "/create_manager";

  // Routers for Worker

  static Map<String, Widget Function(BuildContext)> routes(
      BuildContext context) {
    return {
      SPLASH: (context) => const SplashPage(),
      HOME: (context) => const HomePage(),
      ADD_EVENT: (context) => const AddEventPage(),
      ADD_GUEST: (context) => const AddGuestPage(),
      MANAGER_EVENT: (context) => const ManagerEventPage(),
      CREATE_WORKER: (context) => const CreateWorkerPage(),
      REGISTER_GUEST: (context) => RegisterInOrOutGuestPage(),
      SEARCH_GUEST: (context) => const SearchGuestPage(),
      RESULT_SEARCH_GUEST: (context) => const ResultSearchGuestPage(),
      LOGIN: (context) => LoginPage(),
      MANAGER_WORKER: (context) => ManagerWorkerPage(),
      REPORT_EVENT: (context) => const ReportEventPage(),
      MAKE_SALE: (context) => const MakeSalePage(),
      CREATE_PRODUCT: (context) => const CreateProductPage(),
      MAKE_CREDIT: (context) => const MakeCreditPage(),
      CREDIT_AND_SALE_WORKER: (context) => const CreditAndSaleWorker(),
      // ignore: prefer_const_constructors
      MENU_REPORT_EVENT: (context) => MenuReportEventPage(),
      REPORT_SALE: (context) => ReportSalePage(),
      REPORT_CREDIT: (context) => ReportCreditPage(),
      CREATE_MANAGER: (context) => const CreateManagerPage(),
    };
  }
}
