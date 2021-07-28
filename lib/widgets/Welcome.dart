import 'package:AMP/services/auth.dart';
import 'package:AMP/services/blocs/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

DropdownButton<String> createDropdown(
    {List<String> values,
    String selectedValue,
    String hint,
    void Function(String) onChanged,
    context}) {
  return DropdownButton<String>(
      value: selectedValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      isExpanded: true,
      hint: Text(hint),
      style: TextStyle(color: Theme.of(context).accentColor),
      underline: Container(
        height: 2,
        color: Theme.of(context).accentColor,
      ),
      onChanged: onChanged,
      items: values.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,
              style: TextStyle(color: Theme.of(context).accentColor)),
        );
      }).toList());
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: SafeArea(
                    child: Image.asset("lib/assets/af_logo.png",
                        height: 50, width: 50))),
            Expanded(
                flex: 1,
                child: Image.asset("lib/assets/white_logo.png",
                    height: 100, width: 250)),
            Expanded(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Welcome to Airmen Mobile Processing",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20)),
                        ]))),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 90),
              child: FractionallySizedBox(
                  widthFactor: 0.5,
                  child: ElevatedButton(
                      child: Text("Get Started",
                          style: TextStyle(color: Colors.white)),
                      onPressed: this._authenticateAndNavigate,
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).accentColor,
                          onPrimary: Colors.white))),
            ),
          ],
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              const Color(0xFF162E51),
              const Color(0xFF00639A),
              const Color(0xFFCCCCCC)
            ],
            stops: [0.0, 0.3, 1.0],
          ),
        ),
      )
    );
  }

  void _authenticateAndNavigate() async {
    bool success = await authenticate();
    if (success) {
      BlocProvider.of<AuthBloc>(context).add(AuthLogIn());
    }
  }
}
