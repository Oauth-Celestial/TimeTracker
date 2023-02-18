import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/Controller/InstalledAppController.dart';
import 'package:timetracker/Screens/DashBoard/Pages/AppHome/ParallaxPageView.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _controller = PageController(viewportFraction: 0.7);
  double? offset = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<InstalledAppController>(context, listen: false).getAllApps();
    _controller.addListener(() {
      setState(() {
        offset = _controller.page;
        //print(offset);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ParallaxPageView(
            controller: _controller,
            offset: offset!,
          ),
        ],
      ),
    );
  }
}
