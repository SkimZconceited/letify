import 'package:flutter/material.dart';

class ExploreRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 180,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            _buildCard(
                left: 18,
                image: 'assets/images/apartment2.jpg',
                caption: 'Over 3,500 apartments'),
            _buildCard(
                left: 10,
                image: 'assets/images/bedroom3.jpg',
                caption: 'Over 1,200 houses'),
          ],
        ),
      ),
    );
  }

  //build card
  Widget _buildCard(
      {@required double left,
      @required String image,
      @required String caption}) {
    return Card(
      margin: EdgeInsets.only(left: left),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        //width: 160,
        //height: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              //width: 150,
              //height: 300,
              child: Image.asset(
                image,
                width: 160,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              child: Text(caption),
              padding: EdgeInsets.only(
                top: 8,
                bottom: 8,
                left: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
