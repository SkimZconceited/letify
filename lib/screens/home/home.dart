import 'package:flutter/material.dart';
import 'package:letify/screens/home/beach_row.dart';
import 'package:letify/screens/home/city_row.dart';
import 'package:letify/screens/home/explore_row.dart';
import 'package:letify/screens/home/more_row.dart';
import 'package:letify/screens/home/trendy_row.dart';
import 'package:letify/utils/theme.dart';
import 'drawer.dart';
import 'bottom_nav.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //bottom navigation barindex
  int _currentIndex = 0;
  //favorite icon
  final Widget favoriteIcon = Positioned(
    right: 20,
    top: 4,
    child: IconButton(
      icon: Icon(
        Icons.favorite,
        color: letifyPink,
      ),
      onPressed: null,
    ),
  );
  final Widget numberOfFavorites = Container(
    padding: EdgeInsets.only(top: 10, right: 20),
    child: Text(
      '2',
      style: TextStyle(
        color: letifyPink,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: letifyGreen),
        title: Text(
          'LETIFY',
          style: TextStyle(
            color: letifyGreen,
          ),
        ),
        actions: [
          Stack(
            overflow: Overflow.visible,
            children: [
              //favorite icon
              favoriteIcon,
              numberOfFavorites,
            ],
          ),
        ],
      ),
      body: _buildCustomScrollView(),
      drawer: Drawer(
        child: LetifyDrawer(),
      ),
      bottomNavigationBar: LetifyBottomNavBar(
        newContext: context,
        currentIndex: _currentIndex,
      ),
    );
  }

  //custom scroll view
  Widget _buildCustomScrollView() {
    return CustomScrollView(
      slivers: [
        //explore column
        _buildColumn(),
        //explore cards
        ExploreRow(),
        //trendy homes
        _buildRow('Trendy homes just for you'),
        //trendy vids
        TrendyRow(),
        //near the beach
        _buildRow('Near the beach'),
        //near the beach vids
        //BeachRow(),
        //city homes
        //_buildRow('City homes'),
        //city vids
        //CityRow(),
        //more
       // _buildRow('More'),
        //more vids
       // MoreRow(),
      ],
    );
  }

  //build column
  Widget _buildColumn() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 20, bottom: 5),
            child:
                Text('Explore', style: Theme.of(context).textTheme.headline6),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 12),
            child: Text(
              'Lets help you find your dream home',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ],
      ),
    );
  }

  //row
  Widget _buildRow(String text) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(
          left: 18,
          top: 18,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Text(text, style: Theme.of(context).textTheme.subtitle2),
            ),
            Expanded(
                flex: 2,
                child: FlatButton(onPressed: null, child: Text('view all'))),
            Expanded(
              flex: 1,
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: letifyGreen,
                    size: 14,
                  ),
                  onPressed: null),
            ),
          ],
        ),
      ),
    );
  }
}
