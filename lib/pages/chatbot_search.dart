// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatBotSearch extends StatefulWidget {
  const ChatBotSearch({super.key});

  @override
  State<ChatBotSearch> createState() => _ChatBotSearchState();
}

class _ChatBotSearchState extends State<ChatBotSearch> {
  String answer = "";
  bool isLoading = false;

  final databaseReference = FirebaseDatabase.instance.ref("ChatBot");
  final databaseReferenceFetch = FirebaseDatabase.instance
      .ref("ChatBot")
      .child("receiveTextFromPythonForChatbot/QueryAnswer");

  @override
  void initState() {
    super.initState();
    answer = '';
  }

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 207, 222, 229),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: 'Clear your Doubts....',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await databaseReferenceFetch.set("");
                      await databaseReference
                          .child("sendTextFromFlutterForChatBot")
                          .set({'TextQuery': textController.text});
                      print("Text sent successfully.");
                    } catch (e) {
                      print("Error sending text: $e");
                    }
                    try {
                      databaseReferenceFetch.onValue.listen((event) {
                        answer = event.snapshot.value.toString();
                        setState(() {
                          if (answer != "") {
                            isLoading = false;
                            print("-----------set to flase---------");
                          } // Set isLoading to false when data is received
                        });
                        print("Data received: $answer");
                        print("Text received successfully.");
                      });
                    } catch (e) {
                      print("Error receiving text: $e");
                    }
                  },
                  icon: Icon(Icons.send),
                  color: const Color.fromARGB(255, 26, 136, 226),
                ),
              ],
            ),
          ),
          SafeArea(
            child: const SizedBox(
              height: 20,
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(
                    child: Column(
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text("Fetching Data..."),
                      ],
                    ),
                  )
                : Scrollbar(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Text(
                          answer,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
