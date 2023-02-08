import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/Controller/InstalledAppController.dart';
import 'package:timetracker/Model/InstalledAppModel.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Database entry"),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(child:
          Consumer<InstalledAppController>(builder: ((context, value, child) {
        List<appData> data = value.data;
        return ListView.builder(
            itemCount: data.length,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white,
                  height: 100,
                  child: Column(
                    children: [
                      Text(
                        "Package Name :- ${data[index].packageName}",
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Duration :- ${data[index].duration}",
                          style: TextStyle(color: Colors.black)),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Updated On :- ${data[index].updatedOn}",
                          style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              );
            }));
      }))),
    );
  }
}
