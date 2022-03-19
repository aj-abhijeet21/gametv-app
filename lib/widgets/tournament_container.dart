import 'package:flutter/material.dart';

class TournamentContainer extends StatelessWidget {
  Color begin;
  Color end;
  String number;
  String description;
  bool? isLeft;
  bool? isRight;

  TournamentContainer({
    required this.begin,
    required this.description,
    required this.end,
    required this.number,
    this.isLeft = false,
    this.isRight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$number',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [begin, end],
          begin: Alignment.bottomLeft,
          end: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.only(
          topLeft: isLeft! ? Radius.circular(20) : Radius.zero,
          bottomLeft: isLeft! ? Radius.circular(20) : Radius.zero,
          topRight: isRight! ? Radius.circular(20) : Radius.zero,
          bottomRight: isRight! ? Radius.circular(20) : Radius.zero,
        ),
      ),
    );
  }
}
