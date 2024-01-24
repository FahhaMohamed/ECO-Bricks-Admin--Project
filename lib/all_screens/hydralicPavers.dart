
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndialog/ndialog.dart';
import 'package:photo_view/photo_view.dart';
import '../Utils/utils.dart';
import '../main_categories/Hydraulic pavers/hydraulicPaversMain.dart';


class hydraulicPavers extends StatefulWidget {
  const hydraulicPavers({super.key});

  @override
  State<hydraulicPavers> createState() => _hydraulicPaversState();
}

class _hydraulicPaversState extends State<hydraulicPavers> {

  CollectionReference? fileRef = FirebaseFirestore.instance.collection("Hydraulic Pavers");

  String url = "";

  void pickImage(String doc) async {
    Uint8List img = await uploadImage();
    String order = DateTime.now().millisecondsSinceEpoch.toString();

    ProgressDialog progressDialog = ProgressDialog(context, title: null, message: Text("Uploading..."));
    progressDialog.show();
    //upload to Firebase storage
    Reference reference = await FirebaseStorage.instance.ref().child(order);
    UploadTask task = reference.putData(img);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();

    await fileRef!.doc(doc).update({
      'Url' : url,
      'File id' : order
    });
    progressDialog.dismiss();
  }



  TextEditingController colorEditingController = TextEditingController();
  TextEditingController textEditingController = TextEditingController();
  TextEditingController ftEditingController = TextEditingController();
  TextEditingController mouldEditingController = TextEditingController();
  TextEditingController weightEditingController = TextEditingController();

