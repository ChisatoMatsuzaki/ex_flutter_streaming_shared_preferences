import 'dart:async';

import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class MyAppSettings {
  final Preference counter;

  MyAppSettings(StreamingSharedPreferences preferences)
      : counter = preferences.getInt('counter', defaultValue: 0);
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await StreamingSharedPreferences.instance;
  final settings = MyAppSettings(preferences);

  runApp(MyApp(settings));
}

class MyApp extends StatelessWidget {
  MyApp(this.settings);

  final MyAppSettings settings;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page', settings: settings),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.settings}) : super(key: key);

  final String title;
  final MyAppSettings settings;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    final nowCounter = widget.settings.counter.getValue();
    widget.settings.counter.setValue(nowCounter + 1);
    // setState(() {
    //   _counter++;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            PreferenceBuilder<int>(
              preference: widget.settings.counter,
              builder: (BuildContext context, int counter) {
                return Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
