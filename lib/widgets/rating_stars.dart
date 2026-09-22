import 'package:flutter/material.dart';
import 'package:eventora/styles/app_colors.dart';
import 'package:eventora/styles/app_typography.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final double size;
  final Color? color;
  final bool interactive;
  final ValueChanged<double>? onRatingChanged;

  const RatingStars({
    Key? key,
    required this.rating,
    this.size = 16,
    this.color = AppColors.luminousCaramel,
    this.interactive = false,
    this.onRatingChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        IconData iconData;
        if (rating >= index + 1) {
          iconData = Icons.star_rounded;
        } else if (rating > index && rating < index + 1) {
          iconData = Icons.star_half_rounded;
        } else {
          iconData = Icons.star_outline_rounded;
        }
        
        Widget star = Icon(
          iconData,
          size: size,
          color: color,
        );

        if (interactive) {
          return GestureDetector(
            onTap: () {
              if (onRatingChanged != null) {
                onRatingChanged!(index + 1.0);
              }
            },
            child: star,
          );
        }
        return star;
      }),
    );
  }
}
