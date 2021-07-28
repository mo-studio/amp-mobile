import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:AMP/services/maestro.dart';
import 'package:AMP/services/blocs/auth_bloc.dart';
import 'package:AMP/widgets/Welcome.dart';
import 'package:AMP/widgets/CategoryList.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

  final authBloc = AuthBloc();
  authBloc.add(AuthRequested());
  runApp(BlocProvider.value(value: authBloc, child: AMP()));
}

class AMP extends StatefulWidget {
  @override
  _AMPState createState() => _AMPState();
}

class _AMPState extends State<AMP> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AMP',
      theme: ThemeData(
        primaryColor: Color(0xFF2C4378),
        accentColor: Color(0xFF397399),
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          if (authState is AuthLoadInProgress) {
            return Center(child: CircularProgressIndicator(value: null));
          } else if (authState is AuthLoaded) {
            if (authState.isLoggedIn) {
              Maestro.configure();
              return MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: Maestro.checklistBloc),
                  BlocProvider.value(value: Maestro.progressBloc)
                ],
                child: CategoryList()
              );
            } else {
              return BlocProvider.value(value: BlocProvider.of<AuthBloc>(context), child: Welcome());
            }
          }
          return null;
      })
    );
  }

  @override
  void dispose() {
    Maestro.progressBloc.close();
    super.dispose();
  }

}
