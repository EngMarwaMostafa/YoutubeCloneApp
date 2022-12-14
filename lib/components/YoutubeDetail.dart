import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtubeapp/controller/YoutubeDetailController.dart';

class YoutubeDetail extends GetView<YoutubeDetailController> {
  const YoutubeDetail({Key key}) : super(key: key);

  Widget _titleZone() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Obx(
            () => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              controller.video.value.snippet.title,
              style: TextStyle(fontSize: 15),
            ),
            Row(
              children: [
                Text(
                  "Views ${controller.statistics.value.viewCount ?? '-'}",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                Text(" · "),
                Text(
                  DateFormat("yyyy-MM-dd")
                      .format(controller.video.value.snippet.publishTime),
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _descriptionZone() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Obx(
            () => Text(
          controller.video.value.snippet.description,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buttonOne(String iconPath, String text) {
    return Column(
      children: [
        SvgPicture.asset("assets/svg/icons/$iconPath.svg"),
        Text(text)
      ],
    );
  }

  Widget _buttonZone() {
    return Obx(
          () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buttonOne("like", controller.statistics.value.likeCount.toString()),
          _buttonOne(
              "dislike", controller.statistics.value.dislikeCount.toString()),
          _buttonOne("share", "share"),
          _buttonOne("save", "save"),
        ],
      ),
    );
  }

  Widget get line => Container(
    height: 1,
    color: Colors.black.withOpacity(0.1),
  );

  Widget _ownerZone() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Obx(
            () => Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey.withOpacity(0.5),
              backgroundImage: Image.network(
                  controller.youtuber.value.snippet.thumbnails.medium.url)
                  .image,
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    controller.youtuber.value.snippet.title,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "person${controller.youtuber.value.statistics.subscriberCount}",
                    style: TextStyle(
                        fontSize: 14, color: Colors.black.withOpacity(0.6)),
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: Text(
                "person",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _description() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _titleZone(),
          line,
          _descriptionZone(),
          _buttonZone(),
          SizedBox(height: 20),
          line,
          _ownerZone()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
      ),
      body: Column(
        children: [
          YoutubePlayer(
            controller: controller.playController,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
            topActions: <Widget>[
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  controller.playController.metadata.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 25.0,
                ),
                onPressed: () {},
              ),
            ],
            onReady: () {},
            onEnded: (data) {},
          ),
          Expanded(
            child: _description(),
          )
        ],
      ),
    );
  }
}