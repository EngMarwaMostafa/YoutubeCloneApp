import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:youtubeapp/app.dart';
import 'package:youtubeapp/binding/InitBinding.dart';
import 'package:youtubeapp/components/YoutubeDetail.dart';
import 'package:youtubeapp/controller/YoutubeDetailController.dart';
import 'package:youtubeapp/controller/search_controller.dart';
import 'package:youtubeapp/pages/YoutubeSearch.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Youtube Clone App",
      theme: ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialBinding: InitBinding(),
      getPages: [
        GetPage(name: "/", page: () => App()),
        GetPage(
          name: "/detail/:videoId",
          page: () => YoutubeDetail(),
          binding: BindingsBuilder(
                () => Get.lazyPut<YoutubeDetailController>(
                    () => YoutubeDetailController()),
          ),
        ),
        GetPage(
          name: "/search",
          page: () => YoutubeSearch(),
          binding: BindingsBuilder(
                () => Get.lazyPut<YoutubeSearchController>(
                    () => YoutubeSearchController()),
          ),
        )
      ],
    );
  }
}
