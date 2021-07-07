import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/screens/ad_screen/widgets/bottom_bar.dart';
import 'package:xlo_mobx/screens/ad_screen/widgets/description_panel.dart';
import 'package:xlo_mobx/screens/ad_screen/widgets/location_panel.dart';
import 'package:xlo_mobx/screens/ad_screen/widgets/main_panel.dart';
import 'package:xlo_mobx/screens/ad_screen/widgets/user_panel.dart';

class AdScreen extends StatelessWidget {
  AdScreen(this.ad);
  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Anúncio'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                height: 200,
                child: Carousel(
                  images: ad.images
                      .map((url) => CachedNetworkImageProvider(url))
                      .toList(),
                  dotSize: 4,
                  dotBgColor: Colors.transparent,
                  dotColor: Colors.orange,
                  autoplay: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: MainPanel(
                  ad,
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DescriptionPanel(ad),
              ),
              Divider(
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: LocationPanel(ad),
              ),
              Divider(
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: UserPanel(ad),
              ),
              SizedBox(
                height: ad.status == AdStatus.PENDING ? 16 : 120,
              ),
            ],
          ),
          BottomBar(ad),
        ],
      ),
    );
  }
}
