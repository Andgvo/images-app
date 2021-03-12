import 'package:flutter/material.dart';
import 'package:images_app/src/bloc/provider.dart';

class HomePage extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {
    
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(
        
      ),
      floatingActionButton: _createButton(context),
    );
  }

  Widget _createButton(BuildContext context){
    return FloatingActionButton(
      child: Icon( Icons.add ),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'product')
    );
  }
}