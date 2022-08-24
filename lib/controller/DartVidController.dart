
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:youtubeapp/models/YoutubeVideoResult.dart';
import 'package:youtubeapp/repo/youtube_repository.dart';

class DartVidController extends GetxController {
  static DartVidController get to => Get.find();
  //If you need to use your controller in many other places, and outside of GetBuilder, just create a get in your controller and have it easily. (or use Get.find<Controller>() ) نصيحه يعني

  ScrollController scrollController = ScrollController();

  Rx<YoutubeVideoResult> youtubeResult = YoutubeVideoResult(items: []).obs;

  @override
  void onInit() {
    _videoDart();
    _event();
    super.onInit();
  }

  void _event() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent &&
          youtubeResult.value.nextPagetoken != "") {
        _videoDart();
      }
    });
  }

  void _videoDart() async {
    YoutubeVideoResult youtubeVideoResult = await YoutubeRepository.to
        .loadDart(youtubeResult.value.nextPagetoken ?? "");

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
}