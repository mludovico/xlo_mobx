import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:xlo_mobx/models/ad.dart';

class DescriptionPanel extends StatelessWidget {
  final Ad ad;
  DescriptionPanel(this.ad);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Text(
            'Descrição',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: ReadMoreText(
            ad.description,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            trimLines: 2,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Ver mais',
            trimExpandedText: 'Ver menos',
          ),
          // child: Text('Descricao muito comprida'),
        )
      ],
    );
  }
}
