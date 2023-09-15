import 'package:flutter/material.dart';
import '../../utils/mock_data.dart';
import '../list_view.dart';

class IpCamera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameCamera = TextEditingController();
    TextEditingController url = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text('Setting Ip camera')),
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
              onPressed: () {},
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
