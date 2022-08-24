import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtubeapp/models/YoutubeVideoResult.dart';
import 'package:youtubeapp/repo/youtube_repository.dart';

class YoutubeSearchController extends GetxController {
  String key = "searchKey";
  RxList<String> history = RxList<String>.empty(growable: true);
  SharedPreferences _profs;
  ScrollController scrollController = ScrollController();
  String _currentKeyword;
  Rx<YoutubeVideoResult> youtubeVideoResult = YoutubeVideoResult(items: []).obs;
  @override
  void onInit() async {
    _event();
    _profs = await SharedPreferences.getInstance();
    List<dynamic> initData = _profs.get(key) ?? [];
    history(initData.map<String>((_) => _.toString()).toList());
    super.onInit();
  }

  void _event() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent &&
          youtubeVideoResult.value.nextPagetoken != "") {
        _searchYoutube(_currentKeyword);
      }
    });
  }

  void submitSearch(String searchKey) {
    history.addIf(!history.contains(searchKey), searchKey);
    _profs.setStringList(key, history);
    _currentKeyword = searchKey;
    _searchYoutube(searchKey);
  }

  void _searchYoutube(String searchKey) async {
    YoutubeVideoResult youtubeVideoResultFromServer = await YoutubeRepository.to
        .search(searchKey, youtubeVideoResult.value.nextPagetoken ?? "");

    if (youtubeVideoResultFromServer != null &&
        youtubeVideoResultFromServer.items != null &&
        youtubeVideoResultFromServer.items.length > 0) {
      youtubeVideoResult.update((youtube) {
        youtube.nextPagetoken = youtubeVideoResultFromServer.nextPagetoken;
        youtube.items.addAll(youtubeVideoResultFromServer.items);
      });
    }
  }
}