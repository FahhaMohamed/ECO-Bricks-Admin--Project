import 'package:flutter/material.dart';

class AddCustomerDialog extends StatefulWidget {
  final VoidCallback onPressed;
  final TextEditingController categoryEditingController;
  final TextEditingController itemEditingController;
  final TextEditingController colorEditingController;
  final TextEditingController amountEditingController;
  final TextEditingController nameEditingController;
  final TextEditingController mobileEditingController;
  final TextEditingController addressEditingController;

  AddCustomerDialog({
    super.key,
    required this.categoryEditingController,
    required this.itemEditingController,
    required this.colorEditingController,
    required this.amountEditingController,
    required this.nameEditingController,
    required this.mobileEditingController,
    required this.addressEditingController,
    required this.onPressed,
  });

  @override
  State<AddCustomerDialog> createState() => _AddCustomerDialogState();
}

class _AddCustomerDialogState extends State<AddCustomerDialog> {
  int initialValue = 0;

  String category = "";
  String item = "";
  String color = "";
  String amount = "";

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return AlertDialog(
      scrollable: true,
      backgroundColor: Colors.grey.shade100,
      content: Container(
        width: w,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      "Customer details",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 19),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: widget.nameEditingController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.purple,
                      ),
                      hintText: 'Customer name',
                    ),
                  ),
                  TextFormField(
                    controller: widget.mobileEditingController,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.purple,
                      ),
                      hintText: '7XXXXXXXX',
                    ),
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: widget.addressEditingController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: Colors.purple,
                      ),
                      hintText: 'Address',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  "Order details",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 19),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    category = val;
                  });
                },
                controller: widget.categoryEditingController,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    category == "" ? Icons.circle_outlined : Icons.circle,
                    color: Colors.purple,
                  ),
                  hintText: 'Category',
                ),
              ),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    item = val;
                  });
                },
                controller: widget.itemEditingController,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    item == "" ? Icons.circle_outlined : Icons.circle,
                    color: Colors.purple,
                  ),
                  hintText: 'Item name',
                ),
              ),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    color = val;
                  });
                },
                controller: widget.colorEditingController,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    color == "" ? Icons.circle_outlined : Icons.circle,
                    color: Colors.purple,
                  ),
                  hintText: 'Colour',
                ),
              ),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    amount = val;
                  });
                },
                controller: widget.amountEditingController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    amount == "" ? Icons.circle_outlined : Icons.circle,
                    color: Colors.purple,
                  ),
                  hintText: 'Amount',
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: widget.onPressed,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
