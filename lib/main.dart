import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.separated(
            controller: _controller,
            separatorBuilder: (_, __) {
              return Divider(
                color: Colors.red,
              );
            },
            itemCount: 10,
            itemBuilder: (_, index) {
              return SizedBox(
                height: 200,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is OverscrollNotification) {
                      print(scrollNotification.overscroll);
                      _controller.jumpTo(
                          _controller.offset + scrollNotification.overscroll);
                    }
                    return true;
                  },
                  child: ListView.separated(
                      separatorBuilder: (_, __) {
                        return Divider();
                      },
                      physics: ClampingScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (_, index) {
                        return ListTile(
                          title: Text('element at ${index.toString()}'),
                        );
                      }),
                ),
              );
            }),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