  int initialAmount = 0;
  String search = "";


  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    final keyBoard = MediaQuery.of(context).viewInsets.bottom != 0;

    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed:() async {
                    textEditingController.text = "";
                    ftEditingController.text = "";
                    weightEditingController.text = "";

                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: const Text("Create new Hydraulic paver",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            content: SizedBox(
                              height: 200,
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
                                              hintText: ' Name',
                                              border: InputBorder.none,
                                              hintStyle: TextStyle(
                                                  fontSize: 16
                                              )
                                          ),
                                        ),
                                      )
                                  ),
                                  SizedBox(height: 10,),
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
                                        controller: ftEditingController,
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
                                            hintText: ' Per Sq.ft',
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                fontSize: 16
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
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
                                        controller: weightEditingController,
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
                                            hintText: ' Dry Weight',
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                fontSize: 16
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
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
                                  String feet = ftEditingController.text;
                                  String weight = weightEditingController.text;
                                  String order = DateTime.now().toString();

                                  if(name.isEmpty || feet.isEmpty || weight.isEmpty)
                                  {
                                    Fluttertoast.showToast(msg: 'Please fill all fields');
                                    return;
                                  }
                                  else
                                  {
                                    Navigator.pop(context);

                                    await fileRef!.doc(order).set({
                                      'name' : name,
                                      'feet' : feet,
                                      'weight' : weight,
                                      'order' : order,
                                      'Url' : ""
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
                          );
                        }
                    );
                  },
                  icon: Icon(Icons.create,color: Colors.purple,size: 30,))
            ],
            elevation: 0,
            leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
            centerTitle: false,
            backgroundColor: Colors.grey.shade100,
            title: Text("HYDRAULIC PAVERS",style: GoogleFonts.aBeeZee(color: Colors.black),),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                      color: Colors.purple.shade50,
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
                      hintText: 'Search here...',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.black45,
                      ),
                      suffixIcon: Icon(Icons.search,color:!keyBoard ? Colors.black45 : Colors.purple ,)
                  ),
                ),
              ),
              SizedBox(height: 30,),
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
                    } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {

                      return SingleChildScrollView(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/empty/emptybox.png',width: w *0.8,),
                              const SizedBox(height: 30,),
                              Text('No products yet',style: GoogleFonts.aBeeZee(color: Color(0xFF6A1B9A),fontSize: 22,fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      );
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
                                  child: Container(
                                      height:90,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              showAnimatedDialog(
                                                  axis: Axis.vertical,
                                                  curve: Curves.fastOutSlowIn,
                                                  duration: Duration(seconds: 1),
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      backgroundColor: Colors.white,
                                                      content: SizedBox(
                                                        height: MediaQuery.of(context).size.height*0.55,
                                                        width: w,
                                                        child: hydraulicPaversMain( xfeet: x['feet'], xweight: x['weight'], docum: '${snapshot.data!.docs[i]['order']}', xname: x['name'],),
                                                      ),
                                                    );
                                                  }
                                              );
                                            },
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
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.purple.shade50,
                                                    blurRadius: 10,
                                                    offset: const Offset(0, 10),
                                                  ),
                                                ],
                                              ),
                                              padding: const EdgeInsets.only(left: 20),
                                              child: Center(
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Expanded(
                                                        child: SingleChildScrollView(
                                                          scrollDirection: Axis.horizontal,
                                                          child: Text(
                                                            x['name'],
                                                            style: GoogleFonts.aBeeZee(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 100,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          children: [
                                                            Container(
                                                              height: 40,
                                                              width: 40,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(90),
                                                              ),
                                                              child: FloatingActionButton(
                                                                onPressed: (){
                                                                  String docu = "${snapshot.data!.docs[i]['order']}";
                                                                  showDialog(
                                                                      barrierDismissible: false,
                                                                      context: context,
                                                                      builder: (context) {
                                                                        return AlertDialog(
                                                                          backgroundColor: Colors.grey.shade100,
                                                                          icon: Row(
                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                            children: [
                                                                              IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios,color: Colors.black,)),
                                                                            ],
                                                                          ),
                                                                          title: const Text("Please select the colour",
                                                                            style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 20,
                                                                            ),
                                                                          ),
                                                                          content: SizedBox(
                                                                            height: 170,
                                                                            width: double.maxFinite,
                                                                            child: StreamBuilder(
                                                                                stream: fileRef!.doc(docu).collection('colors').snapshots(),
                                                                                builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                                                                                  if(snapshot.hasData){
                                                                                    return ListView.builder(
                                                                                        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                                                                        itemCount: snapshot.data!.docs.length,
                                                                                        itemBuilder: (context,j){
                                                                                          QueryDocumentSnapshot z = snapshot.data!.docs[j];
                                                                                          return GestureDetector(
                                                                                            onTap: (){
                                                                                              textEditingController.text = "";
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
                                                                                                                  controller: textEditingController,
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
                                                                                                                        if(textEditingController.text.isEmpty)
                                                                                                                        {
                                                                                                                          Fluttertoast.showToast(msg: 'Please fill the field');
                                                                                                                          return;
                                                                                                                        }
                                                                                                                        else if(z['amount'] == null)
                                                                                                                        {
                                                                                                                          setState(() {
                                                                                                                            initialAmount = 0;
                                                                                                                          });
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                          setState(() {
                                                                                                                            initialAmount = z['amount'];
                                                                                                                          });
                                                                                                                        }
                                                                                                                        String amount = textEditingController.text.trim();
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
                                                                                                                          await FirebaseFirestore.instance.collection('Sold History').doc().set({
                                                                                                                            'name' : x['name'],
                                                                                                                            'colour' : z['color'],
                                                                                                                            'amount' : int.tryParse(amount),
                                                                                                                            'order' : DateTime.now().toString(),
                                                                                                                            'date' : '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}'
                                                                                                                          });

                                                                                                                          fileRef!.doc(docu).collection('colors').doc(z['color']).update({
                                                                                                                            'amount' : initialAmount,
                                                                                                                          });
                                                                                                                        }
                                                                                                                      },
                                                                                                                      child: const Text("Sell",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)
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
                                                                                            child: Container(
                                                                                                margin: const EdgeInsets.all(8),
                                                                                                height: 40,
                                                                                                width: 6,
                                                                                                decoration: BoxDecoration(
                                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                                  color: Colors.white,
                                                                                                  boxShadow: [
                                                                                                    BoxShadow(
                                                                                                      color: Colors.black.withOpacity(0.1),
                                                                                                      blurRadius: 10,
                                                                                                      offset: const Offset(0, 10),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                child:Center(
                                                                                                  child: Text(z['color'],style: const TextStyle(color: Colors.black,fontSize: 19),),
                                                                                                )
                                                                                            ),
                                                                                          );

                                                                                        });

                                                                                  }
                                                                                  return const Center(
                                                                                    child:CircularProgressIndicator(
                                                                                      color: Colors.purple,
                                                                                    ) ,
                                                                                  );
                                                                                }
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                  );
                                                                },
                                                                child: Icon(Icons.sell_outlined,color: Colors.purple,),
                                                                backgroundColor: Colors.grey.shade100,
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 40,
                                                              width: 40,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(90),
                                                              ),
                                                              child: FloatingActionButton(
                                                                onPressed: (){
                                                                  String docu = "${snapshot.data!.docs[i]['order']}";
                                                                  showDialog(
                                                                      barrierDismissible: false,
                                                                      context: context,
                                                                      builder: (context) {
                                                                        return AlertDialog(
                                                                          backgroundColor: Colors.grey.shade100,
                                                                          icon: Row(
                                                                            children: [
                                                                              IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios,color: Colors.black,)),
                                                                              const Expanded(child: SizedBox()),
                                                                              const Text("Create new",style: TextStyle(color: Colors.purple,fontSize: 17,fontWeight: FontWeight.bold),),
                                                                              IconButton(
                                                                                  onPressed: (){
                                                                                    colorEditingController.text = "";
                                                                                    textEditingController.text = "";
                                                                                    showDialog(
                                                                                        barrierDismissible: false,
                                                                                        context: context,
                                                                                        builder: (context) {
                                                                                          return GestureDetector(
                                                                                            onTap: ()=> FocusScope.of(context).unfocus(),
                                                                                            child: AlertDialog(
                                                                                              backgroundColor: Colors.white,
                                                                                              title: const Text("Add new colour",
                                                                                                style: TextStyle(
                                                                                                  color: Colors.black,
                                                                                                  fontSize: 18,
                                                                                                ),
                                                                                              ),
                                                                                              content: SizedBox(
                                                                                                height: 160,
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
                                                                                                        controller: colorEditingController,
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
                                                                                                            hintText: ' Colour',
                                                                                                            border: InputBorder.none,
                                                                                                            hintStyle: TextStyle(
                                                                                                                fontSize: 16
                                                                                                            )
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    const SizedBox(height: 10,),
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
                                                                                                        controller: textEditingController,
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
                                                                                                            hintStyle: TextStyle(
                                                                                                                fontSize: 16
                                                                                                            )
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
                                                                                                              if(textEditingController.text.isEmpty || colorEditingController.text.isEmpty)
                                                                                                              {
                                                                                                                Fluttertoast.showToast(msg: 'Please fill all fields');
                                                                                                                return;
                                                                                                              }
                                                                                                              String amount = textEditingController.text.trim();
                                                                                                              if(amount.isEmpty){
                                                                                                                amount = "0";
                                                                                                              }
                                                                                                              String color = colorEditingController.text.trim();

                                                                                                              Navigator.pop(context);

                                                                                                              await FirebaseFirestore.instance.collection('Add History').doc().set({
                                                                                                                'name' : x['name'],
                                                                                                                'colour' : color,
                                                                                                                'amount' : int.tryParse(amount),
                                                                                                                'order' : DateTime.now().toString(),
                                                                                                                'date' : '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}'
                                                                                                              });
                                                                                                              await fileRef!.doc('${snapshot.data!.docs[i]['order']}').collection('colors').doc(color).set({
                                                                                                                'color' : color,
                                                                                                                'amount' : int.tryParse(amount),
                                                                                                              });


                                                                                                            },
                                                                                                            child: const Text("Create",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
                                                                                                      ],),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        }
                                                                                    );
                                                                                  },
                                                                                  icon: Icon(
                                                                                    Icons.add_circle,
                                                                                    color: Colors.purple,
                                                                                    size: 30,
                                                                                    shadows: [
                                                                                      Shadow(
                                                                                        color: Colors.grey.shade300,
                                                                                        blurRadius: 10,
                                                                                        offset: const Offset(0, 5),
                                                                                      )
                                                                                    ],
                                                                                  )
                                                                              )
                                                                            ],
                                                                          ),
                                                                          title: const Text("Please select the colour",
                                                                            style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 20,
                                                                            ),
                                                                          ),
                                                                          content: SizedBox(
                                                                            height: 170,
                                                                            width: double.maxFinite,
                                                                            child: StreamBuilder(
                                                                                stream: fileRef!.doc('${snapshot.data!.docs[i]['order']}').collection('colors').snapshots(),
                                                                                builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                                                                                  if(snapshot.hasData){
                                                                                    return ListView.builder(
                                                                                        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                                                                        itemCount: snapshot.data!.docs.length,
                                                                                        itemBuilder: (context,z){
                                                                                          QueryDocumentSnapshot j = snapshot.data!.docs[z];
                                                                                          return GestureDetector(
                                                                                            onTap: (){
                                                                                              textEditingController.text = "";
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
                                                                                                                  controller: textEditingController,
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
                                                                                                                      if(textEditingController.text.isEmpty)
                                                                                                                      {
                                                                                                                        Fluttertoast.showToast(msg: 'Please fill the field');
                                                                                                                        return;
                                                                                                                      }
                                                                                                                      Navigator.pop(context);

                                                                                                                      String amount = textEditingController.text.trim();


                                                                                                                      await FirebaseFirestore.instance.collection('Add History').doc().set({
                                                                                                                        'name' : x['name'],
                                                                                                                        'colour' : j['color'],
                                                                                                                        'amount' : int.tryParse(amount),
                                                                                                                        'order' : DateTime.now().toString(),
                                                                                                                        'date' : '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}'
                                                                                                                      });

                                                                                                                      await fileRef!.doc(docu).collection('colors').doc(j['color']).set({
                                                                                                                        'color' : j['color'],
                                                                                                                        'amount' : j['amount'] + int.parse(amount),
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
                                                                                            child: Container(
                                                                                                margin: const EdgeInsets.all(8),
                                                                                                height: 40,
                                                                                                width: 6,
                                                                                                decoration: BoxDecoration(
                                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                                  color: Colors.white,
                                                                                                  boxShadow: [
                                                                                                    BoxShadow(
                                                                                                      color: Colors.black.withOpacity(0.1),
                                                                                                      blurRadius: 10,
                                                                                                      offset: const Offset(0, 10),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                child:Center(
                                                                                                  child: Text(j['color'],style: const TextStyle(color: Colors.black,fontSize: 19),),
                                                                                                )
                                                                                            ),
                                                                                          );

                                                                                        });

                                                                                  }
                                                                                  return const Center(
                                                                                    child:CircularProgressIndicator(
                                                                                      color: Colors.purple,
                                                                                    ) ,
                                                                                  );
                                                                                }
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
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              showDialog(
                                                  context: context,
                                                  builder: (context){
                                                    return Stack(
                                                      children: [
                                                        Container(
                                                            child: x['Url'] == "" ? PhotoView(
                                                                imageProvider: AssetImage('assets/imgs.jpg')
                                                            ) : PhotoView(
                                                                imageProvider: NetworkImage(x['Url']),
                                                            )
                                                        ),
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            SizedBox(height: 20,),
                                                            Row(
                                                              children: [
                                                                IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_rounded , color: Colors.white,size: 30,)),
                                                                Text(x['name'], style: TextStyle(color: Colors.white,fontSize: 25)),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  }
                                              );
                                            },
                                            onLongPress: () {
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
                                                          child: Text("Are you sure to delete the Image?",
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
                                                            onPressed: () async {
                                                              Navigator.pop(context);
                                                              await fileRef!.doc("${snapshot.data!.docs[i]['order']}").update({
                                                                'Url' : ""
                                                              });
                                                              await FirebaseStorage.instance.ref().child('${snapshot.data!.docs[i]['file id']}').delete();
                                                            },
                                                            icon: Icon(Icons.done,color: Colors.purple,size: 30,)
                                                        )
                                                      ],
                                                      actionsAlignment: MainAxisAlignment.spaceAround,
                                                    );
                                                  }
                                              );

                                            },
                                            onDoubleTap: () => pickImage("${snapshot.data!.docs[i]['order']}"),
                                            child: Container(
                                              height:80,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.purple.shade50,
                                                    blurRadius: 10,
                                                    offset: const Offset(0, 10),
                                                  ),
                                                ],
                                              ),
                                              child:x['Url'] == "" ? ClipOval(child: Image.asset('assets/emptyImg.jpg')) : ClipOval(
                                                child:Container(
                                                  color:Colors.white,
                                                  child:  Image.network(x['Url'],
                                                    loadingBuilder: (context, child, loadingProgress) {
                                                      if (loadingProgress == null) return child;
                                                      return SpinKitFadingCircle(
                                                        color: Colors.purple.shade400,
                                                      );// You can use LinearProgressIndicator or CircularProgressIndicator instead
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
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
