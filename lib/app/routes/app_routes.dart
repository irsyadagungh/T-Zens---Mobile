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
      case _Paths.PROFILE:
        return 'Profile';
      case _Paths.ADD:
        return 'Add';
      case _Paths.DETAIL_PAGE:
        return 'Detail Page';
      case _Paths.PROFIL_PAGE:
        return 'Profil Page';
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
  static const PROFILE = _Paths.PROFILE;
  static const ADD = _Paths.ADD;
  static const DETAIL_PAGE = _Paths.DETAIL_PAGE;
  static const PROFIL_PAGE = _Paths.PROFIL_PAGE;
  static const ORGANISASI_PROVIDER = _Paths.ORGANISASI_PROVIDER;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const INTRODUCTION = '/introduction';
  static const WELCOME = '/welcome';
  static const REGISTER = '/register';
  static const LOGIN = '/login';
  static const HOME_PROVIDER = '/home-provider';
  static const PROFILE = '/profile';
  static const ADD = '/add';
  static const DETAIL_PAGE = '/detail-page';
  static const PROFIL_PAGE = '/profil-page';
  static const ORGANISASI_PROVIDER = '/organisasi-provider';
}
