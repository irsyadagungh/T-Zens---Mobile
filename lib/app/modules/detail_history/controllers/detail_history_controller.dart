import 'package:get/get.dart';
import 'package:tzens/app/controllers/content_controller.dart';
import 'package:tzens/app/data/models/webinar_model_model.dart';

class DetailHistoryController extends GetxController {

  ContentController content = Get.find<ContentController>();
  String eventId = Get.arguments as String;
  RxBool isLoading = false.obs;
  Rx<WebinarModel> webinar = Rx<WebinarModel>(WebinarModel());


  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    await content.readHistoryById(eventId).then((value) {
      webinar = value;
      isLoading.value = false;
      print("isLoading: ${isLoading.value}");
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
