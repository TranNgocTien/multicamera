import 'package:flutter/material.dart';

class ImagePicker extends StatefulWidget {
  const ImagePicker({Key? key}) : super(key: key);

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick an image'),
      ),
      body: Column(children: <Widget>[
        SizedBox(
          height: 40,
        ),
        Image.network('https://picsum.photos/250?image=9'),
        SizedBox(
          height: 40,
        ),
        CustomButton(
            title: 'Pick from galery',
            icon: Icons.image_outlined,
            onClick: () => {}),
        CustomButton(
            title: 'Pick from camera', icon: Icons.camera, onClick: () => {}),
      ]),
    );
  }
}

Widget CustomButton({
  required String title,
  required IconData icon,
  required VoidCallback onClick,
}) {
  return Container(
      width: 280,
      child: ElevatedButton(
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 20),
            Text(title),
          ],
        ),
        onPressed: onClick,
      ));
}
