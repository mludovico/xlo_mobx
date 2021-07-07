import 'package:flutter/material.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/helpers/extensions.dart';

class UserPanel extends StatelessWidget {
  final Ad ad;
  UserPanel(this.ad);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 18,
            bottom: 12,
          ),
          child: Text(
            'Anunciante',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.grey[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ad.user.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Na XLO desde ${ad.user.createdAt.toDMHm()}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
