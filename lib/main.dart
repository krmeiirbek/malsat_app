import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malsat_app/bloc/auth_bloc/auth.dart';
import 'package:malsat_app/data/data.dart';
import 'package:malsat_app/pages/auth.dart';
import 'package:malsat_app/pages/home_page.dart';
import 'package:malsat_app/repositories/post_respository.dart';
import 'package:malsat_app/repositories/repositories.dart';

void main() {
  final authRepository = authRepositoryGlobal;
  final CityRepository cityRepository = CityRepository();
  final CategoryRepository categoryRepository = CategoryRepository();
  final PostRepository postRepository = PostRepository();
  runApp(
    BlocProvider(
      create: (context) {
        return AuthenticationBloc(
          authRepository,
          cityRepository,
          categoryRepository,
          postRepository,
        )..add(AppStarted());
      },
      child: MyApp(
        authRepository: authRepository,
        cityRepository: cityRepository,
        categoryRepository: categoryRepository,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final CityRepository cityRepository;
  final CategoryRepository categoryRepository;
  final PostRepository postRepository;

  MyApp({
    Key key,
    @required this.authRepository,
    this.cityRepository,
    this.categoryRepository,
    this.postRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return HomePage(
              listCities: state.loadedCities,
              listCategories: state.loadedCategories,
              listPostsApprovedNotHidden: state.loadedPostsApprovedNotHidden,
              authRepository: authRepository,
            );
          }
          if (state is AuthenticationUnauthenticated) {
            return AuthSwitch(
              authRepository: authRepository,
            );
          }
          if (state is AuthenticationLoading) {
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
