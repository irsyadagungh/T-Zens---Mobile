part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  static getTitleFromRoute(String route) {
    switch (route) {
      case _Paths.HOME:
        return 'Home';
      case _Paths.INTRODUCTION:
        return 'Introduction';
      case _Paths.WELCOME:
        return 'Welcome';
      case _Paths.REGISTER:
        return 'Register';
      case _Paths.LOGIN:
        return 'Login';
      case _Paths.HOME_PROVIDER:
        return 'Home Provider';
      case _Paths.ADD:
        return 'Add';
      case _Paths.DETAIL_PAGE:
        return 'Detail Page';
      case _Paths.PROFILE:
        return 'Profile';
      case _Paths.EDIT_PROFILE:
        return 'Edit Profile';
      case _Paths.BOOKMARK:
        return 'Bookmark';
      default:
        return 'Judul Default';
    }
  }

  Routes._();
  static const HOME = _Paths.HOME;
  static const INTRODUCTION = _Paths.INTRODUCTION;
  static const WELCOME = _Paths.WELCOME;
  static const REGISTER = _Paths.REGISTER;
  static const LOGIN = _Paths.LOGIN;
  static const HOME_PROVIDER = _Paths.HOME_PROVIDER;
  static const ADD = _Paths.ADD;
  static const DETAIL_PAGE = _Paths.DETAIL_PAGE;
  static const ORGANISASI_PROVIDER = _Paths.ORGANISASI_PROVIDER;
  static const SEARCH_PAGE = _Paths.SEARCH_PAGE;
  static const PROFILE = _Paths.PROFILE;
  static const EDIT_PROFILE = _Paths.EDIT_PROFILE;
  static const BOOKMARK_USER = _Paths.BOOKMARK_USER;
  static const BOOKMARK = _Paths.BOOKMARK;
  static const HISTORY = _Paths.HISTORY;
  static const DETAIL_HISTORY = _Paths.DETAIL_HISTORY;
  static const ADD_ORGANISASI = _Paths.ADD_ORGANISASI;
  static const DETAIL_PAGE_ORGANISASI = _Paths.DETAIL_PAGE_ORGANISASI;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const INTRODUCTION = '/introduction';
  static const WELCOME = '/welcome';
  static const REGISTER = '/register';
  static const LOGIN = '/login';
  static const HOME_PROVIDER = '/home-provider';
  static const ADD = '/add';
  static const DETAIL_PAGE = '/detail-page';
  static const ORGANISASI_PROVIDER = '/organisasi-provider';
  static const SEARCH_PAGE = '/search-page';
  static const PROFILE = '/ProfileView';
  static const EDIT_PROFILE = '/edit-profile';
  static const BOOKMARK_USER = '/bookmark-user';
  static const BOOKMARK = '/bookmark';
  static const HISTORY = '/history';
  static const DETAIL_HISTORY = '/detail-history';
  static const ADD_ORGANISASI = '/add-organisasi';
  static const DETAIL_PAGE_ORGANISASI = '/detail-page-organisasi';
}
