import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postgres_api/blocs/playerBloc.dart';
import 'package:postgres_api/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:postgres_api/weirdBloc/states/playerStates.dart';
import 'ApiData.dart';
import 'storeData.dart';
import 'storeData_firebase.dart';
import 'dataOperations/getAllPlayers.dart';
import 'package:postgres_api/MyBlocs/myPlayerBloc.dart';
import 'weirdBloc/blocs/playerBloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter w provider',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late PlayersBloc playersBloc;
  PlayerBloc playerBloc = PlayerBloc();
  MyPlayerBloc myPlayerBloc = MyPlayerBloc();
  void _incrementCounter() {
    // myPlayerBloc.fetchPlayer("Boston Celtics");
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    playersBloc = PlayersBloc();
    super.initState();
    playerBloc.eventSink.add(PlayerEvents.Fetch);
  }

  @override
  void dispose() {
    playersBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                BlocProvider(
                  create: (BuildContext context) {
                    return playersBloc;
                  },
                  child: BlocBuilder<PlayersBloc, PlayerState>(
                    builder: (context, state) {
                      return StreamBuilder<QuerySnapshot>(
                        stream: playersBloc.,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(); // Return a loading indicator while data is being fetched.
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData ||
                              snapshot.data == null) {
                            return Text('No data available');
                          }

                          // DocumentReference sp = snapshot.data! as DocumentReference;
                          // var playerData=  sp.get();
                          // if (sp.docs.isEmpty) {
                          //   return Text('No players found');
                          // }
                          return Expanded(
                            child: Container(
                              height: 500,
                              child: ListView.builder(
                                  itemCount: snapshot.data?.docs.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Text(snapshot.data!.docs[index]['name']
                                            .toString()),
                                        Expanded(
                                          child: Text(snapshot
                                              .data!.docs[index]['team']
                                              .toString()),
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                          );

                          // Provide a default value if 'name' is not available.
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _incrementCounter();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
