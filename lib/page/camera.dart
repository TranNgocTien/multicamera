import 'package:flutter/material.dart';
//import 'package:visibility_detector/visibility_detector.dart';
// import './multi_manager/flick_multi_manager.dart';
// import './multi_manager/flick_multi_player.dart';
import '../utils/mock_data.dart';
import '../page/livestream/streamBuilder.dart';
import '../utils/smartIp_data.dart';
import 'package:cron/cron.dart';

class Camera extends StatefulWidget {
  static ValueNotifier<Map> mode = ValueNotifier({});
  static ValueNotifier<int> flag = ValueNotifier(1);
  static ValueNotifier<int> cAC = ValueNotifier(2);
  static ValueNotifier<int> count = ValueNotifier(1);
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  // resetSmartPage(id) async {
  //   if (Camera.flag.value == 2) {
  //     setState(() {
  //       print('reset id:' + id);
  //     });
  //   }
  // }
  main() {
    if (Camera.count.value != 1) {
      setState(() {
        print('reset page');
      });
    }
  }

  List items = mockData['items'];
  List itemsIp = smartIp['items'];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Camera.cAC,
      builder: (BuildContext context, int value, child) {
        return Container(
            child: ValueListenableBuilder(
          valueListenable: Camera.mode,
          builder: ((BuildContext context, Map newMode, child) {
            return GridView.count(
              crossAxisCount: value,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              scrollDirection: Axis.horizontal,

              // separatorBuilder: (context, int) => Container(
              //   height: 50,
              // ),
              // itemCount: items.length,
              // itemBuilder
              children: List<Widget>.generate(
                newMode['items'].length,
                (index) {
                  return Camera.flag.value == 1
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.1, //10
                          width: MediaQuery.of(context).size.width * 0.1, //100
                          margin: EdgeInsets.all(2),
                          color: Colors.black,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: StreamBuilderCamera(
                                url: items[index]['trailer_url'],
                              )),
                        )
                      : ValueListenableBuilder(
                          valueListenable: Camera.count,
                          builder: (BuildContext context, int value, child) {
                            return Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.1, //10
                              width: MediaQuery.of(context).size.width * 0.1,
                              margin: EdgeInsets.all(2),
                              color: Colors.black,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    itemsIp[index]['trailer_url'],
                                    fit: BoxFit.cover,
                                  )),
                            );
                          },
                        );
                },
              ),
            );
          }),
        ));
      },
    );
  }
}

// FlickMultiPlayer(
//                  ,             name: items[index]['title'],
//                               url: items[index]['trailer_url'],
//                               flickMultiManager: flickMultiManager,
//                               image: items[index]['image'],
//                             ),