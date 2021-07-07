import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xlo_mobx/models/ad.dart';

class BottomBar extends StatelessWidget {
  final Ad ad;
  BottomBar(this.ad);
  bool get pending => this.ad.status == AdStatus.PENDING;

  @override
  Widget build(BuildContext context) {
    if (pending) return Container();
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 26),
            height: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19),
              color: Colors.orange,
            ),
            child: Row(
              children: [
                if (!ad.hidePhone)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        final phone =
                            ad.user.phone.replaceAll(RegExp('[^0-9]'), '');
                        launch('tel:$phone');
                      },
                      child: Text(
                        'Ligar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                if (!ad.hidePhone)
                  VerticalDivider(
                    color: Colors.black45,
                    indent: 6,
                    endIndent: 6,
                  ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Chat',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(249, 249, 249, 1),
              border: Border(
                top: BorderSide(
                  color: Colors.grey[400],
                ),
              ),
            ),
            height: 38,
            alignment: Alignment.center,
            child: Text(
              '${ad.user.name} (anunciante)',
              style: TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
