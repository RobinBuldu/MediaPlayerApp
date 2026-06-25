import 'package:media_player_application/Utilities/FileUtil.dart' as FileUtil;
import 'package:media_player_application/Objects/Media.dart';

List mediaList = FileUtil.getMediaList;
int index = 0;

set setIndex(int newIndex) {
  index = newIndex;
}

int get getIndex {
  return index;
}

void printList() { //DEBUG FUNCTION
  if (mediaList.isEmpty) {
    print("Media list is empty.");
  } else {
    print("Media List:");
    int count = 1;
    for (Media item in mediaList) {
      print("TEST!@# $count ${item.toString()} and path: ${item.getPath}");
      count++;
    }
  }
}

int nextSong(int index) {
  if (mediaList.isEmpty) {
    print("Media list is empty, cannot play next song.");
    return -1; // Indicate no next song available
  }
  if (index == mediaList.length-1) {
    return 0; // Loop back to the first song
  } else {
    return index + 1; // Return the next song index
  }
}

int prevSong(int index) {
  if (mediaList.isEmpty) {
    print("Media list is empty, cannot play previous song.");
    return -1; // Indicate no previous song available
  }
  if (index == 0) {
    return mediaList.length-1; // Loop to the last song
  } else {
    return index - 1; // Return the previous song index
  }
}