import 'package:desktop_vendorapp/localization/language/languages.dart';
import 'package:desktop_vendorapp/providers/order_provider.dart';
import 'package:desktop_vendorapp/providers/product_provider.dart';
import 'package:desktop_vendorapp/screens/home_screen.dart';
import 'package:desktop_vendorapp/widgets/charts_file.dart';
import 'package:desktop_vendorapp/widgets/drawer_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class MainScreen extends StatefulWidget {

  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  String ?title;
  List<charts.Series<Task,String>> seriesPieData=[];
  _generateData(){
    var pieData = [
      Task('ActiveOrders', 30, Colors.orange),
     Task("acceptedOrders", 30 , Colors.indigo),
      Task("delivredOrders", 30, Colors.blue),
      Task("refusedOrdes",10,Colors.redAccent),
    ];
    seriesPieData.add(
      charts.Series(
        data:pieData,
        domainFn: (Task task,_)=>task.taskName,
        measureFn: (Task task,_)=>task.taskValue,
        id: 'Orders',
        labelAccessorFn: (Task row,_)=> '${row.taskValue}',
      )
    );
  }

  @override
  void initState() {
   _generateData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var _provider=Provider.of<ProductProvider>(context);
    var _order=Provider.of<OrderProvider>(context);
    _order.getorders();
    _order.getacceptedorders();
    _order.getDelivredOrders();
    _provider.getTotalUsers();
    return Scaffold(
      body: ListView(
        children: [
          SafeArea(child:
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 15),
               child: Column(
                 children: [
                   Row(

                    children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        height: 150,
                        width: 150,
                        child: Card(
                          color: Colors.redAccent,
                          elevation: 4,
                          shadowColor: Colors.black,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                                child: Text(Languages.of(context)!.numberOfUsers,
                                  style: TextStyle(
                                      fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                      'Cairo' : 'Nunito',
                                    fontSize: 18
                                ),
                                ),
                              ),
                              Text(_provider.numberOfUsers.toString(),
                                style: TextStyle(
                                fontSize: 22
                              ),)
                            ],
                          ),
                        )
                      ),
                    ),
                      const SizedBox(width: 20,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            height: 150,
                            width: 150,
                            child: Card(
                              color: Colors.green,
                              elevation: 4,
                              shadowColor: Colors.black,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                                    child: Text(Languages.of(context)!.numberOfOrders,
                                      style: TextStyle(
                                          fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                          'Cairo' : 'Nunito',
                                          fontSize: 18
                                    ),

                                    ),
                                  ),
                                  Text(_order.totalOrders.toString(),style: TextStyle(
                                      fontSize: 22
                                  ),)
                                ],
                              ),
                            )
                        ),
                      ),
            ],
          ),
                   Row(
                     children: [
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Container(
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(30),
                             ),
                             height: 150,
                             width: 150,
                             child: Card(
                               color: Colors.indigoAccent,
                               elevation: 4,
                               shadowColor: Colors.black,
                               child: Column(
                                 children: [
                                   Padding(
                                     padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                                     child: Text(Languages.of(context)!.acceptedOrder
                                       ,style: TextStyle(
                                           fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                           'Cairo' : 'Nunito',
                                           fontSize: 18
                                     ),
                                     ),
                                   ),
                                   Text(_order.accptedOrders.toString(),style: TextStyle(
                                       fontSize: 22
                                   ),)
                                 ],
                               ),
                             )
                         ),
                       ),
                       SizedBox(width: 20,),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Container(
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(30),
                             ),
                             height: 150,
                             width: 150,
                             child: Card(
                               color: Colors.orange,
                               elevation: 4,
                               shadowColor: Colors.black,
                               child: Column(
                                 children: [
                                   Padding(
                                     padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                                     child: Text(Languages.of(context)!.delivredOrders,
                                       style: TextStyle(
                                           fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                           'Cairo' : 'Nunito',
                                           fontSize: 18
                                     ),
                                     ),
                                   ),
                                   Text(_order.deliveredOrders.toString(),style: TextStyle(
                                       fontSize: 22
                                   ),)
                                 ],
                               ),
                             )
                         ),
                       ),
                     ],
                   ),

                 ],
               ),
             )


          ),
        ],
      ),
    );
  }

}
 class Task{
  String taskName;
  double ?taskValue;
  Color  ?valueColor;
  Task(this.taskName,this.taskValue,this.valueColor);

}

