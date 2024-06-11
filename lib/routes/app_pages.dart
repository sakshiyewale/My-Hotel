import 'package:get/get.dart';
import 'package:my_hotel/binding/app_binding.dart';
import 'package:my_hotel/routes/routs.dart';
import 'package:my_hotel/screens/connectivity%20check.dart';

import 'package:my_hotel/screens/history_screen.dart';
import 'package:my_hotel/screens/kot_screen.dart';
import 'package:my_hotel/screens/login_screen.dart';
import 'package:my_hotel/screens/menu_screen.dart';
import 'package:my_hotel/screens/order_screen.dart';
import 'package:my_hotel/screens/registration_screen.dart';
import 'package:my_hotel/screens/spashScreen.dart';

class AppPages
{
 static String INITIAL_ROUTE = Routs.ORDER_ROUTE;

 static final pages =
 [
   GetPage(
       name: Routs.LOGIN_ROUTE,
       page: () => LoginScreen(),
       binding:LoginBinding()
   ),
   GetPage(
       name: Routs.MENU_ROUTE,
       page: () =>AppMenuScreen(),
       binding:AppMenuBinding()
   ),
   GetPage(
       name: Routs.HISTORY_ROUTE,
       page: () => HistoryScreen(),
       binding:HistoryBinding()
   ),
   GetPage(
       name: Routs.ORDER_ROUTE,
       page: () => OrderScreen(),
       binding:OrderBinding()
   ),
   GetPage(
       name: Routs.SPLASH_ROUTE,
       page: ()=>SplashScreen(),
       binding: SplashBinding()
   ),
   GetPage(
       name:Routs.REGISTRATION_ROUTE,
       page:()=>RegistrationScreen(),
       binding: RegistrationBinding()
   ),
   GetPage(
     name: Routs.KOT_ROUTE,
     page: () => KOTScreen(
       selectedItems: {}), // Pass an empty map as selectedItems
     binding: KOTScreenBinding(),
   ),
   GetPage(
       name: Routs.CONNECTIVITY_ROUTE,
       page:()=> ConnectivityCheckScreen(),
       binding: ConnectivityBinding()
   )

 ];
}