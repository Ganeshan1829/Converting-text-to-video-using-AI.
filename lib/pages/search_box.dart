// ignore_for_file: avoid_print, sized_box_for_whitespace, prefer_const_constructors, unused_import, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, deprecated_member_use


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';
import 'package:login_signup/firebase_options.dart';

class ChatGPTTextField extends StatefulWidget {
  const ChatGPTTextField({super.key});

  @override
  _ChatGPTTextFieldState createState() => _ChatGPTTextFieldState();
}

class _ChatGPTTextFieldState extends State<ChatGPTTextField> {
  late FlickManager flickManager;
  bool _isVideoVisible = false;
  bool _isFetchingVideo = false;
  final textController = TextEditingController();
  String urldel = "";
  String urlOfVideo = "";
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    deleteVideoInFirebaseStorage();
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 207, 222, 229),
      body: Form(
        key: _formKey, // Set form key
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        controller: textController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Type to Search....',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          final databaseReference =
                              FirebaseDatabase.instance.ref("Video/");
                          await databaseReference
                              .child("SendQueryFromFlutter")
                              .set({'Question': textController.text});
                          //deleteVideoInFirebaseStorage();
                          fetchUrlOfVideo();
                          print(
                              "-----------------send user query to firebase --> python -------------------------");
                        } catch (e) {
                          print(
                              "--------------------error in send query to firebase ----> python --------------------");
                        }
                      }
                    },
                    icon: const Icon(Icons.send),
                    color: const Color.fromARGB(255, 26, 136, 226),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            if (_isFetchingVideo)
              Column(
                children: [
                  const SizedBox(height: 10),
                  const CircularProgressIndicator(),
                  const Text('AI Preparing Video...'),
                ],
              )
            else if (_isVideoVisible)
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: FlickVideoPlayer(
                  flickManager: flickManager,
                ),
              ),
          ],
        ),
      ),
    );
  }

//=============================================================================================
// delete video and store user query in firebase realtime db
  deleteVideoInFirebaseStorage() async {
    setState(() {
      _isVideoVisible = false;
      //_isFetchingVideo = true;
    });

    try {
      final ref = FirebaseStorage.instance.ref("test/").child("fish.mp4");
      urldel = (await ref.getDownloadURL()).toString();

      FirebaseStorage.instance.refFromURL(urldel).delete();
      print("----------------Delete the video-----------");
    } catch (e) {
      print("------Error occur in delete url-------------------");
      print(e);
    }
  }

  // check file exits or not

  Future<bool> checkFileisExits() async {
    // give waiting time based on creating video
    await Future.delayed(Duration(seconds: 60));
    try {
      final ref = FirebaseStorage.instance.ref("test/");
      await ref.child("fish.mp4").getDownloadURL();
      return true;
    } catch (e) {
      fetchUrlOfVideo();
      return false;
    }
  }

  //Fetch URI from the Firebase Storage --> VIdeo Link
  fetchUrlOfVideo() async {
    setState(() {
      _isVideoVisible = false;
      _isFetchingVideo = true;
    });
    bool fileExists = await checkFileisExits();
    if (fileExists == true) {
      try {
        print(
            "----------------------------the file is exits sucessfully-----------------");
        final ref = FirebaseStorage.instance.ref("test/").child("fish.mp4");
        //await Future.delayed(Duration(seconds: 20));
        urlOfVideo = await ref.getDownloadURL();
        print(
            "---------------------------------URl is fetched successfully-----------");
        initializeVideo();
      } catch (e) {
        print(
            "---------------------------------erron in fetch url-----------------------");
        print(e);
      }
    } else {
      print(
          "-----------------------file not  exits----------------------------");
    }
  }

  // display video
  Future<void> initializeVideo() async {
    setState(() {
      _isFetchingVideo = true;
    });
    try {
      final videoPlayerController = VideoPlayerController.network(urlOfVideo);
      flickManager = FlickManager(
        videoPlayerController: videoPlayerController,
      );
      print("-----------------video displayed successfully----------------");
    } catch (e) {
      print("------------------error in video player------------");
      print(e);
    }

    setState(() {
      _isVideoVisible = true;
      _isFetchingVideo = false;
    });
  }
}
