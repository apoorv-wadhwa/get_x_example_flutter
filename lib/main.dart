import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:getxstatemanagement/repository/repository.dart';
import 'package:getxstatemanagement/state/counter.dart';
import 'package:getxstatemanagement/state/user_counter.dart';

import 'state/quote_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _controller = Get.put(QuoteState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get x State Management'),
      ),
      body: Center(
        child: Center(
          child: _showQuote(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // QuotesRepository quote = QuotesRepository();
          await Get.find<QuoteState>().fetchQuote();
         // Get.find<Counter>().increment();
         // Get.find<UserCounter>().updateCount(Get.find<Counter>().counter);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _showQuote() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Center(
        child: GetX<QuoteState>(
          init: QuoteState(),
          builder: (_) {
           if(_.loading.value == true) {
             return CircularProgressIndicator();
           }
           else if(_.showError.value == true && _.errorString != null && _.errorString.isNotEmpty) {
             return Text(_.errorString.value);
           }
           else if(_.quote.value.quote != null && _.quote.value.quote.isNotEmpty) {
             return Text(_.quote.value.quote);
           }
           else {
             return Text('Get a quote');
           }
          },
        ),
      ),
    );
  }
}
