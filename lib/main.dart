// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

import 'dart:async';
import 'dart:convert' as convert;
import 'dart:typed_data';

import 'package:animations/animations.dart';
import 'package:async/async.dart' hide Result;
import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:characters/characters.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_icons/flutter_icons.dart';
// import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy/data/result.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_multi_platform_package_test/web/index.dart';

const String hi = 'Hi ⏰';

Future<void> main() async {
  // This example uses the Google Books API to search for books about http.
  // https://developers.google.com/books/docs/overview

  const String url = 'https://www.googleapis.com/books/v1/volumes?q={http}';
  setPathUrlStrategy();

  // Await the http get response, then decode the json-formatted response.

  final http.Response response = await http.get(url);
  if (response.statusCode == 200) {
    final dynamic jsonResponse = convert.jsonDecode(response.body);
    final dynamic itemCount = jsonResponse['totalItems'];
    print('Number of books about http: $itemCount.');
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotlyt Web Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        textTheme: const TextTheme(
          bodyText1: const TextStyle(
            fontFamilyFallback: const <String>[
              'Emoji',
            ],
          ),
        ),
      ),
      home: const MyHomePage(
        title: 'Spotlyt Web Demo Home Page',
      ),
    );
  }
}

class MyHomePage extends HookWidget {
  const MyHomePage({
    Key? key,
    this.title = 'Title',
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final GetIt getIt = GetIt.instance;
    print(getIt.hashCode);
    final ValueNotifier<int> count = useState<int>(0);
    final RestartableTimer timer = RestartableTimer(
      const Duration(
        seconds: 5,
      ),
      () {
        print('Time out!');
      },
    );
    // final ValueNotifier<int> timeTick = useState<int>(0);
    int timeTick = timer.tick;
    final ValueNotifier<Timer> everySecond = useValueNotifier<Timer>(
      Timer.periodic(
        const Duration(seconds: 1),
        (
          Timer everySecondTimer,
        ) {
          timeTick = timer.tick;
          // timeTick.value = timer.tick;
        },
      ),
    );
    print(everySecond.value.tick);
    // final List<String> images = <String>[
    //   'https://firebasestorage.googleapis.com/v0/b/spotlyt-dev.appspot.com/o/logo_1000x1000.png?alt=media&token=f8881b6e-8178-458b-a0f5-bbf83913daec',
    //   'https://firebasestorage.googleapis.com/v0/b/spotlyt-dev.appspot.com/o/logo_1000x1000.png?alt=media&token=f8881b6e-8178-458b-a0f5-bbf83913daec',
    //   'https://firebasestorage.googleapis.com/v0/b/spotlyt-dev.appspot.com/o/logo_1000x1000.png?alt=media&token=f8881b6e-8178-458b-a0f5-bbf83913daec',
    // ];
    final Fuzzy<String> fuse = Fuzzy<String>(
      <String>[
        'apple',
        'banana',
        'orange',
      ],
    );

    final List<Result<String>> results = fuse.search('ran');

    results.map((Result<String> r) => r.matches.first.value).forEach(print);
    return Scaffold(
      appBar: AppBar(
        title: SelectableText(title),
      ),
      // body: Swiper(
      //   itemBuilder: (BuildContext context, int index) {
      //     return FadeInImage.memoryNetwork(
      //       image: images[index],
      //       placeholder: kTransparentImage,
      //       fit: BoxFit.fill,
      //       imageErrorBuilder: (
      //         BuildContext context,
      //         Object url,
      //         StackTrace? error,
      //       ) =>
      //           const Icon(
      //         Icons.error,
      //       ),
      //     );
      //   },
      //   indicatorLayout: PageIndicatorLayout.COLOR,
      //   autoplay: true,
      //   itemCount: images.length,
      //   layout: SwiperLayout.STACK,
      //   pagination: const SwiperPagination(),
      //   control: const SwiperControl(),
      //   containerHeight: 500,
      //   itemHeight: 400,
      //   containerWidth: 500,
      //   itemWidth: 400,
      // ),
      body: Center(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SelectableText(
                  'You have pushed the button this many times:',
                  onTap: () {
                    showModal<void>(
                      context: context,
                      useRootNavigator: true,
                      configuration: const FadeScaleTransitionConfiguration(
                        barrierColor: Colors.purpleAccent,
                        barrierLabel: 'Woo!',
                        barrierDismissible: true,
                        transitionDuration: const Duration(
                          milliseconds: 250,
                        ),
                        reverseTransitionDuration: const Duration(
                          milliseconds: 500,
                        ),
                      ),
                      builder: (BuildContext context) {
                        return Card(
                          child: RaisedButton(
                            onPressed: timer.reset,
                          ),
                        );
                      },
                    );
                  },
                ),
                SelectableText(
                  'String is "$hi"\nCharacters.length: ${hi.characters.length}\nThe last character: ${hi.characters.last}\nSkipping last character: ${hi.characters.skipLast(1)}\n',
                  style: (Theme.of(context).textTheme.headline4 ??
                          const TextStyle())
                      .copyWith(
                    fontFamilyFallback: const <String>[
                      'Emoji',
                    ],
                  ),
                ),
                SelectableText(
                  '${count.value}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SelectableText(
                  'Timer: $timeTick',
                  // 'Timer: ${timeTick.value}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                CarouselSlider(
                  options: CarouselOptions(),
                  items: <int>[1, 2, 3, 4, 5]
                      .map(
                        (int item) => OpenContainer<int>(
                          openBuilder: (
                            BuildContext context,
                            void Function({int returnValue}) close,
                          ) {
                            return Material(
                              color: Colors.red,
                              child: InkWell(
                                onTap: close,
                                child: Center(
                                  child: Text(
                                    item.toString(),
                                  ),
                                ),
                              ),
                            );
                          },
                          closedBuilder: (
                            BuildContext context,
                            VoidCallback open,
                          ) {
                            return Material(
                              color: Colors.green,
                              child: InkWell(
                                onTap: open,
                                child: Center(
                                  child: Text(
                                    item.toString(),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                      .toList(),
                ),
                Badge(
                  badgeContent: const Text('3'),
                  child: FadeInImage.memoryNetwork(
                    image:
                        'https://firebasestorage.googleapis.com/v0/b/spotlyt-dev.appspot.com/o/logo_1000x1000.png?alt=media&token=f8881b6e-8178-458b-a0f5-bbf83913daec',
                    placeholder: kTransparentImage,
                    imageErrorBuilder: (
                      BuildContext context,
                      Object url,
                      StackTrace? error,
                    ) =>
                        const Icon(
                      Icons.error,
                    ),
                  ),
                ),
                const Icon(
                  AntDesign.stepforward,
                  size: 100,
                ),
                const Icon(
                  Ionicons.ios_search,
                  size: 100,
                ),
                const Icon(
                  FontAwesome.glass,
                  size: 100,
                ),
                const Icon(
                  MaterialIcons.ac_unit,
                  size: 100,
                ),
                const Icon(
                  FontAwesome5.address_book,
                  size: 100,
                ),
                const Icon(
                  FontAwesome5Solid.address_book,
                  size: 100,
                ),
                const Icon(
                  FontAwesome5Brands.$500px,
                  size: 100,
                ),
                Slidable(
                  actionPane: const SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  actions: <Widget>[
                    IconSlideAction(
                      caption: 'Archive',
                      color: Colors.blue,
                      icon: Icons.archive,
                      onTap: () => print('Archive'),
                    ),
                    IconSlideAction(
                      caption: 'Share',
                      color: Colors.indigo,
                      icon: Icons.share,
                      onTap: () => print('Share'),
                    ),
                  ],
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'More',
                      color: Colors.black45,
                      icon: Icons.more_horiz,
                      onTap: () => print('More'),
                    ),
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () => print('Delete'),
                    ),
                  ],
                  child: Container(
                    color: Colors.white,
                    child: const ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.indigoAccent,
                        foregroundColor: Colors.white,
                        child: Text('3'),
                      ),
                      title: Text('Tile n°3'),
                      subtitle: Text('SlidableDrawerDelegate'),
                    ),
                  ),
                ),
                TypeAheadField<String>(
                  textFieldConfiguration: TextFieldConfiguration<String>(
                    autofocus: true,
                    style: DefaultTextStyle.of(
                      context,
                    ).style.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                    decoration: const InputDecoration(
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  suggestionsCallback: (String pattern) async {
                    return <String>[pattern];
                  },
                  itemBuilder: (BuildContext context, String suggestion) {
                    return ListTile(
                      leading: const Icon(Icons.shopping_cart),
                      title: Text(suggestion),
                      subtitle: const Text('omg'),
                    );
                  },
                  onSuggestionSelected: (String suggestion) {
                    Navigator.of(context).push<void>(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => Text(
                          suggestion,
                        ),
                      ),
                    );
                  },
                ),
                const SpinKitRotatingCircle(
                  color: Colors.white,
                  size: 50,
                ),
                SpinKitFadingCircle(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: index.isEven ? Colors.red : Colors.green,
                      ),
                    );
                  },
                ),
                const SpinKitSquareCircle(
                  color: Colors.white,
                  size: 50,
                ),
                const SizedBox(
                  height: 50,
                ),
                SvgPicture.asset(
                  'firefox.svg',
                  fit: BoxFit.cover,
                  height: 200,
                  semanticsLabel: 'Firefox Logo',
                  width: 200,
                ),
                SvgPicture.network(
                  'https://firebasestorage.googleapis.com/v0/b/spotlyt-dev.appspot.com/o/firefox-logo.svg?alt=media&token=37cf98b7-3ce5-4f70-b117-552df1c366a5',
                  fit: BoxFit.cover,
                  height: 200,
                  semanticsLabel: 'Firefox Logo',
                  width: 200,
                ),
                // Swiper(
                //   itemBuilder: (BuildContext context, int index) {
                //     return FadeInImage.memoryNetwork(
                //       image: images[index],
                //       placeholder: kTransparentImage,
                //       fit: BoxFit.fill,
                //       imageErrorBuilder: (
                //         BuildContext context,
                //         Object url,
                //         StackTrace? error,
                //       ) =>
                //           const Icon(
                //         Icons.error,
                //       ),
                //     );
                //   },
                //   indicatorLayout: PageIndicatorLayout.COLOR,
                //   autoplay: true,
                //   itemCount: images.length,
                //   pagination: const SwiperPagination(),
                //   control: const SwiperControl(),
                //   containerHeight: 500,
                //   itemHeight: 400,
                // ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => count.value++,
        tooltip: 'Increment',
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

final Uint8List kTransparentImage = Uint8List.fromList(
  <int>[
    0x89,
    0x50,
    0x4E,
    0x47,
    0x0D,
    0x0A,
    0x1A,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x48,
    0x44,
    0x52,
    0x00,
    0x00,
    0x00,
    0x01,
    0x00,
    0x00,
    0x00,
    0x01,
    0x08,
    0x06,
    0x00,
    0x00,
    0x00,
    0x1F,
    0x15,
    0xC4,
    0x89,
    0x00,
    0x00,
    0x00,
    0x0A,
    0x49,
    0x44,
    0x41,
    0x54,
    0x78,
    0x9C,
    0x63,
    0x00,
    0x01,
    0x00,
    0x00,
    0x05,
    0x00,
    0x01,
    0x0D,
    0x0A,
    0x2D,
    0xB4,
    0x00,
    0x00,
    0x00,
    0x00,
    0x49,
    0x45,
    0x4E,
    0x44,
    0xAE,
  ],
);
