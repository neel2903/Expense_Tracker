import 'dart:ffi';

import 'package:flutter/material.dart';
import '../model/transction.dart';
import 'package:intl/intl.dart';

class TransctionList extends StatelessWidget {
  
  final List<Transction> transction ;
  final Function deleteTransction;
  TransctionList(this.transction,this.deleteTransction);
 
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: transction.isEmpty ? Container(child: Center(child: Text('No Transctions :)',style: TextStyle(fontWeight: FontWeight.bold,
      fontSize: 24),),),) : ListView.builder(
        itemBuilder: (ctx,index){
          return Card(
            
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
            child:ListTile(
              leading: CircleAvatar(radius:40,child:Padding(
                padding: const EdgeInsets.all(10),
                child: FittedBox(
                  child: Text(
                        '₹${transction[index].amount!.toStringAsFixed(2)}',),
                ),
              ),),
              title:Text(transction[index].title.toString(),) ,
              subtitle: Text(
                      DateFormat.yMMMd().format(transction[index].date!),),
              trailing:IconButton(icon: Icon(Icons.delete),onPressed: () => deleteTransction(transction[index].id),) ,
            ),
          );

        },
        itemCount:transction.length ,
        
      ),
    );
  }
}
