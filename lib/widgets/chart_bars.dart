import 'package:flutter/material.dart';

class ChartBars extends StatelessWidget {
  final String lebal;
  final double spendingAmount;
  final double percentage;

  ChartBars(this.lebal, this.spendingAmount, this.percentage);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          return Column(
            children: [
              Container(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(
                  child: Text('₹ ${spendingAmount.toStringAsFixed(0)}'),
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              Container(
                height: constraints.maxHeight * 0.60,
                width: 10,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(220, 220, 220, 1)),
                    ),
                    FractionallySizedBox(
                      heightFactor: percentage,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              Container(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(
                  child: Text(lebal),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
