import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:images_app/src/models/product_model.dart';
import 'package:images_app/src/providers/products_provider.dart';
import 'package:images_app/src/utils/utils.dart';

class ProductPage extends StatefulWidget {

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final productsProvider = new ProductsProvider();

  ProductModel product = ProductModel();
  bool _loding = false;
  
  File _photo;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {

    final ProductModel prodData = ModalRoute.of(context).settings.arguments;
    if(prodData != null)
      product = prodData;

    return Container(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('Product'),
          actions: [
            IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: () => _choosePicture(ImageSource.gallery)
            ),
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: _takePicture
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
                  _showPicture(),
                  _createName(),
                  _createPrice(),
                  _createDisponible(),
                  _createButton(),
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
      initialValue: product.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Product name',
      ),
      onSaved: (value ) => product.titulo = value,
      validator: (value){
        if( value.length < 3)
          return 'Insert name';
        return null;
      },
    );
  }

  Widget _createPrice(){
    return TextFormField(
      initialValue: product.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Price'
      ),
      onSaved: (value ) => product.valor = double.parse(value),
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
      onPressed: (_loding) ? null : _submit,
      style: ElevatedButton.styleFrom(
        primary: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        )
      ),
    );
  }

  Widget _createDisponible(){
    return SwitchListTile(
      value: product.disponible,
      title: Text('On stock'),
      onChanged: ( value ) => setState((){
        product.disponible = value;
      }),
      activeColor: Colors.deepPurple,
    );
  }

  void _submit() async{
    if( !formKey.currentState.validate() ) return;
    formKey.currentState.save();
    setState(() => _loding = true );
    showSnackbar('Loading...');
    if(product.id == null )
      await productsProvider.createProduct(product);
    else
      await productsProvider.editProduct(product);
    setState(() => _loding = false );
    Navigator.pop(context);
  }

  void showSnackbar(String message){
    
    final snackbar = SnackBar(
      content: Text(message),
      duration: Duration( milliseconds: 1500),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  //Photo logic
  Widget _showPicture(){
    if(product.fotoUrl != null ){
      return Container();
    }
    return Image(
      image: AssetImage( _photo?.path ?? 'assets/no-image.png'),
      height:300,
      fit: BoxFit.cover
    );
  }

  Future _choosePicture( ImageSource imgSrc ) async{
    final pickedFile = await picker.getImage(source: imgSrc);

    setState(() {
      if (pickedFile != null) {
        print("SELECTED ");
        _photo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _takePicture(){

  }

}