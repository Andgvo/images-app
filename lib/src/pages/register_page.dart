import 'package:flutter/material.dart';
import 'package:images_app/src/bloc/login_bloc.dart';
import 'package:images_app/src/bloc/provider.dart';
import 'package:images_app/src/providers/user_provider.dart';
import 'package:images_app/src/utils/utils.dart';

class RegisterPage extends StatefulWidget {

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  
  final userProvider = UserProvider();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _createBackground(context),
          _loginForm(context),
        ],
      )
    );
  }

  Widget _loginForm(BuildContext context){
    
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Center(
              child: Container(
                margin: EdgeInsets.only(top: size.height * 0.25),
                padding: EdgeInsets.symmetric(vertical: 50.0),
                width: size.width * 0.85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0)
                    )
                  ]
                ),
                child: Column( 
                  children: [
                    Text('Sign up'),
                    SizedBox(height: 20.0,),
                    _createEmail(bloc),
                    _createPassword(bloc),
                    _createButton(bloc),
                    Divider(
                      height: 50,
                      indent: 20,
                      endIndent: 20,
                      color: Colors.deepPurple,
                    ),
                    _registerButton(context)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _createEmail(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.emailStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.deepPurple,),
              hintText: 'ejemplo@correo.com',
              labelText: 'Email',
              errorText: snapshot.error
            ),
            onChanged:   bloc.changeEmail,
            
          ),
        );
      },
    );
    
  }

  Widget _createPassword(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.passwordStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: Colors.deepPurple,),
              hintText: '****',
              labelText: 'Password',
              errorText: snapshot.error
            ),
            onChanged: bloc.changePassword,
          ),
        );    
      },
    );

  }

  Widget _createButton(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.formValidStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          margin: EdgeInsets.only(top: 30.0),
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: ElevatedButton(
            child: Container(
              //padding: EdgeInsets.symmetric( horizontal: 80.0, vertical: 15.0),
              width: double.infinity,
              child: Center(
                child: Text('Sign Up')
              ),
            ),
            onPressed: (snapshot.hasData && !_loading) ? () => _signUp(bloc, context) : null,

            style: ElevatedButton.styleFrom( primary: Color.fromRGBO(63, 159, 63, 1.0) ),
          ),
        );
      },
    );

  }

  _signUp(LoginBloc bloc, BuildContext context) async {
    
    setState(() => _loading = true );
    Map info = await userProvider.signUp(bloc.email, bloc.password);
    setState(() => _loading = false );
    
    if(info['ok'])
      Navigator.pop(context);
    else
      showAlert(context, 'Error', info['message']);

  }

  Widget _registerButton(BuildContext context){
    return Container(
          //margin: EdgeInsets.only(top: 30.0),
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: ElevatedButton(
            child: Container(
              //padding: EdgeInsets.symmetric( horizontal: 80.0, vertical: 15.0),
              width: double.infinity,
              child: Center(
                child: Text('Sign up')
              ),
            ),
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom( primary: Color.fromRGBO(159, 63, 63, 1.0) ),
          ),
        );
  }

  Widget _createBackground(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    final purpleBG = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient( 
          colors: [
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0)
          ]
        )
      ),
    );

    final circle = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );

    return Stack(
      children: [
        purpleBG,
        Positioned( top: 90, left: 30, child: circle),
        Positioned( top: -40, right: -30, child: circle),
        Positioned( bottom: -50, right: -10, child: circle),
        Positioned( bottom: 120, right: 20, child: circle),
        Positioned( bottom: -50, left: -20, child: circle),

        Container(
          padding: EdgeInsets.only(top: size.height * 0.1),
          child: Column(
            children: [
              Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0,),
              SizedBox(height: 10.0, width: double.infinity,),
              Text('Create account', style: TextStyle(color: Colors.white, fontSize: 20.0))
            ],
          ),
        )
      ],
    );
  }
}