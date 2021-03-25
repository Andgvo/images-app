 import 'package:flutter/material.dart';
import 'package:images_app/src/bloc/login_bloc.dart';
import 'package:images_app/src/bloc/products_bloc.dart';

class Provider extends InheritedWidget{

  static Provider _instance;

  final loginBloc = LoginBloc();
  final _productsBloc = ProductsBloc();  

  factory Provider({ Key key, Widget child }){
    if(_instance == null){
      _instance = new Provider._internal(key: key, child: child );
    }
    return _instance;
  }


  Provider._internal({ Key key, Widget child })
  : super(key: key, child: child );

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  static ProductsBloc  productsBloc ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._productsBloc;
  }

}