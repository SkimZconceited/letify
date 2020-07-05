import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:letify/models/apartment.dart';
import 'package:letify/models/house.dart';
import 'package:letify/models/review.dart';
import 'package:letify/models/user.dart';
import 'package:letify/services/blocs/homes_bloc.dart';
import 'package:letify/services/blocs/user_bloc.dart';
import 'package:letify/utils/theme.dart';

class HomeReviews extends StatefulWidget {
  final Apartment apartment;
  final House house;
  final UserBloc userBloc;
  final HomesBloc homeBloc;
  HomeReviews({this.apartment, this.house, this.userBloc, this.homeBloc});

  @override
  _HomeReviewsState createState() => _HomeReviewsState();
}

class _HomeReviewsState extends State<HomeReviews> {
  bool showMore = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, top: 15),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.star, color: letifyPink),
              Text(
                widget.apartment == null
                    ? widget.house.reviews['ratings'].toString()
                    : widget.apartment.reviews['ratings'].toString(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text(
                widget.apartment == null
                    ? ' ( ${widget.house.reviews['total'].toString()} Review(s) )'
                    : ' ( ${widget.apartment.reviews['total'].toString()} Review(s) )',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
              stream: widget.homeBloc.retrieveReviews(widget.apartment == null
                  ? widget.house.uid
                  : widget.apartment.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final reviewSnapshots = snapshot.data.documents;
                  return ListView.builder(
                      itemCount: showMore ? reviewSnapshots.length : 1,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Review review =
                            Review.fromMap(snapshot.data.documents[index].data);
                        review.documentId =
                            snapshot.data.documents[index].documentID;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder<User>(
                                future: widget.userBloc.getUser(review.userId),
                                builder: (context, futureSnapshot) {
                                  if (futureSnapshot.hasData) {
                                    return Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 2.0, top: 5),
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundImage: NetworkImage(
                                              futureSnapshot.data.dp,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                              futureSnapshot.data.username),
                                        )
                                      ],
                                    );
                                  } else
                                    return Container();
                                }),
                            Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.only(left: 50.0, right: 18),
                              child: Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                color: Colors.grey[200],
                                elevation: 2,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 5,
                                        left: 10,
                                        right: 10,
                                        bottom: 10),
                                    child: Text(review.text)),
                              ),
                            ),
                          ],
                        );
                      });
                } else
                  return Text('stream loading...');
              }),
          StreamBuilder<QuerySnapshot>(
              stream: widget.homeBloc.retrieveReviews(widget.apartment == null
                  ? widget.house.uid
                  : widget.apartment.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data.documents.length > 1
                      ? Container(
                          padding: EdgeInsets.only(top: 9, bottom: 2),
                          height: 38,
                          child: MaterialButton(
                              color: Colors.grey[100],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              elevation: 2,
                              onPressed: () {
                                setState(() {
                                  showMore = !showMore;
                                });
                              },
                              child: Text(
                                !showMore ? 'Show more' : 'Show less',
                                style: TextStyle(fontWeight: FontWeight.w300),
                              )),
                        )
                      : Container();
                } else
                  return Container();
              }),
        ],
      ),
    );
  }
}
