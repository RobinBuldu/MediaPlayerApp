import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Widgets/PlayerWidget.dart';
import 'package:media_player_application/Files/FileList.dart' as FileList;
import 'package:media_player_application/Utilities/FileUtil.dart' as FileUtil;

class SimpleExampleApp extends StatefulWidget {
  const SimpleExampleApp();

  @override
  _SimpleExampleAppState createState() => _SimpleExampleAppState();
}

class _SimpleExampleAppState extends State<SimpleExampleApp> {
  late AudioPlayer player = AudioPlayer();
  List mediaList = [];

  @override
  void initState() {
    super.initState();

    // Create the audio player.
    player = AudioPlayer();

    // Set the release mode to keep the source after playback has completed.
    player.setReleaseMode(ReleaseMode.stop);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Set the library path based on the current OS.
      await FileUtil.setlibrary_Path();
      FileUtil.readFiles();
      FileList.printList();
      setState(() {
        mediaList = FileUtil.getMediaList;
      });
    });
  }

  @override
  void dispose() {
    // Release all sources and dispose the player.
    player.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('MP3 Player', style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: mediaList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.music_note, color: Colors.blueAccent),
                  title: Text(mediaList[index].toString()),
                  textColor: Colors.white,
                  onTap: () async {
                    setState(() {
                      FileList.setIndex = index;
                    });
                    // Loop.setIndex = index;
                    // Set the source to the selected file.
                    await player.setSource(
                      DeviceFileSource(mediaList[index].path),
                    );
                    await player.resume();
                  },
                );
              },
            ),
          ),
          Container(
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  FileUtil.getMediaList.isEmpty ? "Not Playing" : "Playing ${FileUtil.getMediaList[FileList.getIndex].getTitle}",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                PlayerWidget(player: player),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
