import 'package:crosswords/core/constants/colors.dart';
import 'package:crosswords/core/constants/fonts.dart';
import 'package:crosswords/core/constants/sizes.dart';
import 'package:crosswords/core/constants/strings.dart';
import 'package:crosswords/core/data/level/model/level.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessageDialog extends StatelessWidget {
  final Level level;
  
  const MessageDialog({
    super.key,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.dialog.background,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      shadowColor: AppColors.dialog.shadow,
      surfaceTintColor: AppColors.dialog.surface,
      title: SvgPicture.asset(
        level.asset,
        height: AppSizes.dialog.titleAsset,
      ),
      content: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.dialog.contentHorizontalPadding,
          vertical: AppSizes.dialog.contentVerticalPadding,
        ),
        constraints: BoxConstraints.tightFor(
          width: AppSizes.dialog.horizontalConstraint,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius.borderRadiusMedium),
          color: AppColors.dialog.contentBackground,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.dialog.title,
              style: TextStyle(
                fontSize: AppFonts.dialog.titleSize,
              ),
            ),
            SizedBox(
              height: AppSizes.edgeInsets.edgeInsetsShort,
            ),
            Text(level.message),
          ],
        ),
      ),
      buttonPadding: EdgeInsets.zero,
    );
  }
}
