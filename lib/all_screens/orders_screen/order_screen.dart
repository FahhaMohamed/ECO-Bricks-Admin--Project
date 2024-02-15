
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_bricks/all_screens/mainScreen.dart';
import 'package:eco_bricks/all_screens/orders_screen/pending%20screen/pending_screen.dart';
import 'package:flutter/material.dart';
import 'completed screen/completed_screen.dart';
import '../../customers/completed customer/delivery_history_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  Stream<QuerySnapshot> pendingCustomer = FirebaseFirestore.instance.collection('Pending customer').snapshots();


  int selectedIndex = 0;

  final List <dynamic> pages = [const PendingScreen(), const CompletedScreen()];

  void selectedPage (int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  var counter = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          leading: IconButton(
              onPressed: (){

                   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => mainScreen()));

                },
              icon: const Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
          actions: [
            selectedIndex == 1 ? IconButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const DeliveryHistory()));}, icon: Icon(Icons.history,color: Colors.purple,size: 30,))
                : Icon(null),
          ],
          backgroundColor: Colors.grey.shade300,
          elevation: 0,
          title: const  Text("Order details",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22,),),
          bottom: TabBar(
            dividerColor: Colors.transparent,
            labelColor: Colors.purple,
            indicatorColor: Colors.purple,
            unselectedLabelColor: Colors.black54,
            onTap: selectedPage,
            tabs: [
              const Text('Pending',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,),),
              const Text('Completed',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,),),
            ],
          ),
        ),
        body: pages[selectedIndex],
      ),
    );
  }
}
