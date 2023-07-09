import 'package:flutter/material.dart';
import 'package:flutter_expense_traker/widgets/chart_bars.dart';
import '../model/transction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transction> recentTransction;
  Chart(this.recentTransction);

  List<Map<String, Object>> get groupedTransctionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
       var totalSum = 0.0;
      for(var i = 0; i<recentTransction.length; i++)
      {
        if(recentTransction[i].date!.day == weekDay.day && recentTransction[i].date!.month == weekDay.month &&recentTransction[i].date!.year == weekDay.year)
        {
           totalSum += recentTransction[i].amount!;
        }
        
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransctionValues.fold(0.0, (sum, item) {
      
       return sum + (item['amount']as double) ;
    });
  }

  
   
  @override
  Widget build(BuildContext context) {
    
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 6,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.spaceAround,
          children: 
            groupedTransctionValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: Column(
                  children: [
                    ChartBars(data['day'].toString(), data['amount']as double, totalSpending == 0.0 ? 0.0 :  (data['amount']as double ) / totalSpending ,)
                  ],
                ),
              );
            }).toList()
          
        ),
      ),
    );
  }
}
