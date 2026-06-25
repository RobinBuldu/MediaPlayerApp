import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:media_player_application/Objects/Media.dart';

String library_Path = "";
String currentOS = "";
List<Media> mediaList = List.empty(growable: true);

bool doesFolderExist(String path) {
  return true;
}

String _getOS() {
  if (Platform.isAndroid) {
    return "Android";
  } else if (Platform.isIOS) {
    return "iOS";
  } else if (kIsWeb) {
    return "Web";
  }
  return "Unknown OS";
}

Future<void> setlibrary_Path() async {
  currentOS = _getOS();
  if (currentOS == "Android") {
      // Ask for storage permission first
      var status = await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        final publicMusicDir = Directory("/sdcard/Music"); //files should be in /sdkgphonex86_64/Music
        if (await publicMusicDir.exists()) {
          library_Path = publicMusicDir.path;
        } else {
          print("Public music folder not found!");
          makeFolders();
        }
        } else if (status.isPermanentlyDenied) {
          openAppSettings();
        }
    } else if (currentOS == "iOS") {
      library_Path = (await getApplicationDocumentsDirectory()).path;
    } else {
      print("Unsupported platform: $currentOS");
      return;
    }
    if (library_Path == "" || library_Path.isEmpty) {
      print("Library path is empty, check your permissions or platform support.");
      return;
    }
  print("Library Path: $library_Path");
}

get getLibraryPath {
  return library_Path;
}

get getMediaList {
  return mediaList;
}

void makeFolders(){}

void writeFiles() {}

void readFiles() {
  final dir = Directory(library_Path);
  final files = dir.listSync().where((item) => item is File && item.path.endsWith('.mp3'));
  mediaList = files.map((fileEntity) {
    final file = File(fileEntity.path);
    final title = file.uri.pathSegments.last;
    final path = file.path;
    final stat = file.statSync();
    return Media(
        title: title,
        path: path,
        addedAt: stat.changed
    );
  }).toList();
}