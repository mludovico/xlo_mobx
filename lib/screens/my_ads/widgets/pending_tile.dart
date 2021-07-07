import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/screens/ad_screen/ad_screen.dart';

class PendingTile extends StatelessWidget {
  final Ad ad;
  PendingTile(this.ad);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AdScreen(ad),
          ),
        );
      },
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 80,
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ad.images.isEmpty
                    ? Icon(
                        Icons.image,
                        color: Colors.grey[300],
                        size: 127,
                      )
                    : CachedNetworkImage(
                        imageUrl: ad.images.first,
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      ad.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      ad.price.formattedMoney(),
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.alarm,
                          color: Colors.orange,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Aguardando publicação',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
