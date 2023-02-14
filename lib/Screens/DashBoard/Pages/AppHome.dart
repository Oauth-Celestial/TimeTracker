import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/Screens/DashBoard/Pages/AppHome/InstalledAppCard.dart';
import 'package:timetracker/Screens/DashBoard/Pages/AppHome/TopAppCard.dart';
import 'package:timetracker/Services/Theme/ThemeManager.dart';

class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage>
    with TickerProviderStateMixin {
  PageController pageController = PageController(viewportFraction: 0.7);
  int currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String text =
        Provider.of<ThemeProvider>(context).isDarkMode ? "Dark" : "Light";
    return Scaffold(
      backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode
          ? Colors.black
          : Colors.white,
      appBar: AppBar(
        title: Container(
          child: Text(
            "Welcome",
            style: TextStyle(fontSize: 23),
          ),
        ),
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          CircleAvatar(
            radius: 46,
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8), // Border radius
              child: ClipOval(
                child: Image.asset(
                  'assets/luffy.jpg',
                  width: 46,
                  height: 46,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: ListView(
            children: [
              SizedBox(
                height: 30,
              ),
              Animate(
                effects: [
                  FadeEffect(
                      curve: Curves.easeIn, delay: Duration(milliseconds: 500))
                ],
                child: Text(
                  "Top Used Apps",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 130,
                color: Colors.transparent,
                child: PageView.builder(
                    padEnds: false,
                    pageSnapping: true,
                    controller: pageController,
                    physics: BouncingScrollPhysics(),
                    onPageChanged: (pageIndex) {
                      setState(() {
                        currentPage = pageIndex;
                      });
                    },
                    itemBuilder: ((context, index) {
                      return TweenAnimationBuilder(
                        duration: Duration(milliseconds: 350),
                        tween: Tween(begin: 0, end: 0),
                        curve: Curves.ease,
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: index == currentPage ? 1 : 0.8,
                            child: TopAppCard(),
                          );
                        },
                      );
                    })),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Installed Apps",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                    child: GridView.builder(
                  itemCount: 100,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: (2.5 / 2),
                  ),
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    return InstalledAppCard(
                      index: index,
                    ).animate().fadeIn(delay: Duration(milliseconds: 100));
                  },
                )),
              )
            ],
          ),
        ),
      )),
    );
  }
}
