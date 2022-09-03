
import 'package:audio_recorder/sound_recorder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final recorder = SoundRecorder();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recorder.init();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    recorder.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    var isRecording = recorder.isRecording;
    final icon = isRecording ? Icons.pause : Icons.mic;
    final text = isRecording ? 'Stop' : 'Start';
    final primary = isRecording ? Colors.red : Colors.white;
    final onPrimary = isRecording ? Colors.white : Colors.black;

    return Scaffold(
      body: Container(
        height: h,
        width: w,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  primary: primary,
                  onPrimary: onPrimary,
                ),
                icon: Icon(icon),
                label: Text(text,),
                onPressed: () async {
                  await Permission.microphone.request();
                  final isRecording = await recorder.toggleRecording();
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text('Clicked', style: TextStyle(color: Colors.blue),), backgroundColor: primary,));
                  setState(() {});
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
