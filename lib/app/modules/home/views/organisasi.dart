import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tzens/app/controllers/auth_controller.dart';
import 'package:tzens/app/utils/model/dataModels.dart';
import 'package:tzens/app/utils/widget/cardPotret.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import '../controllers/home_controller.dart';

// ignore: must_be_immutable
class OrganisasiView extends GetView<HomeController> {
  AuthController? auth;
  final List<CardPotret> cards = [
    CardPotret(
      model: DataModel(
        title: "Webinar Tips Belajar Coding HTML",
        subtitle: "Minggu, 27 Januari",
        status: "GRATIS",
      ),
    ),
    CardPotret(
      model: DataModel(
        title: "Seminar Kampus Merdeka",
        subtitle: "Senin, 10 Januari",
        status: "GRATIS",
      ),
    ),
    CardPotret(
      model: DataModel(
        title: "Workshop Design UI/UX",
        subtitle: "Jumat, 30 Desember",
        status: "PAID",
      ),
    ),
    CardPotret(
      model: DataModel(
        title: "Webinar Tips Belajar UI/UX",
        subtitle: "Rabu, 15 Februari",
        status: "GRATIS",
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<CardPotret> filteredCards = List.from(cards);
    auth = Get.find<AuthController>();

    if (auth == null || auth!.user == null) {
      // Handle the case where auth or auth.user is null
      return CircularProgressIndicator(); // or any other placeholder widget
    }
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              pinned: true,
              snap: true,
              floating: true,
              expandedHeight: 230.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(
                    child: FlexibleSpaceBar(
                      centerTitle: true,
                      background: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.blue[100],
                                  ),
                                  width: 200,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.amber,
                                          ),
                                          Text(
                                            "Muhammad Wildan",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 70,
                                  height: 50,
                                  child: FilledButton(
                                    onPressed: () {},
                                    child: Icon(Icons.notification_add_sharp),
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                child: Text(
                                  "Morning, spread the benefits to many people",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 10,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Rekomendasi Untuk Anda",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      "Kumpulan ORGANISASI yang kamu minati !"),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: filteredCards
                                    .map<Widget>((card) => card)
                                    .toList(),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "ORGANISASI",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      "Kumpulan ORGANISASI yang bisa kamu ikuti ! "),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Center(
                                child: Wrap(
                                  spacing:
                                      15, // Atur jarak horizontal antara dua card
                                  runSpacing:
                                      6, // Atur jarak vertikal antara dua baris card
                                  children: filteredCards
                                      .map<Widget>((card) => card)
                                      .toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
