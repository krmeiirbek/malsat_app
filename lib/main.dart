import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malsat_app/bloc/auth_bloc/auth.dart';
import 'package:malsat_app/pages/auth.dart';
import 'package:malsat_app/pages/home_page.dart';
import 'package:malsat_app/repositories/repositories.dart';
import 'package:malsat_app/screens/home_screen.dart';

void main() {
  final AuthRepository authRepository = AuthRepository();
  final CityRepository cityRepository = CityRepository();
  runApp(
    BlocProvider(
      create: (context) {
        return AuthenticationBloc(authRepository, cityRepository)
          ..add(AppStarted());
      },
      child: MyApp(
        authRepository: authRepository,
        cityRepository: cityRepository,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final CityRepository cityRepository;

  MyApp({Key key, @required this.authRepository, this.cityRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc,AuthenticationState>(
        builder: (context, state) {
          if(state is AuthenticationAuthenticated){
            return HomePage(listCities: state.loadedCities);
          }
          if(state is AuthenticationUnauthenticated){
            return AuthSwitch(authRepository: authRepository,);
          }
          if(state is AuthenticationLoading){
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
