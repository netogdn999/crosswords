import 'package:crosswords/core/constants/colors.dart';
import 'package:crosswords/core/constants/fonts.dart';
import 'package:crosswords/core/constants/sizes.dart';
import 'package:crosswords/core/data/level/model/level.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LevelCard extends StatelessWidget {
  final Level level;
  final void Function()? onClick;
  const LevelCard({
    super.key,
    required this.level,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: EdgeInsets.all(AppSizes.edgeInsets.edgeInsetsShort),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius.borderRadiusMedium),
          border: Border.all(
            color: AppColors.levels.border,
          ),
          color: AppColors.levels.background
        ),
        child: InkWell(
          onTap: onClick,
          child: AspectRatio(
            aspectRatio: 1,
            child: Center(child: Text(level.id.toString(), style: TextStyle(
              fontSize: AppFonts.levelFont.size
            ),)),
          ),
        ),
      ),
      Positioned(
        bottom: -5,
        left: 0,
        right: 0,
        child: SvgPicture.asset(level.asset),
      )
    ]);
  }
}