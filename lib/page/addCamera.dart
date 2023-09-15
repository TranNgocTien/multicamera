import 'package:flutter/material.dart';
import 'package:smart_camera/utils/mock_data.dart';
import './list_view.dart';

class addCamera extends StatefulWidget {
  Map<String, dynamic> mode;
  addCamera({
    required this.mode,
  });

  @override
  State<addCamera> createState() => _addCameraState();
}

class _addCameraState extends State<addCamera> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameCamera = TextEditingController();
    TextEditingController url = TextEditingController();
    Map<String, String> cameraNew = {};
    return Scaffold(
      appBar: AppBar(title: Text('Setting camera')),
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Name of camera'),
              controller: nameCamera,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Url'),
              controller: url,
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.mode['items'].add(
                    {
                      "title": '${nameCamera.text}',
                      "image": "assets/image/waiting.png",
                      "trailer_url": '${url.text}',
                    },
                  );
                  // Navigator.of(context).pop(MaterialPageRoute(
                  //     builder: (_) => new Listview(mode: widget.mode)));
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (_) => new Listview(mode: widget.mode)));
                });
                print(mockData);
              },
              child: Text(
                'Add camera',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                side: BorderSide.none,
                shape: const StadiumBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
