
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_bricks/Raw%20materials/addRawMaterial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Raw materials/soldRawMaterials.dart';

class rawMaterials extends StatefulWidget {
  const rawMaterials({super.key});

  @override
  State<rawMaterials> createState() => _rawMaterialsState();
}

class _rawMaterialsState extends State<rawMaterials> {

  CollectionReference? fileRef = FirebaseFirestore.instance.collection("Raw Materials");

  TextEditingController unitEditingController = TextEditingController();
  TextEditingController amountEditingController = TextEditingController();
  TextEditingController textEditingController = TextEditingController();

  String search = "";
  int initialAmount = 0;

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    final keyBoard = MediaQuery.of(context).viewInsets.bottom != 0;

    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
          centerTitle: false,
          backgroundColor: Colors.grey.shade100,
          title: Text("RAW MATERIALS",style: GoogleFonts.aBeeZee(color: Colors.black),),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed:() async {
              textEditingController.text = "";
              unitEditingController.text = "";
              amountEditingController.text = "";

              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return GestureDetector(
                      onTap: ()=> FocusScope.of(context).unfocus(),
                      child: AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text("Create new Material",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        content: SizedBox(
                          height: 110,
                          child: Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(left: 20),
                                  width: MediaQuery.of(context).size.width*0.8,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.purple.withOpacity(0.3),
                                          offset: Offset(2, 5),
                                          blurRadius: 7
                                      ),
                                    ],
                                  ),

                                  child:Center(
                                    child: TextField(
                                      textAlignVertical: TextAlignVertical.center,
                                      textAlign: TextAlign.start,
                                      controller: textEditingController,
                                      keyboardType: TextInputType.text,
                                      style: TextStyle(
                                        color: Colors.black,
                                        decorationColor: Colors.pinkAccent.withOpacity(0.05),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.7,
                                      ),
                                      cursorColor: Colors.black,
                                      decoration: const InputDecoration(
                                          hintText: ' Item',
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                              fontSize: 16
                                          )
                                      ),
                                    ),
                                  )
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.1,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.purple.withOpacity(0.3),
                                            offset: Offset(2, 5),
                                            blurRadius: 7
                                        ),
                                      ],
                                    ),
                                    child: TextField(
                                      textAlignVertical: TextAlignVertical.center,
                                      textAlign: TextAlign.center,
                                      controller: amountEditingController,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        color: Colors.black,
                                        decorationColor: Colors.pinkAccent.withOpacity(0.05),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.7,
                                      ),
                                      cursorColor: Colors.black,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '.....',
                                          hintStyle: TextStyle(
                                              fontSize: 16
                                          )
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.2,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.purple.withOpacity(0.3),
                                            offset: Offset(2, 5),
                                            blurRadius: 7
                                        ),
                                      ],
                                    ),
                                    child: TextField(
                                      textAlignVertical: TextAlignVertical.center,
                                      textAlign: TextAlign.center,
                                      controller: unitEditingController,
                                      keyboardType: TextInputType.text,
                                      style: TextStyle(
                                        color: Colors.black,
                                        decorationColor: Colors.pinkAccent.withOpacity(0.05),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.7,
                                      ),
                                      cursorColor: Colors.black,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: ' Unit',
                                          hintStyle: TextStyle(
                                              fontSize: 16
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: Text("Cancel",style: TextStyle(color: Colors.grey.shade100,fontSize: 19,fontWeight: FontWeight.bold),),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                shadowColor: Colors.black87,
                                elevation: 8
                            ),

                          ),
                          ElevatedButton(
                            onPressed: () async {
                              String name = textEditingController.text;
                              String unit = unitEditingController.text;
                              String amount = amountEditingController.text;
                              String order = DateTime.now().toString();

                              if(name.isEmpty || unit.isEmpty || amount.isEmpty)
                              {
                                Fluttertoast.showToast(msg: 'Please fill all fields');
                                return;
                              }
                              else
                              {
                                Navigator.pop(context);


                                await fileRef!.doc(order).set({
                                  'name' : name,
                                  'unit' : unit,
                                  'amount' : int.tryParse(amount),
                                  'order' : order,
                                });
                                await FirebaseFirestore.instance.collection('Raw add History').doc().set({
                                  'name' : name,
                                  'unit' : unit,
                                  'amount' : int.tryParse(amount),
                                  'order' : DateTime.now().toString(),
                                  'date' : '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}'
                                });
                              }
                            },
                            child: Text("Create",style: TextStyle(color: Colors.grey.shade100,fontSize: 19,fontWeight: FontWeight.bold),),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                                shadowColor: Colors.black87,
                                elevation: 8
                            ),
                          ),
                        ],
                        actionsAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                    );
                  }
              );
            },
            child: Icon(Icons.add,color: Colors.grey.shade100,size: 30,),
            backgroundColor: Colors.purple,
          ),
        body: Column(
          children: [
            Container(
              width: w,
              height: 40,
              margin: EdgeInsets.only(left: 20,right: 20 ,top: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: w*0.25,
                    height : 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 10,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: FloatingActionButton(
                      backgroundColor: Colors.purple,
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context){
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                content: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: w,
                                  child: SoldRawMaterials(),
                                ),
                              );
                            }
                        );
                      },
                      child: Text("Reduce",style: TextStyle(color: Colors.white,fontSize: 18),),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.history,color: Colors.purple,),
                      Text(" History",style: TextStyle(color: Colors.purple,fontSize: 18),),
                    ],
                  ),
                  Container(
                    width: w*0.25,
                    height : 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 10,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: FloatingActionButton(
                      backgroundColor: Colors.purple,
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context){
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                content: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: w,
                                  child: AddRawMaterials(),
                                ),
                              );
                            }
                        );
                      },
                      child: Text("Add",style: TextStyle(color: Colors.white,fontSize: 18),),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: w,
              height: 40,
              margin: EdgeInsets.only(left: 20,right: 20 ,top: 10),
              padding: EdgeInsets.only(left: 20,right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                onChanged: (val){
                  setState(() {
                    search = val;
                  });
                },
                cursorColor: Colors.purple,
                style: TextStyle(
                    decorationColor: Colors.white12,
                    letterSpacing: 0.7,
                    fontSize: 18,
                    color: Colors.black
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: 'Search the Material...',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                    ),
                    suffixIcon: Icon(Icons.search,color:!keyBoard ? Colors.black45 : Colors.purple ,)
                ),
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: StreamBuilder(
                stream: fileRef!.orderBy('name').startAt([search]).endAt([search + "\uf8ff"]).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.hasError){
                    return Center(child: Text("Something went wrong",style: TextStyle(fontSize: 19,color: Colors.red),));
                  }
                  else if(snapshot.connectionState == ConnectionState.waiting)
                  {
                    return Center(child: CircularProgressIndicator(color: Colors.purple,));
                  }
                  else if(snapshot.hasData)
                  {
                    return AnimationLimiter(
                      child: ListView.builder(
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: snapshot.data!.docs.length,
                        physics: BouncingScrollPhysics(parent: const AlwaysScrollableScrollPhysics()),
                        itemBuilder: (context , i){
                          QueryDocumentSnapshot x = snapshot.data!.docs[i];
                          return AnimationConfiguration.staggeredList(
                            position: i,
                            delay: const Duration(milliseconds: 100),
                            child: SlideAnimation(
                              duration: const Duration(milliseconds: 1500),
                              curve: Curves.fastLinearToSlowEaseIn,
                              horizontalOffset: 30,
                              verticalOffset: 300.0,
                              child: FadeInAnimation(
                                duration: const Duration(milliseconds: 2500),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: GestureDetector(
                                  onDoubleTap: (){
                                    textEditingController.text = x['name'];
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context){
                                          return GestureDetector(
                                            onTap: ()=> FocusScope.of(context).unfocus(),
                                            child: AlertDialog(
                                              backgroundColor: Colors.white,
                                              title: Row(
                                                children: [
                                                  Icon(Icons.drive_file_rename_outline,color: Colors.purple,size: 30,),
                                                  SizedBox(width: 10,),
                                                  Text("Rename",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 19,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              content: Container(
                                                padding: EdgeInsets.only(left: 20 ,bottom: 2),
                                                width: MediaQuery.of(context).size.width*0.8,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(30),
                                                  color: Colors.white,
                                                  boxShadow:[
                                                    BoxShadow(
                                                      color: Colors.grey.shade400,
                                                      offset: const Offset(10, 10),
                                                      blurRadius: 20,
                                                    )
                                                  ],
                                                ),

                                                child:TextFormField(
                                                  controller: textEditingController,
                                                  textCapitalization: TextCapitalization.sentences,
                                                  keyboardType: TextInputType.text,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    decorationColor: Colors.pinkAccent.withOpacity(0.05),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: 0.7,
                                                  ),
                                                  cursorColor: Colors.black,
                                                  decoration: const InputDecoration(
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: (){
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Cancel",style: TextStyle(color: Colors.white,fontSize: 18),),
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.grey
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: (){
                                                    if(textEditingController.text.isEmpty)
                                                    {
                                                      Fluttertoast.showToast(msg: 'Please fill the field');
                                                      return;
                                                    }
                                                    else
                                                    {
                                                      fileRef!.doc("${snapshot.data!.docs[i]['order']}").update({
                                                        'name' : textEditingController.text
                                                      });
                                                    }
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Save",style: TextStyle(color: Colors.white,fontSize: 18),),
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.purple
                                                  ),
                                                ),
                                              ],
                                              actionsAlignment: MainAxisAlignment.spaceAround,
                                            ),
                                          );
                                        }
                                    );
                                  },
                                  onLongPress: (){
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context){
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: Row(
                                              children: [
                                                Icon(Icons.delete,color: Colors.purple,size: 30,),
                                                SizedBox(width: 5,),
                                                Text("Delete",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 19,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            content: SizedBox(
                                              height: 25,
                                              child: Center(
                                                child: Text("Are you sure to delete?",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close,color: Colors.grey,size: 30,)),
                                              IconButton(
                                                  onPressed: (){
                                                    Navigator.pop(context);
                                                    fileRef!.doc("${snapshot.data!.docs[i]['order']}").delete();
                                                  },
                                                  icon: Icon(Icons.done,color: Colors.purple,size: 30,)
                                              )
                                            ],
                                            actionsAlignment: MainAxisAlignment.spaceAround,
                                          );
                                        }
                                    );
                                  },
                                  child: Container(
                                    height:60,
                                    width:  w*0.7,
                                    margin: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 10,
                                          offset: const Offset(0, 10),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Center(
                                        child: SingleChildScrollView(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                x['name'] + "     ${x['amount']}" + x['unit'],
                                                style: GoogleFonts.aBeeZee(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400),
                                              ),
                                              Expanded(child: SizedBox()),
                                              Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(90),
                                                ),
                                                child: FloatingActionButton(
                                                  onPressed: (){
                                                    String docu = "${snapshot.data!.docs[i]['order']}";
                                                    amountEditingController.text = "";
                                                    showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) {
                                                          return GestureDetector(
                                                            onTap: ()=> FocusScope.of(context).unfocus(),
                                                            child: AlertDialog(
                                                              backgroundColor: Colors.white,
                                                              title: const Text("Please enter the amount",
                                                                style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontSize: 18,
                                                                ),
                                                              ),
                                                              content: SizedBox(
                                                                height: 90,
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      padding: EdgeInsets.only(left: 20),
                                                                      width: MediaQuery.of(context).size.width*0.8,
                                                                      height: 40,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(30),
                                                                        color: Colors.white,
                                                                        boxShadow:[
                                                                          BoxShadow(
                                                                            color: Colors.grey.shade400,
                                                                            offset: const Offset(10, 10),
                                                                            blurRadius: 20,
                                                                          )
                                                                        ],
                                                                      ),

                                                                      child:TextFormField(
                                                                        controller: amountEditingController,
                                                                        keyboardType: TextInputType.number,
                                                                        style: TextStyle(
                                                                          color: Colors.black,
                                                                          decorationColor: Colors.pinkAccent.withOpacity(0.05),
                                                                          fontSize: 18,
                                                                          fontWeight: FontWeight.w400,
                                                                          letterSpacing: 0.7,
                                                                        ),
                                                                        cursorColor: Colors.black,
                                                                        decoration: const InputDecoration(
                                                                            hintText: ' Amount',
                                                                            border: InputBorder.none,
                                                                            hintStyle: TextStyle(fontSize: 16)
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const Expanded(child: SizedBox()),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                      children: [
                                                                        TextButton(onPressed: (){Navigator.pop(context);}, child: const Text("Cancel",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20),)),
                                                                        TextButton(
                                                                            onPressed: () async {
                                                                              if(amountEditingController.text.isEmpty)
                                                                              {
                                                                                Fluttertoast.showToast(msg: 'Please fill the field');
                                                                                return;
                                                                              }
                                                                              else if(x['amount'] == null)
                                                                              {
                                                                                setState(() {
                                                                                  initialAmount = 0;
                                                                                });
                                                                              }
                                                                              else
                                                                              {
                                                                                setState(() {
                                                                                  initialAmount = x['amount'];
                                                                                });
                                                                              }
                                                                              String amount = amountEditingController.text.trim();
                                                                              initialAmount = initialAmount - int.parse(amount);

                                                                              if(initialAmount<0){
                                                                                showDialog(
                                                                                    barrierDismissible: false,
                                                                                    context: context,
                                                                                    builder: (context) {
                                                                                      return AlertDialog(
                                                                                        backgroundColor: Colors.white,
                                                                                        title: const Row(
                                                                                          children: [
                                                                                            Icon(Icons.info_outline,color: Colors.red,),
                                                                                            SizedBox(width: 10,),
                                                                                            Text("Not enough items",
                                                                                              style: TextStyle(
                                                                                                color: Colors.red,
                                                                                                fontSize: 20,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        content: SizedBox(
                                                                                          height: 30,
                                                                                          child: Column(
                                                                                            children: [
                                                                                              const Text('Please check the balance',style: TextStyle(
                                                                                                color: Colors.black,
                                                                                                fontSize: 18,
                                                                                              ),),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        actions: [
                                                                                          ElevatedButton(
                                                                                            onPressed: (){
                                                                                              Navigator.pop(context);
                                                                                            },
                                                                                            child: Text("Ok",style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.bold),),
                                                                                            style: ElevatedButton.styleFrom(
                                                                                                backgroundColor: Colors.purple
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      );
                                                                                    }
                                                                                );
                                                                              }
                                                                              else{
                                                                                Navigator.pop(context);
                                                                                await FirebaseFirestore.instance.collection('Raw sold History').doc().set({
                                                                                  'name' : x['name'],
                                                                                  'unit' : x['unit'],
                                                                                  'amount' : int.tryParse(amount),
                                                                                  'order' : DateTime.now().toString(),
                                                                                  'date' : '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}'
                                                                                });

                                                                                fileRef!.doc(docu).update({
                                                                                  'amount' : initialAmount,
                                                                                });
                                                                              }
                                                                            },
                                                                            child: const Text("Reduce",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)
                                                                        ),
                                                                      ],),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                    );
                                                  },
                                                  child: Icon(Icons.remove,color: Colors.purple,),
                                                  backgroundColor: Colors.grey.shade100,
                                                ),
                                              ),
                                              SizedBox(width: 15,),
                                              Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(90),
                                                ),
                                                child: FloatingActionButton(
                                                  onPressed: (){
                                                    String docu = "${snapshot.data!.docs[i]['order']}";
                                                    amountEditingController.text = "";
                                                    showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            backgroundColor: Colors.white,
                                                            title: const Text("Please enter the amount",
                                                              style: TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                            content: SizedBox(
                                                              height: 90,
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    padding: EdgeInsets.only(left: 20),
                                                                    width: MediaQuery.of(context).size.width*0.8,
                                                                    height: 40,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(30),
                                                                      color: Colors.white,
                                                                      boxShadow:[
                                                                        BoxShadow(
                                                                          color: Colors.grey.shade400,
                                                                          offset: const Offset(10, 10),
                                                                          blurRadius: 20,
                                                                        )
                                                                      ],
                                                                    ),

                                                                    child:Center(
                                                                      child: TextFormField(
                                                                        controller: amountEditingController,
                                                                        keyboardType: TextInputType.number,
                                                                        style: TextStyle(
                                                                          color: Colors.black,
                                                                          decorationColor: Colors.pinkAccent.withOpacity(0.05),
                                                                          fontSize: 18,
                                                                          fontWeight: FontWeight.w400,
                                                                          letterSpacing: 0.7,
                                                                        ),
                                                                        cursorColor: Colors.black,
                                                                        decoration: const InputDecoration(
                                                                          hintText: ' Amount',
                                                                          border: InputBorder.none,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const Expanded(child: SizedBox()),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                    children: [
                                                                      TextButton(onPressed: (){Navigator.pop(context);}, child: const Text("Cancel",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20),)),
                                                                      TextButton(
                                                                          onPressed: () async {
                                                                            if(amountEditingController.text.isEmpty)
                                                                            {
                                                                              Fluttertoast.showToast(msg: 'Please fill the field');
                                                                              return;
                                                                            }
                                                                            Navigator.pop(context);

                                                                            String amount = amountEditingController.text.trim();

                                                                            await FirebaseFirestore.instance.collection('Raw add History').doc().set({
                                                                              'name' : x['name'],
                                                                              'unit' : x['unit'],
                                                                              'amount' : int.tryParse(amount),
                                                                              'order' : DateTime.now().toString(),
                                                                              'date' : '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}'
                                                                            });

                                                                            await fileRef!.doc(docu).update({
                                                                              'amount' : x['amount'] + int.parse(amount),
                                                                            });

                                                                          },
                                                                          child: const Text("Add",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)
                                                                      ),
                                                                    ],),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                    );

                                                  },
                                                  child: Icon(Icons.add,color: Colors.purple,),
                                                  backgroundColor: Colors.grey.shade100,
                                                ),
                                              ),
                                              SizedBox(width: 15,),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          );
                        },
                      ),
                    );
                  }
                  return Center(
                    child: const CircularProgressIndicator(
                      color: Colors.purple,
                    ),
                  );
                },

              ),
            ),
          ],
        )
      ),
    );
  }
}
