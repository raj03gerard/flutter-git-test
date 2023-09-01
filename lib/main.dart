import 'package:flutter/material.dart';
import 'package:postgres_api/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ApiData.dart';
import 'storeData.dart';
import 'storeData_firebase.dart';

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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    String playerName = "a";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
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
            FilledButton(
                onPressed: () async {
                  QuerySnapshot playerRef = await FirebaseFirestore.instance
                      .collection('players')
                      .where('name', isEqualTo: 'Gary Trent Jr.')
                      // .where('name', isLessThanOrEqualTo: 'a+ \uf8ff')
                      .get();

                  playerRef.docs.forEach((playerDoc) {
                    DocumentReference teamRef =
                        playerDoc['team'] as DocumentReference;
                    teamRef.get().then((teamData) {
                      print(teamData['name']);
                    });
                  });

                  // print(playerRef.docs[0]['team']);
                  // teamRef.get().then((value) {
                  //   print("${value['name']} ${value['tid']}");
                  // });
                },
                child: Text("Get player")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _incrementCounter();
          await ApiData().getAPIData();
          getPlayer("Billy Preston");
          // await StoreData.saveData();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
