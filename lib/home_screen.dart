import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:new_project/screens/donor_screen.dart';
import 'package:new_project/screens/home_tab.dart';
import 'package:new_project/screens/my_profile.dart';
import 'package:new_project/screens/post_request.dart';

import 'package:new_project/shared/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pageController = PageController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        children: const [
          HomeTab(),
          DonorScreen(),
          PostRequest(),
          MyProfile()
          
        ],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.pink.shade50,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          height: 60,
          elevation: 4,
          shadowColor: Colors.black,
          surfaceTintColor: MyColors.navBarBackgroundColor,
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: MyColors.secondaryColor);
            } else {
              return const IconThemeData(color: Colors.grey);
            }
          }),
        ),
        child: NavigationBar(
            backgroundColor: MyColors.navBarBackgroundColor,
            selectedIndex: selectedIndex,
            onDestinationSelected: (i) => setState(() {
                  if ((i - selectedIndex).abs() != 1) {
                    pageController.jumpToPage(i);
                  } else {
                    pageController.animateToPage(i,
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.easeIn);
                  }
                  selectedIndex = i;
                }),
            destinations: const [
              NavigationDestination(
                icon: Icon(
                  FluentIcons.home_48_filled,
                  size: 28,
                ),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.bloodtype,
                  size: 28,
                ),
                label: 'Donar',
              ),
              NavigationDestination(
                icon: Icon(
                  FluentIcons.add_12_filled,
                  size: 28,
                ),
                label: 'Make Request',
              ),
              NavigationDestination(
                icon: Icon(
                  FluentIcons.people_28_filled,
                  size: 28,
                ),
                label: 'Food',
              ),
            ]),
      ),
    );
  }
}
