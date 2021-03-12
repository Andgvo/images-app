import 'package:flutter/material.dart';
import 'package:images_app/src/utils/utils.dart';

class ProductPage extends StatefulWidget {

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Product'),
          actions: [
            IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: (){}
            ),
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: (){}
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  _createName(),
                  _createPrice(),
                  _createButton()
                ],
              ),
            ),
          ),
        ),
      ),
      
    );
  }

  Widget _createName(){
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Product name',
      ),
      validator: (value){
        if( value.length < 3)
          return 'Insert name';
        return null;
      },
    );
  }

  Widget _createPrice(){
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Price'
      ),
      validator: (value){
        if( isNumeric(value) )
          return null;
        return 'Only numbers';
      },
    );
  }

  Widget _createButton(){
    return ElevatedButton.icon(
      label: Text('Save'),
      icon: Icon(Icons.save),
      onPressed: _submit,
      style: ElevatedButton.styleFrom(
        primary: Colors.deepPurple, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        )
      ),
    );
  }

  void _submit(){
    formKey.currentState.validate();
  }
}