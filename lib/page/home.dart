import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import '../utils/mock_data.dart';
import './camera.dart';
import './profile.dart';
import './setting.dart';
import '../utils/smartIp_data.dart';
import 'package:cron/cron.dart';

enum _MenuValues { IpCamera, SmartCamera }

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  int cAC = 2;
  @override
  void initState() {
    Camera.flag.value = 1;
    Camera.cAC.value = 2;
    Camera.mode.value = mockData;
    Camera.count.value = 1;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    Camera();
    super.initState();
  }
  //Properties

  int currentTab = 0;

  final List<Widget> screens = [
    Camera(),
    Profile(),
    Setting(),
  ];

  Widget currentScreen = Camera();

  final PageStorageBucket bucket = PageStorageBucket();
  final cron = Cron();
  ScheduledTask? scheduledTask;
  void scheduleTask() async {
    scheduledTask = cron.schedule(Schedule.parse("*/2 * * * * *"), () async {
      Camera.count.value++;
      print('Executing task: ' + Camera.count.value.toString());
    });
  }

  void cancelTask() {
    print('Cancel scheduled!');
    scheduledTask!.cancel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      //FAB Button

      floatingActionButton: currentTab != 1
          ? FloatingActionBubble(
              items: <Bubble>[
                Bubble(
                  icon: Icons.view_comfy,
                  iconColor: Colors.white,
                  title: "2 Rows ",
                  titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                  bubbleColor: Colors.blue,
                  onPress: () {
                    _animationController.forward();
                    setState(() {
                      cAC = 2;
                      Camera.cAC.value = 2;
                    });
                  },
                ),
                Bubble(
                  icon: Icons.view_comfy,
                  iconColor: Colors.white,
                  title: "3 Rows",
                  titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                  bubbleColor: Colors.blue,
                  onPress: () {
                    _animationController.forward();
                    setState(() {
                      cAC = 3;
                      Camera.cAC.value = 3;
                    });
                  },
                ),
                Bubble(
                  icon: Icons.view_comfy,
                  iconColor: Colors.white,
                  title: "4 Rows",
                  titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                  bubbleColor: Colors.blue,
                  onPress: () {
                    _animationController.forward();
                    Camera.cAC.value = 4;
                  },
                ),
              ],
              animation: _animation,
              onPress: () => _animationController.isCompleted
                  ? _animationController.reverse()
                  : _animationController.forward(),
              backGroundColor: Colors.blue,
              iconColor: Colors.white,
              iconData: Icons.select_all,
            )
          : null,
      //FAB Position
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.085, //60
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MaterialButton(
                minWidth: MediaQuery.of(context).size.height * 0.05, //40
                onPressed: () {
                  setState(
                    () {
                      currentScreen = Camera();
                      currentTab = 0;
                    },
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.home,
                      size: 36,
                      color: currentTab == 0 ? Colors.blue : Colors.grey,
                    ),
                    // Text(
                    //   'Dashboard',
                    //   style: TextStyle(
                    //     color: currentTab == 0 ? Colors.blue : Colors.grey,
                    //   ),
                    // ),
                  ],
                ),
              ),
              PopupMenuButton<_MenuValues>(
                icon: Icon(
                  Icons.camera_enhance,
                  size: 36,
                  color: Colors.grey,
                ),
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    onTap: () => {
                      cancelTask(),
                      Camera.mode.value = mockData,
                      Camera.flag.value = 1,
                    },
                    child: Text('Ip camera'),
                    value: _MenuValues.IpCamera,
                  ),
                  PopupMenuItem(
                    child: Text('Smart camera'),
                    onTap: () => {
                      scheduleTask(),
                      Camera.mode.value = smartIp,
                      Camera.flag.value = 2,
                    },
                    value: _MenuValues.SmartCamera,
                  ),
                ],
                onSelected: (value) {
                  switch (value) {
                    case _MenuValues.IpCamera:
                      break;
                    case _MenuValues.SmartCamera:
                      break;
                  }
                },
              ),
              MaterialButton(
                minWidth: MediaQuery.of(context).size.height * 0.05,
                onPressed: () {
                  setState(
                    () {
                      currentScreen = Profile();
                      currentTab = 1;
                    },
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      size: 36,
                      color: currentTab == 1 ? Colors.blue : Colors.grey,
                    ),
                    // Text(
                    //   'Profile',
                    //   style: TextStyle(
                    //     color: currentTab == 1 ? Colors.blue : Colors.grey,
                    //   ),
                    // ),
                  ],
                ),
              ),
              // MaterialButton(
              //   minWidth: 40,
              //   onPressed: () {
              //     setState(
              //       () {
              //         currentScreen = Setting();
              //         currentTab = 2;
              //       },
              //     );
              //   },
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       Icon(
              //         Icons.settings,
              //         color: currentTab == 2 ? Colors.blue : Colors.grey,
              //       ),
              //       // Text(
              //       //   'Setting',
              //       //   style: TextStyle(
              //       //     color: currentTab == 2 ? Colors.blue : Colors.grey,
              //       //   ),
              //       // ),
              //     ],
              //   ),
              // ),
            ],

            // Row(
            //   children: <Widget>[
            //     MaterialButton(
            //       minWidth: 40,
            //       onPressed: () {
            //         setState(
            //           () {
            //             currentScreen = Profile();
            //             currentTab = 2;
            //           },
            //         );
            //       },
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: <Widget>[
            //           Icon(
            //             Icons.person,
            //             color: currentTab == 2 ? Colors.blue : Colors.grey,
            //           ),
            //           Text(
            //             'Profile',
            //             style: TextStyle(
            //               color: currentTab == 2 ? Colors.blue : Colors.grey,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     MaterialButton(
            //       minWidth: 40,
            //       onPressed: () {
            //         setState(
            //           () {
            //             currentScreen = Setting();
            //             currentTab = 3;
            //           },
            //         );
            //       },
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: <Widget>[
            //           Icon(
            //             Icons.settings,
            //             color: currentTab == 3 ? Colors.blue : Colors.grey,
            //           ),
            //           Text(
            //             'Setting',
            //             style: TextStyle(
            //               color: currentTab == 3 ? Colors.blue : Colors.grey,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }
}
