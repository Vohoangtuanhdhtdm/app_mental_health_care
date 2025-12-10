import 'package:app_mental_health_care/app/features/explore/explore_screen.dart';
import 'package:app_mental_health_care/app/features/home/view/home_page.dart';
import 'package:app_mental_health_care/app/features/home/view/profile_page.dart';
import 'package:app_mental_health_care/app/features/home/widgets/navbar_widget.dart';
import 'package:app_mental_health_care/data/constants.dart';
import 'package:app_mental_health_care/data/notifiers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Widget> pages = [HomePage(), ExploreScreen(), ProfilePage()];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              isdarkModeNotifier.value = !isdarkModeNotifier.value;
              final SharedPreferences pref =
                  await SharedPreferences.getInstance();
              await pref.setBool(
                KConstants.themeModeKey,
                isdarkModeNotifier.value,
              );
            },
            icon: ValueListenableBuilder(
              valueListenable: isdarkModeNotifier,
              builder: (context, isDark, child) {
                return Icon(isDark ? Icons.dark_mode : Icons.light_mode);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavbarWidget(),
      body: ValueListenableBuilder(
        valueListenable: selectPageNotifier,
        builder: (context, selected, child) {
          return pages.elementAt(selected);
        },
      ),
    );
  }
}
