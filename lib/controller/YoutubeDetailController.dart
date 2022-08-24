import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtubeapp/controller/VideoController.dart';
import 'package:youtubeapp/models/Statistics.dart';
import 'package:youtubeapp/models/Youtuber.dart';
import 'package:youtubeapp/models/video.dart';

class YoutubeDetailController extends GetxController {
  Rx<Video> video = Video().obs;
  Rx<Statistics> statistics = Statistics().obs;
  Rx<Youtuber> youtuber = Youtuber().obs;
  YoutubePlayerController playController;

  @override
  void onInit() {
    VideoController videoController = Get.find(tag: Get.parameters["videoId"]);
    video(videoController.video);
    statistics(videoController.statistics.value);
    youtuber(videoController.youtuber.value);
    _event();
    super.onInit();
  }

  void _event() {
    playController = YoutubePlayerController(
      initialVideoId: video.value.id.videoId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
  }
}