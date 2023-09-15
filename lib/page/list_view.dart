import 'package:flutter/material.dart';
import './addCamera.dart';
import './home.dart';

class Listview extends StatefulWidget {
  Map<String, dynamic> mode;
  Listview({
    required this.mode,
  });
  @override
  State<Listview> createState() => _ListviewState();
}

class _ListviewState extends State<Listview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings camera'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context)
              .push(new MaterialPageRoute(builder: (_) => Home())),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => addCamera(
                            mode: widget.mode,
                          )),
                );
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: widget.mode['items'].length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 100,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(widget.mode['items'][index]['title']),
                        SizedBox(height: 10),
                        Text(
                          widget.mode['items'][index]['trailer_url'],
                          overflow: TextOverflow.fade,
                          maxLines: 2,
                          softWrap: false,
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          widget.mode['items']
                              .remove(widget.mode['items'][index]);
                        });
                        // mockData['items'].remove((element) {
                        //   return element[index] == mockData['items'][index];
                        // });
                        // setState(() {});
                        print(widget.mode);
                      },
                      child: Icon(
                        Icons.remove_circle_outline_outlined,
                      ),
                      style:
                          ElevatedButton.styleFrom(primary: Colors.redAccent),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                  height: 1,
                  thickness: 1,
                  indent: 1,
                  endIndent: 1,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
