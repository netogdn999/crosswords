abstract class AppSizes {
  static const AppBorderRadius borderRadius = AppBorderRadius();
  static const AppEdgeInsets edgeInsets = AppEdgeInsets();
  static const Dialog dialog = Dialog();
  static const Button button = Button();
}

class AppBorderRadius {
  final double borderRadiusShort = 8.0;
  final double borderRadiusMedium = 16.0;
  final double borderRadiusLarge = 31.0;

  const AppBorderRadius();
}

class AppEdgeInsets {
  final double edgeInsetsShort = 8.0;
  final double edgeInsetsMedium = 16.0;
  final double edgeInsetsLarge = 32.0;
  
  const AppEdgeInsets();
}

class Dialog {
  final double titleAsset = 60.0;
  final double contentHorizontalPadding = 16.0;
  final double contentVerticalPadding = 16.0;
  final double horizontalConstraint = 100.0;
  
  const Dialog();
}

class Button {
  final double verticalResetButton = 16.0;
  
  const Button();
}