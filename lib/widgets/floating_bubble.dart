import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class floatingButton extends StatefulWidget {
  const floatingButton({super.key});

  @override
  State<floatingButton> createState() => _floatingButtonState();
}

class _floatingButtonState extends State<floatingButton>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  bool select = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: FloatingActionBubble(
        // Menu items
        items: <Bubble>[
          // Floating action menu item
          Bubble(
            title: "Photo",
            iconColor: Colors.white,
            bubbleColor: Color.fromARGB(255, 30, 76, 106),
            icon: CupertinoIcons.photo,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              _animationController.reverse();
              setState(() {
                select = false;
              });
            },
          ),
          // Floating action menu item
          Bubble(
            title: "Video",
            iconColor: Colors.white,
            bubbleColor: Color.fromARGB(255, 30, 76, 106),
            icon: CupertinoIcons.video_camera,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              _animationController.reverse();
              setState(() {
                select = false;
              });
            },
          ),
          //Floating action menu item
          Bubble(
            title: "Mic",
            iconColor: Colors.white,
            bubbleColor: Color.fromARGB(255, 30, 76, 106),
            icon: CupertinoIcons.mic,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              // Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){

              // }));
              setState(() {
                select = false;
              });
              _animationController.reverse();
            },
          ),
        ],

        // animation controller
        animation: _animation,

        // On pressed change animation state
        onPress: () {
          _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward();
          if (select == false) {
            setState(() {
              select = true;
            });
          } else {
            setState(() {
              select = false;
            });
          }
        },

        // Floating Action button Icon color
        iconColor: Colors.white,

        // Flaoting Action button Icon
        iconData: select ? Icons.close : Icons.add,
        backGroundColor: Color.fromARGB(255, 30, 76, 106),
      ),
    );
  }
}
