import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expense_traker/widgets/chart.dart';
import './widgets/transction_list.dart';
import './widgets/new_transction.dart';

import 'model/transction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter App',
        home: MyHomePage(),
        theme: ThemeData(primarySwatch: Colors.red, fontFamily: 'OpenSans'));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transction> _userTransction = [];

  void _addNewTransction(String txTitle, double txAmount, chooseDate) {
    var neTxt = Transction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: chooseDate);
    setState(() {
      _userTransction.add(neTxt);
    });
  }

  List<Transction> get _recentTransction {
    return _userTransction.where((tx) {
      return tx.date!.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  bool _showChart = false;
  void _startAddNewTransction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransction(_addNewTransction);
        });
  }

  void _deleteTransction(String id) {
    setState(() {
      _userTransction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
      title: Text('Personal Expenser'),
      actions: [
        IconButton(
            onPressed: () => _startAddNewTransction(context),
            icon: Icon(Icons.add))
      ],
    );
    return Scaffold(
      appBar: appbar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Show Chart'),
              Switch(
                value: _showChart,
                onChanged: (val) {
                  setState(() {
                    _showChart = true;
                  });
                },
              ),
            ],
          ),_showChart ?
          Container(
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.3,
              child: Chart(_recentTransction)):
          Container(
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
              child: TransctionList(_userTransction, _deleteTransction)),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransction(context),
      ),
    );
  }
}
