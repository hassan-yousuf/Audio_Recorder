import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'audio_player.dart';
import 'audio_recorder.dart';
import 'timer.dart';

class AudioRecorder extends StatefulWidget {
  @override
  State<AudioRecorder> createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  final recorder = SoundRecorder();
  final timerController = TimerController();
  final player = AudioPlayer();
  @override
  void initState() {
    super.initState();
    recorder.init();
    player.init();
  }

  @override
  void dispose() {
    super.dispose();
    recorder.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "A U D I O    R E C O R D E R",
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.purple[700],
      ),
      backgroundColor: Colors.purple[700],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTimer(),
            SizedBox(
              height: 50,
            ),
            buildStartBtn(),
            SizedBox(
              height: 50,
            ),
            buildPlayBtn()
          ],
        ),
      ),
    );
  }

  Widget buildStartBtn() {
    final isRecording = recorder.isRecording;
    final icon = isRecording ? Icons.stop : Icons.mic;
    final iconColor = isRecording ? Colors.white : Colors.purple[700];
    final text = isRecording ? "Stop" : "Start";
    final textColor = isRecording ? Colors.white : Colors.purple[700];
    final primary = isRecording ? Colors.purple : Colors.white;

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(160, 50),
        primary: primary,
      ),
      icon: Icon(
        icon,
        color: iconColor,
      ),
      label: Text(
        text,
        style: TextStyle(
          color: textColor,
        ),
      ),
      onPressed: () async {
        await recorder.toggleRecording();
        final isRecording = recorder.isRecording;
        setState(() {});

        if (isRecording) {
          timerController.startTimer();
        } else {
          timerController.stopTimer();
        }
      },
    );
  }

  Widget buildPlayBtn() {
    final isPlaying = player.isPlaying;
    final icon = isPlaying ? Icons.stop : Icons.play_arrow;
    final iconColor = isPlaying ? Colors.white : Colors.purple[700];
    final text = isPlaying ? "Stop Playing" : "Play Recording";
    final textColor = isPlaying ? Colors.white : Colors.purple[700];
    final primary = isPlaying ? Colors.purple : Colors.white;

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(160, 50),
        primary: primary,
      ),
      icon: Icon(
        icon,
        color: iconColor,
      ),
      label: Text(
        text,
        style: TextStyle(
          color: textColor,
        ),
      ),
      onPressed: () async {
        await player.toggle_playing(whenFinished: () => setState(() {}));
        setState(() {});
      },
    );
  }

  Widget buildTimer() {
    final animate = recorder.isRecording;
    final animate1 = player.isPlaying;
    final text = recorder.isRecording ? "Now Recording" : "Press Start";
    return player.isPlaying
        ? AvatarGlow(
            glowColor: Colors.white,
            endRadius: 150,
            animate: animate1,
            duration: Duration(milliseconds: 2000),
            repeat: true,
            showTwoGlows: true,
            repeatPauseDuration: Duration(milliseconds: 100),
            child: Material(
              shape: CircleBorder(),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.purple[700],
                  radius: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.audiotrack_sharp,
                        size: 80,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : AvatarGlow(
            glowColor: Colors.white,
            endRadius: 150,
            animate: animate,
            duration: Duration(milliseconds: 2000),
            repeat: true,
            showTwoGlows: true,
            repeatPauseDuration: Duration(milliseconds: 100),
            child: Material(
              shape: CircleBorder(),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.purple[700],
                  radius: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TimerWidget(controller: timerController),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          text,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
