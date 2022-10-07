import 'package:flutter/material.dart';
import 'package:flutter_application_3_animation/shared/screenTitle.dart';
import 'package:flutter_application_3_animation/shared/tripList.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

enum ViewModes {
  list,
  grid,
}

class _HomeState extends State<Home> {
  ViewModes _viewMode = ViewModes.list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/bg.png"),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topLeft),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const SizedBox(
              height: 160,
              child: ScreenTitle(text: 'Ninja Trips'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      _viewMode == ViewModes.grid
                          ? Icons.grid_view_rounded
                          : Icons.view_list_rounded,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_viewMode == ViewModes.grid) {
                          _viewMode = ViewModes.list;
                        } else {
                          _viewMode = ViewModes.grid;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Flexible(
              child: TripList(viewmode: _viewMode),
            )
            //Sandbox(),
          ],
        ),
      ),
    );
  }
}
