import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  String username;
  String rating;
  String percentage;
  String imgUrl;

  UserProfile({
    required this.imgUrl,
    required this.percentage,
    required this.rating,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 50,
          foregroundImage: NetworkImage(imgUrl),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              username,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.blue,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.fromLTRB(10, 10, 30, 10),
              child: Row(
                children: [
                  Text(
                    rating,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Elo Rating',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
