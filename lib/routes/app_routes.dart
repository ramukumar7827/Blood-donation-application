import 'package:go_router/go_router.dart';
import 'package:new_project/home_screen.dart';
import 'package:new_project/screens/donor_screen.dart';
import 'package:new_project/screens/home_tab.dart';
import 'package:new_project/screens/login_screen.dart';
import 'package:new_project/screens/sign_up.dart';


final routeConfig = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/get-started',
      builder: (context, state) => const DonorScreen() ,
    ),
    GoRoute(
      path: '/homeScreen',
      builder: (context, state) => const HomeTab(),
    ),
  ],
);
