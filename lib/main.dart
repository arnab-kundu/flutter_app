import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'InteractiveImage.dart';
import 'dart:developer'; //import for log
import 'package:flutter_svg/flutter_svg.dart'; //import for svg
//import 'package:platform/platform.dart';// don't know the use yet
import 'dart:convert' as convert; // For Json parse
import 'package:http/http.dart' as http; // For API CALL
import 'package:fluttertoast/fluttertoast.dart'; // For Toast
import 'package:css_colors/css_colors.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      //debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: 'Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String et = "";

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      print('$_counter');
      log('data: $_counter');
      //ButtonActivity()
    });
  }

  //////////////////
  // API CALL
  //////////////////
  void apiCall(List<String> arguments) async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = "https://www.googleapis.com/books/v1/volumes?q={http}";

    // Await the http get response, then decode the json-formatted responce.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var itemCount = jsonResponse['totalItems'];
      print("Number of books about http: $itemCount.");
      toast("Number of books about http: $itemCount.");
    } else {
      print("Request failed with status: ${response.statusCode}.");
      toast("Request failed with status: ${response.statusCode}.");
    }
  }


  //////////////////
  // TOAST
  //////////////////
  void toast(String toastMsg) {
    Fluttertoast.showToast(
        msg: toastMsg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }


  //////////////////
  // LIST VIEW
  //////////////////
  Widget _myListView(BuildContext context) {
    // backing data
    final europeanCountries = ['Albania', 'Andorra', 'Armenia', 'Austria',
      'Azerbaijan', 'Belarus', 'Belgium', 'Bosnia and Herzegovina', 'Bulgaria',
      'Croatia', 'Cyprus', 'Czech Republic', 'Denmark', 'Estonia', 'Finland',
      'France', 'Georgia', 'Germany', 'Greece', 'Hungary', 'Iceland', 'Ireland',
      'Italy', 'Kazakhstan', 'Kosovo', 'Latvia', 'Liechtenstein', 'Lithuania',
      'Luxembourg', 'Macedonia', 'Malta', 'Moldova', 'Monaco', 'Montenegro',
      'Netherlands', 'Norway', 'Poland', 'Portugal', 'Romania', 'Russia',
      'San Marino', 'Serbia', 'Slovakia', 'Slovenia', 'Spain', 'Sweden',
      'Switzerland', 'Turkey', 'Ukraine', 'United Kingdom', 'Vatican City'];

    return ListView.builder(
      itemCount: europeanCountries.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(europeanCountries[index]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times: $et',
              style: TextStyle(fontWeight: FontWeight.bold,color: CSSColors.orange.withOpacity(0.6),fontFamily: 'Pacifico-Regular'),
            ),
            GradientText(
              'Hello',
              shaderRect: Rect.fromLTWH(0.0, 0.0, 50.0, 50.0),
              gradient: Gradients.hotLinear,
              style: TextStyle(fontSize: 40.0,),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            FlatButton.icon(
              color: Colors.red,
              icon: Icon(Icons.wifi), //`Icon` to display
              label: Text('Call API'), //`Text` to display
              onPressed: () {
                //Code to execute when Floating Action Button is clicked
                //...
                apiCall(null);
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(36.0, 0, 36.0, 0),
              child: TextField(
                onChanged: (text) {
                  setState(() async {
                    et = text;
                    if (Theme.of(context).platform == TargetPlatform.android) {
                      AndroidIntent intent = AndroidIntent(
                        action: 'action_view',
                        data: 'https://play.google.com/store/apps/details?'
                            'id=com.google.android.apps.myapp',
                        arguments: {'authAccount': 'currentUserEmail'},
                      );
                      await intent.launch();
                    }
                  });
                },
              ),
            ),
            InteractiveImage(Image.asset('images/screenshot.png')),
            //Image.asset('images/screenshot.png'),
            SizedBox.fromSize(
              child: SvgPicture.asset(
                'images/ai_file.svg',
              ),
              size: Size(30.0, 40.0),
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
