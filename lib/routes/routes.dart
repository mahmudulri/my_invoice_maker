import 'package:get/get.dart';
import 'package:invoice_maker/dashboard.dart';
import 'package:invoice_maker/screens/clients_screen.dart';
import 'package:invoice_maker/screens/myshop_screen.dart';
import 'package:invoice_maker/screens/product_screen.dart';
import 'package:invoice_maker/splash_screen.dart';

import '../bindings/clientlist_binding.dart';
import '../bindings/dashboard_binding.dart';
import '../bindings/myshops_binding.dart';
import '../bindings/productlist_binding.dart';
import '../bindings/signin_binding.dart';
import '../bindings/splash_binding.dart';
import '../screens/sign_in_screen.dart';

const String splashscreen = '/splash-screen';
const String signinscreen = '/signin-screen';
const String dashboard = '/dashboard';
const String clientscreen = '/client-screen';
const String myshopscreen = '/shop-screen';
const String productscreen = '/product-screen';

List<GetPage> myroutes = [
  GetPage(
    name: splashscreen,
    page: () => SplashScreen(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: signinscreen,
    page: () => SignInScreen(),
    binding: SigninBinding(),
  ),
  GetPage(
    name: dashboard,
    page: () => DashBoard(),
    binding: DashboardBinding(),
  ),
  GetPage(
    name: clientscreen,
    page: () => ClientsScreen(),
    binding: ClientlistBinding(),
  ),
  GetPage(
    name: myshopscreen,
    page: () => MyshopScreen(),
    binding: MyshopsBinding(),
  ),
  GetPage(
    name: productscreen,
    page: () => ProductScreen(),
    binding: ProductlistBinding(),
  ),
];
