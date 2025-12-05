import 'package:get/get.dart';

import 'package:tzens/app/data/models/organization_model_model.dart';
import 'package:tzens/app/modules/history_page_organization/bindings/history_page_organization_binding.dart';
import 'package:tzens/app/modules/history_page_organization/views/history_page_organization_view.dart';
import 'package:tzens/app/modules/notification/bindings/notification_binding.dart';
import 'package:tzens/app/modules/notification/views/notification_view.dart';

import '../data/models/webinar_model_model.dart';
import '../modules/add/bindings/add_binding.dart';
import '../modules/add/views/add_view.dart';
import '../modules/addOrganisasi/bindings/add_organisasi_binding.dart';
import '../modules/addOrganisasi/views/add_organisasi_view.dart';
import '../modules/bookmark/bindings/bookmark_binding.dart';
import '../modules/bookmark/views/bookmark_view.dart';
import '../modules/detailPageOrganisasi/bindings/detail_page_organisasi_binding.dart';
import '../modules/detailPageOrganisasi/views/detail_page_organisasi_view.dart';
import '../modules/detail_history/bindings/detail_history_binding.dart';
import '../modules/detail_history/views/detail_history_view.dart';
import '../modules/detail_page/bindings/detail_page_binding.dart';
import '../modules/detail_page/views/detail_page_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home_provider/bindings/home_provider_binding.dart';
import '../modules/home_provider/views/home_provider_view.dart';
import '../modules/introduction/bindings/introduction_binding.dart';
import '../modules/introduction/views/introduction_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/search_page/bindings/search_page_binding.dart';
import '../modules/search_page/views/search_page_view.dart';
import '../modules/welcome/bindings/welcome_binding.dart';
import '../modules/welcome/views/welcome_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const INITIAL = Routes.HOME;
  static final WebinarModel model = WebinarModel();
  static final OrganizationModel modelOrganisasi = OrganizationModel();

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INTRODUCTION,
      page: () => IntroductionView(),
      binding: IntroductionBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME_PROVIDER,
      page: () => HomeProviderView(),
      binding: HomeProviderBinding(),
    ),
    GetPage(
      name: _Paths.ADD,
      page: () => AddView(model: model),
      binding: AddBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PAGE,
      page: () => DetailPageView(model: model),
      binding: DetailPageBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_PAGE,
      page: () => SearchPageView(),
      binding: SearchPageBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.BOOKMARK,
      page: () => BookmarkView(),
      binding: BookmarkBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_HISTORY,
      page: () => DetailHistoryView(),
      binding: DetailHistoryBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ORGANISASI,
      page: () => AddOrganisasiView(
        model: modelOrganisasi,
      ),
      binding: AddOrganisasiBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PAGE_ORGANISASI,
      page: () => DetailPageOrganisasiView(
        model: modelOrganisasi,
      ),
      binding: DetailPageOrganisasiBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY_PAGE_ORGANIZATION,
      page: () => HistoryPageOrganizationView(),
      binding: HistoryPageOrganizationBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => NotificationView(),
      binding: NotificationBinding(),
    ),
  ];
}
