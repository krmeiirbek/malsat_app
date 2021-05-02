import 'package:bloc/bloc.dart';
import 'package:malsat_app/models/category.dart';
import 'package:malsat_app/models/city.dart';
import 'package:malsat_app/repositories/repositories.dart';
import 'auth.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;
  final CityRepository cityRepository;
  final CategoryRepository categoryRepository;

  AuthenticationBloc(this.authRepository, this.cityRepository, this.categoryRepository)
      : assert(authRepository !=null),
        super(AuthenticationUninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      final bool hasToken = await authRepository.hasToken();
      if (hasToken) {
        final List<City> _loadedCitiesList = await cityRepository.getAllCities();
        final List<Category> _loadedCategoriesList = await categoryRepository.getAllCategories();
        yield AuthenticationAuthenticated(loadedCities: _loadedCitiesList,loadedCategories: _loadedCategoriesList);
      } else {
        yield AuthenticationUnauthenticated();
      }
    }
    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await authRepository.writeToken(event.token,null);
      final List<City> _loadedCitiesList = await cityRepository.getAllCities();
      final List<Category> _loadedCategoriesList = await categoryRepository.getAllCategories();
      yield AuthenticationAuthenticated(loadedCities: _loadedCitiesList, loadedCategories: _loadedCategoriesList);
    }
    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await authRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
