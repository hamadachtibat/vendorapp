import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desktop_vendorapp/localization/language/languages.dart';
import 'package:desktop_vendorapp/providers/auth_provider.dart';
import 'package:desktop_vendorapp/providers/order_provider.dart';
import 'package:desktop_vendorapp/services/fcm/notification_payload_notification.dart';
import 'package:desktop_vendorapp/services/fcm/send_notification.dart';
import 'package:desktop_vendorapp/services/firebase_services.dart';
import 'package:desktop_vendorapp/services/order_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final OrderServices _order = OrderServices();
  final FireBaseServices _services = FireBaseServices();

  int tag = 0;
  List<String> options = [
    'ordered',
    'Accepted',
    'Rejected',
    'Delivered',
  ];
  @override
  Widget build(BuildContext context) {
    var _orderProvider=Provider.of<OrderProvider>(context);
    return  Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(Languages.of(context)!.myOrders,style:TextStyle(
            color: Colors.black,fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
        'Cairo' : 'Nunito'
        ),),
        centerTitle: true,
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: _order.orders.where('seller.sellerId',
              isEqualTo: _services.user!.uid).
          where('orderStatus', isEqualTo: _orderProvider.status).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(),);
            }
            if(!snapshot.hasData){
              return Center(child: const Text("no Orders Yet"),);
            }

            return Column(
              children: [
                Container(
                    height: 56,
                    width: MediaQuery.of(context).size.width,
                    child: ChipsChoice<int>.single(
                      value: tag,
                      onChanged: (val) => setState((){

                        _orderProvider.filterOrder(options[val]);
                        tag=val;
                      }),
                      choiceItems: C2Choice.listFrom<int, String>(
                        source: options,
                        value: (i, v) => i,
                        label: (i, v) => v,
                      ),
                    )
                ),
                Expanded(

                  child: ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      return Container(
                        color: Colors.white,
                        child: Column(
                          children:  [
                            ListTile(
                              horizontalTitleGap: 0,
                              leading: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 40,
                                child: Icon(CupertinoIcons.square_list),
                              ),
                              title:  Text((document.data() as dynamic)['orderStatus'],
                                style: (document.data() as dynamic)['orderStatus']=='Rejected'?
                                TextStyle(color: Colors.red) :(document.data() as dynamic)['orderStatus']=='Accepted'?
                                TextStyle(color: Colors.green)
                                    :TextStyle(color: Colors.orangeAccent),),
                              subtitle: Text("on ${DateFormat.yMMMd().format
                                (DateTime.parse((document.data() as dynamic)['TimeStamp']))}"),
                              trailing: Text("Amount : "
                                  "${((document.data() as dynamic)['total'].toString())} R.O"),
                            ),
                            ExpansionTile(
                              title:  Text(Languages.of(context)!.details,

                                style: TextStyle(
                                    color: Colors.black,fontFamily: Localizations.localeOf(context).languageCode == 'ar'?
                                'Cairo' : 'Nunito',fontSize: 12,
                                ),),
                              subtitle: const Text("view Order details",style:
                              TextStyle(fontSize: 12,color: Colors.grey),),
                              children: [
                                ListView.builder(
                                    itemCount:(document.data() as dynamic)['employers'].length,
                                    shrinkWrap: true,

                                    itemBuilder: (BuildContext context,int index){
                                      return  ListTile(
                                        title: Text(data['employers'][index]['productname']),
                                        leading: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(20),
                                                child: Image.network(data['employers'][index]['productUrl']))
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Text(data['employers']
                                            [index]['total'].toString() + " R.O"),
                                            SizedBox(width: 20,),
                                            Text("Desktop : "),
                                            Text(data['employers'][index]['shopname']),
                                          ],
                                        ),
                                      );

                                    } ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Delivery to  : "),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Column(
                                        children: [
                                          Text(((document.data() as dynamic)['userDetails']['firstName'])),
                                          Text(((document.data() as dynamic)['userDetails']['address']),
                                            maxLines: 3,),
                                          Text(((document.data() as dynamic)['userDetails']['email'])),
                                          Text(((document.data() as dynamic)['userDetails']['number'])),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const Divider(height: 3,color: Colors.grey,),

                            (document.data() as dynamic)['orderStatus']=='Accepted'?
                                Container(
                                  color: Colors.grey[300],
                                  height: 56,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: [
                                      Expanded(

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 40),
                                          child: TextButton(onPressed:(){
                                            showDialog(
                                                'Confirm Delivery','Delivered',document.id);
                                          },
                                              style: ButtonStyle(
                                                backgroundColor:MaterialStateProperty.
                                                all(Colors.red),
                                              ),
                                              child: const Text("Confirm Delivery",style:
                                              TextStyle(color: Colors.white),)),
                                        ),
                                      ),
                                    ],
                                  ),

                                ): (document.data() as dynamic)['orderStatus']=='Delivered'?
                            Container(
                              color: Colors.grey[300],
                              height: 56,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Expanded(

                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 40),
                                      child: TextButton(onPressed:(){
                                        showDeleteDialog('Confirm Delete', 'Deleted', document.id);
                                      },
                                          style: ButtonStyle(
                                            backgroundColor:MaterialStateProperty.
                                            all(Colors.red),
                                          ),
                                          child: const Text("Delete Order",style:
                                          TextStyle(color: Colors.white),)),
                                    ),
                                  ),
                                ],
                              ),

                            )
                            :Container(
                              color: Colors.grey[200],
                              height: 60,
                              child: Row(
                                children: [
                                  Expanded(

                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextButton(onPressed:(){
                                        showDialog(
                                            'Accept Order','Accepted',document.id);
                                        var notificationPayload = NotificationPayloadModel(to:'/topics/${
                                            (document.data()as dynamic)['userID']}',
                                          notification: NotificationContent(
                                              title: 'Your Order',
                                              body: 'Your Order is Accepted  from ${
                                                  (document.data()as dynamic)['seller']['shopname']
                                              }'),
                                        );
                                        sendNotification(notificationPayload);
                                      },

                                          style: ButtonStyle(
                                            backgroundColor:MaterialStateProperty.
                                            all(Colors.blueGrey),
                                          ),
                                          child: const Text("Accept Order",style:
                                          TextStyle(color: Colors.white),)),
                                    ),
                                  ),
                                  Expanded(

                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextButton(onPressed:(){
                                        showDialog('Reject Order','Rejected',document.id);
                                      },
                                          style: ButtonStyle(
                                            backgroundColor:MaterialStateProperty.
                                            all(Colors.redAccent),
                                          ),
                                          child: const Text("Reject order",style:
                                          TextStyle(color: Colors.white),)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(color: Colors.grey,)

                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 56,)
              ],
            );
          },
        ),
      ),
    );
  }
  showDialog(title,status,id){
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context){
          return CupertinoAlertDialog(
            title: Text(title),
            content: const Text('Are You Sure ?'),
            actions: [
              TextButton(
                  onPressed: (){
                    EasyLoading.show(status: 'updating');
                    _order.updateOrderStatus(id, status).then((value){
                      EasyLoading.showSuccess('updated successfully');
                    });
                    Navigator.pop(context);
                  },
                  child: Text('OK')),
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
            ],
          );
        });
  }
  showDeleteDialog(title,status,id){
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context){
          return CupertinoAlertDialog(
            title: Text(title),
            content: const Text('Are You Sure you want to delete ?'),
            actions: [
              TextButton(
                  onPressed: (){
                    EasyLoading.show(status: 'deleting');
                    _order.deleteOrder(id, status).then((value){
                      EasyLoading.showSuccess('updated successfully');
                    });
                    Navigator.pop(context);
                  },
                  child: Text('OK')),
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
            ],
          );
        });
  }
}
