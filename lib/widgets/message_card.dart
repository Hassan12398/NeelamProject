// ignore_for_file: dead_code

import 'package:audioplayers/audioplayers.dart';
import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nelaamproject/widgets/videoPlayer.dart';

class imageCard1 extends StatelessWidget {
  String imagee;
  var time;
  imageCard1({
    Key? key,
    required this.imagee,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Bubble(
            margin: BubbleEdges.only(top: 10, right: 60),
            alignment: Alignment.topLeft,
            nipWidth: 15,
            elevation: 15,
            nipHeight: 10,
            nip: BubbleNip.leftBottom,
            radius: Radius.circular(18),
            color: Color.fromARGB(255, 45, 79, 106),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imagee,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
                height: 300,
                width: 300,
              ),
            )),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  DateFormat.jm().format(time.toDate()),
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  DateFormat.yMd().format(time.toDate()),
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class imageCard extends StatelessWidget {
  String imagee;
  var time;
  imageCard({
    Key? key,
    required this.imagee,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Bubble(
            margin: BubbleEdges.only(top: 10, left: 60),
            alignment: Alignment.topRight,
            nipWidth: 15,
            elevation: 15,
            nipHeight: 10,
            nip: BubbleNip.rightBottom,
            radius: Radius.circular(18),
            color: Color.fromARGB(255, 174, 209, 232),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imagee,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
                height: 300,
                width: 300,
              ),
            )),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  DateFormat.jm().format(time.toDate()),
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  DateFormat.yMd().format(time.toDate()),
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class messageCard1 extends StatelessWidget {
  String message;
  final time;
  messageCard1({
    Key? key,
    required this.message,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Bubble(
          margin: BubbleEdges.only(top: 10, right: 60, bottom: 5),
          alignment: Alignment.topLeft,
          nipWidth: 15,
          elevation: 3,
          nipHeight: 10,
          nip: BubbleNip.leftBottom,
          radius: Radius.circular(14),
          color: Color.fromARGB(255, 45, 79, 106),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 6, left: 30, right: 20, bottom: 10),
            child: Text(
              message,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  DateFormat.jm().format(time.toDate()),
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  DateFormat.yMd().format(time.toDate()),
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class messageCard extends StatelessWidget {
  String message;
  final time;
  messageCard({
    Key? key,
    required this.message,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Bubble(
          margin: BubbleEdges.only(top: 10, left: 60, bottom: 5),
          // borderWidth: 2000,
          alignment: Alignment.topRight,
          nipWidth: 15,
          elevation: 3,
          nipHeight: 10,
          nip: BubbleNip.rightBottom,
          radius: Radius.circular(14),
          color: Color.fromARGB(255, 174, 209, 232),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 6, left: 30, right: 20, bottom: 10),
            child: Text(
              message,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  DateFormat.jm().format(time.toDate()),
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  DateFormat.yMd().format(time.toDate()),
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class audioCard extends StatefulWidget {
  String url;
  String dur;
  final time;
  String imageUrl;
  audioCard(
      {super.key,
      required this.dur,
      required this.time,
      required this.url,
      required this.imageUrl});

  @override
  State<audioCard> createState() => _audioCardState();
}

class _audioCardState extends State<audioCard> {
  final audioplayer = AudioPlayer();
  bool isplaying = false;
  bool buff = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    audioplayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isplaying = state == PlayerState.playing;
      });
    });
    audioplayer.onPlayerComplete.listen((event) {
      isplaying = false;
      setState(() {});
    });
    audioplayer.onDurationChanged.listen((NDuration) {
      setState(() {
        duration = NDuration;
      });
    });
    audioplayer.onPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
  }

  @override
  void dispose() {
    audioplayer.dispose();
    super.dispose();
  }

  String formatTime(Duration duration) {
    String twodigets(int n) => n.toString().padLeft(2, '0');
    final hours = twodigets(duration.inHours);
    final twomin = twodigets(duration.inMinutes.remainder(60));
    final twomsec = twodigets(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, twomin, twomsec].join(':');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Bubble(
          margin: BubbleEdges.only(top: 10, left: 46),
          alignment: Alignment.topRight,
          nipWidth: 15,
          nipHeight: 10,
          nip: BubbleNip.rightBottom,
          radius: Radius.circular(18),
          color: Color.fromARGB(255, 174, 209, 232),
          // child: Text(
          //   'Helloe how are you i am fine and you r my best friend i like you you are best gggg pubg gg',
          //   textAlign: TextAlign.right,
          //   style: TextStyle(
          //     fontSize: 17,
          //   ),
          // ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(29),
                  color: Colors.transparent,
                ),
                margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                child: Stack(children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 3, left: 15, right: 8, bottom: 5),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 17,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(widget.imageUrl),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () async {
                              if (isplaying) {
                                await audioplayer.pause();
                              } else {
                                await audioplayer.play(UrlSource(widget.url));
                                buff = true;
                                await Future.delayed(Duration(seconds: 2));
                                buff = false;
                              }

                              setState(() {});
                            },
                            child: Icon(
                              isplaying ? Icons.pause : Icons.play_arrow,
                              color: Color.fromARGB(255, 30, 76, 106),
                            ),
                          ),
                          Container(
                            color: Colors.transparent,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Slider(
                                thumbColor: Color.fromARGB(255, 30, 76, 106),
                                activeColor: Color.fromARGB(255, 30, 76, 106),
                                inactiveColor: Colors.grey,
                                min: 0,
                                max: duration.inSeconds.toDouble(),
                                value: position.inSeconds.toDouble(),
                                onChanged: (v) async {
                                  final position = Duration(seconds: v.toInt());
                                  await audioplayer.seek(position);
                                  await audioplayer.resume();
                                }),
                          ),
                          Text(
                            isplaying ? formatTime(position) : widget.dur,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      )),
                  // Positioned(
                  //   bottom: 4,
                  //   right: 10,
                  //   child:
                  // )
                ]),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  DateFormat.jm().format(widget.time.toDate()),
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  DateFormat.yMd().format(widget.time.toDate()),
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class audioCard1 extends StatefulWidget {
  String url;
  String dur;
  final time;
  String imageUrl;
  audioCard1(
      {super.key,
      required this.dur,
      required this.time,
      required this.url,
      required this.imageUrl});

  @override
  State<audioCard1> createState() => _audioCard1State();
}

class _audioCard1State extends State<audioCard1> {
  final audioplayer = AudioPlayer();
  bool isplaying = false;
  bool buff = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    audioplayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isplaying = state == PlayerState.playing;
      });
    });
    audioplayer.onPlayerComplete.listen((event) {
      isplaying = false;
      setState(() {});
    });
    audioplayer.onDurationChanged.listen((NDuration) {
      setState(() {
        duration = NDuration;
      });
    });
    audioplayer.onPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
  }

  @override
  void dispose() {
    audioplayer.dispose();
    super.dispose();
  }

  String formatTime(Duration duration) {
    String twodigets(int n) => n.toString().padLeft(2, '0');
    final hours = twodigets(duration.inHours);
    final twomin = twodigets(duration.inMinutes.remainder(60));
    final twomsec = twodigets(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, twomin, twomsec].join(':');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Bubble(
          margin: BubbleEdges.only(top: 10, right: 46),
          alignment: Alignment.topLeft,
          nipWidth: 15,
          nipHeight: 10,
          nip: BubbleNip.leftBottom,
          radius: Radius.circular(18),
          color: Color.fromARGB(255, 30, 76, 106),
          // child: Text(
          //   'Helloe how are you i am fine and you r my best friend i like you you are best gggg pubg gg',
          //   textAlign: TextAlign.right,
          //   style: TextStyle(
          //     fontSize: 17,
          //   ),
          // ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(29),
                  color: Colors.transparent,
                ),
                margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                child: Stack(children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 3, left: 15, right: 8, bottom: 5),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 17,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(widget.imageUrl),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () async {
                              if (isplaying) {
                                await audioplayer.pause();
                              } else {
                                await audioplayer.play(UrlSource(widget.url));
                                buff = true;
                                await Future.delayed(Duration(seconds: 2));
                                buff = false;
                              }

                              setState(() {});
                            },
                            child: Icon(
                              isplaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            color: Colors.transparent,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Slider(
                                thumbColor: Colors.white,
                                activeColor: Colors.white,
                                inactiveColor: Colors.grey,
                                min: 0,
                                max: duration.inSeconds.toDouble(),
                                value: position.inSeconds.toDouble(),
                                onChanged: (v) async {
                                  final position = Duration(seconds: v.toInt());
                                  await audioplayer.seek(position);
                                  await audioplayer.resume();
                                }),
                          ),
                          Text(
                            isplaying ? formatTime(position) : widget.dur,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )),
                  // Positioned(
                  //   bottom: 4,
                  //   right: 10,
                  //   child:
                  // )
                ]),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  DateFormat.jm().format(widget.time.toDate()),
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  DateFormat.yMd().format(widget.time.toDate()),
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class videoCard1 extends StatefulWidget {
  String thumbnail;
  String videoUrl;
  final time;
  videoCard1({
    Key? key,
    required this.thumbnail,
    required this.time,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<videoCard1> createState() => _videoCard1State();
}

class _videoCard1State extends State<videoCard1> {
  bool isshow = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Bubble(
            margin: BubbleEdges.only(top: 10, right: 60),
            alignment: Alignment.topLeft,
            nipWidth: 15,
            elevation: 15,
            nipHeight: 10,
            nip: BubbleNip.leftBottom,
            radius: Radius.circular(18),
            color: Color.fromARGB(255, 45, 79, 106),
            child: Column(children: [
              Stack(alignment: Alignment.center, children: [
                isshow
                    ? Container(
                        height: 210,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(16)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: VideoPlayer1(videoUrl: widget.videoUrl)))
                    : Container(
                        height: 210,
                        width: 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: InteractiveViewer(
                            child: CachedNetworkImage(
                              imageUrl: widget.thumbnail,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                isshow
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          isshow = true;
                          setState(() {});
                        },
                        child: CircleAvatar(
                          radius: 17,
                          backgroundColor: Color.fromARGB(255, 30, 76, 106),
                          child: Center(
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                // Positioned(
                //   bottom: 4,
                //   right: 10,
                //   child:
                // )
              ])
            ])),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  DateFormat.jm().format(widget.time.toDate()),
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  DateFormat.yMd().format(widget.time.toDate()),
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class videoCard extends StatefulWidget {
  String thumbnail;
  String videoUrl;
  final time;
  videoCard({
    Key? key,
    required this.thumbnail,
    required this.time,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<videoCard> createState() => _videoCardState();
}

class _videoCardState extends State<videoCard> {
  bool isshow = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Bubble(
            margin: BubbleEdges.only(top: 10, left: 60),
            alignment: Alignment.topRight,
            nipWidth: 15,
            elevation: 15,
            nipHeight: 10,
            nip: BubbleNip.rightBottom,
            radius: Radius.circular(18),
            color: Color.fromARGB(255, 174, 209, 232),
            child: Column(children: [
              Stack(alignment: Alignment.center, children: [
                isshow
                    ? Container(
                        height: 210,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(16)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: VideoPlayer1(videoUrl: widget.videoUrl)))
                    : Container(
                        height: 210,
                        width: 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: InteractiveViewer(
                            child: CachedNetworkImage(
                              imageUrl: widget.thumbnail,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                isshow
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            isshow = true;
                          });
                        },
                        child: CircleAvatar(
                          radius: 17,
                          backgroundColor: Color.fromARGB(255, 30, 76, 106),
                          child: Center(
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                // Positioned(
                //   bottom: 4,
                //   right: 10,
                //   child:
                // )
              ])
            ])),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  DateFormat.jm().format(widget.time.toDate()),
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  DateFormat.yMd().format(widget.time.toDate()),
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
