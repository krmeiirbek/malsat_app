import 'package:bloc/bloc.dart';
import 'package:malsat_app/models/bookmark.dart';
import 'package:malsat_app/models/category.dart';
import 'package:malsat_app/models/city.dart';
import 'package:malsat_app/models/post.dart';
import 'package:malsat_app/models/user.dart';
import 'package:malsat_app/repositories/bookmark_repository.dart';
import 'package:malsat_app/repositories/post_respository.dart';
import 'package:malsat_app/repositories/repositories.dart';
import 'auth.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;
  final CityRepository cityRepository;
  final CategoryRepository categoryRepository;
  final PostRepository postRepository;
  final BookmarkRepository bookmarkRepository;

  AuthenticationBloc(this.authRepository, this.cityRepository,
      this.categoryRepository, this.postRepository, this.bookmarkRepository)
      : assert(authRepository != null),
        super(AuthenticationUninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      final bool hasToken = await authRepository.hasToken();
      if (hasToken) {
        final List<City> _loadedCitiesList =
            await cityRepository.getAllCities();
        final List<Category> _loadedCategoriesList =
            await categoryRepository.getAllCategories();
        final List<Post> _loadedPostsApprovedNotHidden =
            await postRepository.getAllPostsApprovedNotHidden();
        final List<Post> _loadedMyActivePosts =
            await postRepository.getMyActivePosts();

        final List<Post> _loadedMyHiddenPosts =
            await postRepository.getMyHiddenPosts();

        final User _currentUser = await authRepository.getUserDetails();
        final List<BookMark> _loadedBookmarks =
            await bookmarkRepository.getAllBookmarks();
        final List<Post> _loadedMyCheckingPosts =
            await postRepository.getMyCheckingPosts();

        print(_loadedCitiesList);
        yield AuthenticationAuthenticated(
          loadedCities: _loadedCitiesList,
          loadedCategories: _loadedCategoriesList,
          loadedPostsApprovedNotHidden: _loadedPostsApprovedNotHidden,
          loadedBookmarks: _loadedBookmarks,
          currentUser: _currentUser,
          listMyActivePosts: _loadedMyActivePosts,
          listMyHiddenPosts: _loadedMyHiddenPosts,
          listMyCheckingPosts: _loadedMyCheckingPosts,
        );
      } else {
        yield AuthenticationUnauthenticated();
      }
    }
    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await authRepository.writeToken(event.token, null);
      final List<City> _loadedCitiesList = await cityRepository.getAllCities();
      final List<Category> _loadedCategoriesList =
          await categoryRepository.getAllCategories();
      final List<Post> _loadedPostsApprovedNotHidden =
          await postRepository.getAllPostsApprovedNotHidden();
      final List<BookMark> _loadedBookmarks =
          await bookmarkRepository.getAllBookmarks();
      final User _currentUser = await authRepository.getUserDetails();

      final List<Post> _loadedMyActivePosts =
          await postRepository.getMyActivePosts();
      final List<Post> _loadedMyHiddenPosts =
          await postRepository.getMyHiddenPosts();
      final List<Post> _loadedMyCheckingPosts =
          await postRepository.getMyCheckingPosts();

      yield AuthenticationAuthenticated(
        loadedCities: _loadedCitiesList,
        loadedCategories: _loadedCategoriesList,
        loadedPostsApprovedNotHidden: _loadedPostsApprovedNotHidden,
        loadedBookmarks: _loadedBookmarks,
        currentUser: _currentUser,
        listMyActivePosts: _loadedMyActivePosts,
        listMyHiddenPosts: _loadedMyHiddenPosts,
        listMyCheckingPosts: _loadedMyCheckingPosts,
      );
    }
    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await authRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }

    if (event is UpdateBookMarks) {
      yield AuthenticationLoading();
      final List<City> _loadedCitiesList = await cityRepository.getAllCities();
      final List<Category> _loadedCategoriesList =
          await categoryRepository.getAllCategories();
      final List<Post> _loadedPostsApprovedNotHidden =
          await postRepository.getAllPostsApprovedNotHidden();
      final List<Post> _loadedMyHiddenPosts =
          await postRepository.getMyHiddenPosts();

      final List<Post> _loadedMyActivePosts =
          await postRepository.getMyActivePosts();
      final User _currentUser = await authRepository.getUserDetails();
      final List<BookMark> _loadedBookmarks = await bookmarkRepository
          .addBookmarks(event.postId, inBookmarks: event.inBookmarks);

      final List<Post> _loadedMyCheckingPosts =
          await postRepository.getMyCheckingPosts();

      yield AuthenticationAuthenticated(
        loadedCities: _loadedCitiesList,
        loadedCategories: _loadedCategoriesList,
        loadedPostsApprovedNotHidden: _loadedPostsApprovedNotHidden,
        loadedBookmarks: _loadedBookmarks,
        currentUser: _currentUser,
        listMyActivePosts: _loadedMyActivePosts,
        listMyHiddenPosts: _loadedMyHiddenPosts,
        listMyCheckingPosts: _loadedMyCheckingPosts,
        openScreen: event.openScreen,
      );
    }

    if (event is SearchPost) {
      yield AuthenticationLoading();
      final List<City> _loadedCitiesList = await cityRepository.getAllCities();
      final List<Category> _loadedCategoriesList =
          await categoryRepository.getAllCategories();
      final List<Post> _loadedPostsApprovedNotHidden =
          await postRepository.getAllPostsWithKeyWord(event.keyWord);
      final List<Post> _loadedMyHiddenPosts =
          await postRepository.getMyHiddenPosts();

      final List<Post> _loadedMyActivePosts =
          await postRepository.getMyActivePosts();
      final User _currentUser = await authRepository.getUserDetails();
      final List<BookMark> _loadedBookmarks =
          await bookmarkRepository.getAllBookmarks();

      final List<Post> _loadedMyCheckingPosts =
          await postRepository.getMyCheckingPosts();

      yield AuthenticationAuthenticated(
        loadedCities: _loadedCitiesList,
        loadedCategories: _loadedCategoriesList,
        loadedPostsApprovedNotHidden: _loadedPostsApprovedNotHidden,
        loadedBookmarks: _loadedBookmarks,
        currentUser: _currentUser,
        listMyActivePosts: _loadedMyActivePosts,
        listMyHiddenPosts: _loadedMyHiddenPosts,
        listMyCheckingPosts: _loadedMyCheckingPosts,
      );
    }

    if (event is GetPostsByCity) {
      yield AuthenticationLoading();
      final List<City> _loadedCitiesList = await cityRepository.getAllCities();
      final List<Category> _loadedCategoriesList =
          await categoryRepository.getAllCategories();
      final List<Post> _loadedPostsApprovedNotHidden =
          await postRepository.getAllPostsApprovedNotHidden();
      final List<Post> _loadedPostsByCity =
          await postRepository.getAllPostsWithCity(event.cityId);
      final List<Post> _loadedMyHiddenPosts =
          await postRepository.getMyHiddenPosts();

      final List<Post> _loadedMyActivePosts =
          await postRepository.getMyActivePosts();
      final User _currentUser = await authRepository.getUserDetails();
      final List<BookMark> _loadedBookmarks =
          await bookmarkRepository.getAllBookmarks();

      final List<Post> _loadedMyCheckingPosts =
          await postRepository.getMyCheckingPosts();

      yield AuthenticationAuthenticated(
        loadedCities: _loadedCitiesList,
        loadedCategories: _loadedCategoriesList,
        loadedPostsApprovedNotHidden: _loadedPostsApprovedNotHidden,
        loadedBookmarks: _loadedBookmarks,
        currentUser: _currentUser,
        listMyActivePosts: _loadedMyActivePosts,
        listMyHiddenPosts: _loadedMyHiddenPosts,
        listMyCheckingPosts: _loadedMyCheckingPosts,
        listPostsByCity: _loadedPostsByCity,
      );
    }

    if (event is OpenScreen) {
      yield AuthenticationLoading();
      final List<City> _loadedCitiesList = await cityRepository.getAllCities();
      final List<Category> _loadedCategoriesList =
          await categoryRepository.getAllCategories();
      final List<Post> _loadedPostsApprovedNotHidden =
          await postRepository.getAllPostsApprovedNotHidden();
      final List<Post> _loadedMyHiddenPosts =
          await postRepository.getMyHiddenPosts();

      final List<Post> _loadedMyActivePosts =
          await postRepository.getMyActivePosts();
      final User _currentUser = await authRepository.getUserDetails();
      final List<BookMark> _loadedBookmarks =
          await bookmarkRepository.getAllBookmarks();

      final List<Post> _loadedMyCheckingPosts =
          await postRepository.getMyCheckingPosts();

      yield AuthenticationAuthenticated(
        loadedCities: _loadedCitiesList,
        loadedCategories: _loadedCategoriesList,
        loadedPostsApprovedNotHidden: _loadedPostsApprovedNotHidden,
        loadedBookmarks: _loadedBookmarks,
        currentUser: _currentUser,
        listMyActivePosts: _loadedMyActivePosts,
        listMyHiddenPosts: _loadedMyHiddenPosts,
        listMyCheckingPosts: _loadedMyCheckingPosts,
        openScreen: event.openScreen,
      );
    }
  }
}
