import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransction extends StatefulWidget {
  final Function addTransction;

  NewTransction(this.addTransction);

  @override
  _NewTransctionState createState() => _NewTransctionState();
}

class _NewTransctionState extends State<NewTransction> {
  final titalControler = TextEditingController();

  final amountControler = TextEditingController();
  DateTime? _selectedDate;

  void submitData() {
    final enterdTital = titalControler.text;
    final enteredAmount = double.parse(amountControler.text);

    if (enterdTital.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTransction(enterdTital, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _showDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titalControler,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountControler,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  // ignore: unnecessary_null_comparison
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No date choosed !'
                          : 'Picked Date:  ${DateFormat.yMMMd().format(_selectedDate!)}',
                    ),
                  ),
                  ElevatedButton(
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: _showDate)
                ],
              ),
            ),
            SizedBox(height: 50,),
            ElevatedButton(
                onPressed: submitData,
                child: Text(
                  'Add Transction',
                  
                ))
          ],
        ),
      ),
    );
  }
}
