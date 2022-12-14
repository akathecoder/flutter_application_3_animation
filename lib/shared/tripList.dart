import 'package:flutter/material.dart';
import 'package:flutter_application_3_animation/models/Trip.dart';
import 'package:flutter_application_3_animation/screens/details.dart';
import 'package:flutter_application_3_animation/screens/home.dart';

class TripList extends StatefulWidget {
  final ViewModes viewmode;

  const TripList({super.key, required this.viewmode});

  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  List<Trip> _tripTiles = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addTrips();
    });
  }

  void _addTrips() {
    // get data from db
    List<Trip> _trips = [
      Trip(
          title: 'Beach Paradise', price: '350', nights: '3', img: 'beach.png'),
      Trip(title: 'City Break', price: '400', nights: '5', img: 'city.png'),
      Trip(title: 'Ski Adventure', price: '750', nights: '2', img: 'ski.png'),
      Trip(title: 'Space Blast', price: '600', nights: '4', img: 'space.png'),
    ];

    Future ft = Future(() {});
    for (var trip in _trips) {
      ft = ft.then((data) {
        return Future.delayed(const Duration(milliseconds: 150), () {
          _tripTiles.add(trip);
          _listKey.currentState?.insertItem(_tripTiles.length - 1);
        });
      });
    }

    // _trips.forEach((Trip trip) {
    //   _tripTiles.add(trip);
    // });
  }

  final Animatable<Offset> _offset = Tween(
    begin: const Offset(1, 0),
    end: const Offset(0, 0),
  ).chain(CurveTween(
    curve: Curves.elasticInOut,
  ));

  Widget _buildTile({
    required Trip trip,
    required Animation<double> animation,
  }) {
    double _width = widget.viewmode == ViewModes.list ? 50 : 100;
    double height = 1;
    bool full = false;

    return SlideTransition(
      position: animation.drive(_offset),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Details(trip: trip)),
          );
        },
        contentPadding: const EdgeInsets.all(25),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: _width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Hero(
                  tag: 'location-img-${trip.img}',
                  createRectTween: (Rect? begin, Rect? end) {
                    return MaterialRectCenterArcTween(begin: begin, end: end);
                  },
                  child: Image.asset(
                    'images/${trip.img}',
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${trip.nights} nights',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[300],
                      ),
                    ),
                    Text(
                      trip.title,
                      style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
            Text('\$${trip.price}'),
          ],
        ),
        // leading: ClipRRect(
        //   borderRadius: BorderRadius.circular(8.0),
        //   child: Hero(
        //     tag: 'location-img-${trip.img}',
        //     createRectTween: (Rect? begin, Rect? end) {
        //       return MaterialRectCenterArcTween(begin: begin, end: end);
        //     },
        //     child: Image.asset(
        //       'images/${trip.img}',
        //       height: 50.0,
        //     ),
        //   ),
        // ),
        // trailing: Text('\$${trip.price}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
        key: _listKey,
        initialItemCount: _tripTiles.length,
        itemBuilder: (context, index, animation) {
          return _buildTile(
            trip: _tripTiles[index],
            animation: animation,
          );
        });
  }
}
