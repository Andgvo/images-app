import 'package:flutter/material.dart';
import 'package:images_app/src/bloc/products_bloc.dart';
import 'package:images_app/src/bloc/provider.dart';
import 'package:images_app/src/models/product_model.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  ProductsBloc _productsBloc;

  @override
  Widget build(BuildContext context) {
    
    _productsBloc = Provider.productsBloc(context);
    _productsBloc.getProducts();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: _createListItem(),
      floatingActionButton: _createButton(context),
    );
  }

  Widget _createButton(BuildContext context){
    return FloatingActionButton(
      child: Icon( Icons.add ),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'product').then((value) => setState((){}))
    );
  }

  Widget _createListItem(){

    return StreamBuilder(
      stream:  _productsBloc.productsStream,
      builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot){
        if(snapshot.hasData){
         final products = snapshot.data; 
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, i) => _createItem(context, products[i]),
          );
        }
        return Center( child: CircularProgressIndicator());
      },
    );

    // Future implement
    // return FutureBuilder(
    //   future: productsProvider.getProducts(),
    //   builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
    //     if(snapshot.hasData){
    //      final products = snapshot.data; 
    //       return ListView.builder(
    //         itemCount: products.length,
    //         itemBuilder: (context, i) => _createItem(context, products[i]),
    //       );
    //     }
    //     return Center( child: CircularProgressIndicator());
    //   },
    // );
  }

  Widget _createItem(BuildContext context, ProductModel product){
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red
      ),
      onDismissed: (direction){
        _productsBloc.deleteProduct(product.id);
        //productsProvider.deleteProduct(product.id);
      },
      child: ListTile(
        title: Text('${product.titulo} - ${product.valor}'),
        subtitle: Text(product.id),
        onTap: () => Navigator.pushNamed(context, 'product', arguments: product).then((value) => setState((){})),
      ),
    );
  }
}