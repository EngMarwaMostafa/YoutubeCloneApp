import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:youtubeapp/controller/AppController.dart';
import 'package:youtubeapp/pages/CleanCode.dart';
import 'package:youtubeapp/pages/DartVid.dart';
import 'package:youtubeapp/pages/GetXVd.dart';
import 'package:youtubeapp/pages/Home.dart';

class App extends GetView<AppController> {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (RouteName.values[controller.currentIndex.value]) {
          case RouteName.Home:
            return Home();
            break;
          case RouteName.GetXVd:
            return GetXVd();
            break;
          case RouteName.DartVid:
            return DartVid();
            break;
          case RouteName.CleanCode:
            return CleanCode();
            break;
          case RouteName.Add:
            break;
        }
        return Container();
      }),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.currentIndex.value,
          showSelectedLabels: true,
          selectedItemColor: Colors.black,
          onTap: controller.changePageIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              // SvgPicture.asset("assets/svg/icons/home_off.svg"),
              activeIcon: Icon(Icons.home),
              //  SvgPicture.asset("assets/svg/icons/home_on.svg"),
              label: "All vid",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.compass_calibration_sharp),
              activeIcon: Icon(Icons.compass_calibration),
              label: "GetX",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Image.asset('assets/svg/icons/plus.png'),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/svg/icons/subscribe_off.png'),
              //SvgPicture.asset("assets/svg/icons/subs_off.svg"),
              activeIcon: Image.asset('assets/svg/icons/subscribe_on.png'),
              label: "Dart",
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/svg/icons/library_off.png'),
              //   SvgPicture.asset("assets/svg/icons/library_off.svg"),
              activeIcon: Image.asset('assets/svg/icons/library_on.png'),
              //  SvgPicture.asset("assets/svg/icons/library_on.svg"),
              label: "Clean code",
            ),
          ],
        ),
      ),
    );
  }
}
