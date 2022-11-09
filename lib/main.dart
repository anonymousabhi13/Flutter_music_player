import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool playing = false;
  IconData playbtn = Icons.play_arrow;

  AudioPlayer _player = AudioPlayer();
  AudioCache cache = AudioCache();

  Duration position = new Duration();
  Duration musicLength = new Duration();
  Widget slider() {
    return Slider.adaptive(
      value: position.inSeconds.toDouble(),
      onChanged: (value) {
        seekToSec(value.toInt());
      },
      max: musicLength.inSeconds.toDouble(),
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
    );
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec.toInt());
    _player.seek(newPos);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _player.durationHandler = (d) {
    //   setState(() {
    //     musicLength = d;
    //   });
    // };
    // _player.positionHandler = (p) {
    //   setState(() {
    //     position = p;
    //   });
    // };
    cache.load('peaky.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue, Color.fromARGB(255, 182, 214, 241)])),
            child: Padding(
              padding: EdgeInsets.only(top: 48),
              child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          'Music Player',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          'Listen to Your Favorite Music',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: Container(
                          // padding: EdgeInsets.symmetric(vertical: 50),

                          width: 280,
                          height: 280,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              image: DecorationImage(
                                  image: AssetImage('assets/music.jpeg'))),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          'Music',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 400,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                            '${position.inMinutes}:${position.inSeconds.remainder(60)}'),
                                        slider(),
                                        Text(
                                            '${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}'),
                                      ]),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      iconSize: 48,
                                      color: Colors.blue,
                                      icon: Icon(Icons.skip_previous),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      iconSize: 60,
                                      color: Colors.blue,
                                      onPressed: () {
                                        if (!playing) {
                                          cache.play('peaky.mp3');
                                          setState(() {
                                            playbtn = Icons.pause;
                                            playing = true;
                                          });
                                        } else {
                                          _player.pause();

                                          setState(() {
                                            playbtn = Icons.play_arrow;
                                            playing = false;
                                          });
                                        }
                                      },
                                      icon: Icon(playbtn),
                                    ),
                                    IconButton(
                                      iconSize: 48,
                                      color: Colors.blue,
                                      icon: Icon(Icons.skip_next),
                                      onPressed: () {},
                                    ),
                                  ],
                                )
                              ],
                            )),
                      )
                    ]),
              ),
            )));
  }
}
