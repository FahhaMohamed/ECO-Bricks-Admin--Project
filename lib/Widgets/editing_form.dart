import 'package:flutter/material.dart';

class EditingForm extends StatefulWidget {

  final TextEditingController textEditingController;
  final VoidCallback onPressed;
  const EditingForm({super.key, required this.textEditingController, required this.onPressed});

  @override
  State<EditingForm> createState() => _EditingFormState();
}

class _EditingFormState extends State<EditingForm> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      scrollable: true,
      backgroundColor: Colors.grey.shade100,
      title: Text("Edit",style: TextStyle(color: Colors.black,fontSize: 19),),
      content: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller:widget.textEditingController,
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.edit,
                color: Colors.purple,
              ),
            ),
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red
          ),
          onPressed: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.close,color: Colors.white,),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green
          ),
          onPressed: widget.onPressed,
          child: Icon(Icons.check,color: Colors.white,),
        )
      ],
    );
  }
}
