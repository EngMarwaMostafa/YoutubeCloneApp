import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:youtubeapp/models/YoutubeVideoResult.dart';
import 'package:youtubeapp/repo/youtube_repository.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  //If you need to use your controller in many other places, and outside of GetBuilder, just create a get in your controller and have it easily. (or use Get.find<Controller>() )
  ScrollController scrollController = ScrollController();

  Rx<YoutubeVideoResult> youtubeResult = YoutubeVideoResult(items: []).obs;

  @override
  void onInit() {
    _videoLoad();
    _videoLoadgetx();
    _event();
    super.onInit();
  }

  void _event() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent &&
          youtubeResult.value.nextPagetoken != "") {
        _videoLoad();
      }
    });
  }

  void _videoLoad() async {
    YoutubeVideoResult youtubeVideoResult = await YoutubeRepository.to
        .loadVideos(youtubeResult.value.nextPagetoken ?? "");

    // ?? operator بيقولك لو كذا اداك null خد اللي بده
    // youtubeResult.value.nextPagetoken  == null   يعني مثلا لو
    // take " "
    //

    if (youtubeVideoResult != null &&
        youtubeVideoResult.items != null &&
        youtubeVideoResult.items.length > 0) {
      youtubeResult.update((youtube) {
        youtube.nextPagetoken = youtubeVideoResult.nextPagetoken;
        youtube.items.addAll(youtubeVideoResult.items);
      });
    }
  }

  void _videoLoadgetx() async {
    YoutubeVideoResult youtubeVideoResult = await YoutubeRepository.to
        .loadGetxVed(youtubeResult.value.nextPagetoken ?? "");

    if (youtubeVideoResult != null &&
        youtubeVideoResult.items != null &&
        youtubeVideoResult.items.length > 0) {
      youtubeResult.update((youtube) {
        youtube.nextPagetoken = youtubeVideoResult.nextPagetoken;
        youtube.items.addAll(youtubeVideoResult.items);
      });
    }
  }
}