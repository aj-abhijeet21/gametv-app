import 'package:flutter/material.dart';
import 'package:gametv_app/models/tournament.dart';
import 'package:gametv_app/models/user.dart';
import 'package:gametv_app/screens/login.dart';
import 'package:gametv_app/services/api_service.dart';
import 'package:gametv_app/services/app_state.dart';
import 'package:gametv_app/widgets/tournament_card.dart';
import 'package:gametv_app/widgets/tournament_container.dart';
import 'package:gametv_app/widgets/user_profile.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    String username =
        Provider.of<AppStateProvider>(context, listen: false).user;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Flyingwolf',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text(
                'GameTV app',
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/logo.jpg'),
                ),
              ),
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                Provider.of<AppStateProvider>(context, listen: false)
                    .logoutUser();
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<UserDetails>(
                  future: ApiService().getUserDetails(username),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                        // child: Text('Something happened'),
                      );
                    } else {
                      return Column(
                        children: [
                          UserProfile(
                            username: snapshot.data!.name,
                            imgUrl: snapshot.data!.imgUrl,
                            percentage: snapshot.data!.percentage,
                            rating: snapshot.data!.rating,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 90,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TournamentContainer(
                                    begin: const Color(0xFFE47901),
                                    end: const Color(0xFFECA500),
                                    description: 'Tournaments Played',
                                    number: snapshot.data!.played,
                                    isLeft: true,
                                  ),
                                ),
                                Expanded(
                                  child: TournamentContainer(
                                    begin: const Color(0xFF442497),
                                    end: const Color(0xFFA454BD),
                                    description: 'Tournaments Won',
                                    number: snapshot.data!.won,
                                  ),
                                ),
                                Expanded(
                                  child: TournamentContainer(
                                    begin: const Color(0xFFEC5344),
                                    end: const Color(0xFFEF7D4F),
                                    description: 'Winning Percentage',
                                    number: snapshot.data!.percentage,
                                    isRight: true,
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Recommended for you',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder<List<Tournament>>(
                  future: ApiService().getTournaments(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Something happened'),
                      );
                    } else {
                      return ListView.separated(
                        separatorBuilder: ((context, index) {
                          return const SizedBox(
                            height: 20,
                          );
                        }),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return TournamentCard(
                            name: snapshot.data![index].name,
                            description: snapshot.data![index].name,
                            imgUrl: snapshot.data![index].imgUrl,
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
