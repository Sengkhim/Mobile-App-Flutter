import 'package:flutter/material.dart';
import 'loading_grid.dart';

class GridProductLoading extends StatelessWidget {
  const GridProductLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: 180,
          margin: const EdgeInsets.all(10),
          child: const ShimmerLoadingBuilder.rectangular(width: 50, height: 50),
        ),
        ListTile(
          contentPadding: const EdgeInsets.only(left: 15, right: 10),
          title: const ShimmerLoadingBuilder.rectangular(width: 50, height: 20),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child:
                    ShimmerLoadingBuilder.rectangular(width: 150, height: 15),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(top: 4),
                child: ShimmerLoadingBuilder.rectangular(width: 80, height: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
