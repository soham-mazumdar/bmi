import 'package:flutter/material.dart';

InputDecoration getInputDecoration(level) {
  return InputDecoration(
    labelText: level,
    labelStyle: TextStyle(color: AppColors.primaryColor),
    enabledBorder: new OutlineInputBorder(
      borderRadius: new BorderRadius.circular(5.0),
      borderSide: new BorderSide(color: AppColors.primaryColor),
    ),
    border: new OutlineInputBorder(
      borderRadius: new BorderRadius.circular(5.0),
      borderSide: new BorderSide(),
    ),
  );
}

BoxDecoration getBoxedContainerDecoration() => BoxDecoration(
  border: Border.all(width: 1,color: AppColors.primaryColor),
  borderRadius: BorderRadius.circular(5),
);

EdgeInsets getBoxedContainerMargin() => EdgeInsets.only(top:20);

EdgeInsets getBoxedContainerPadding() => EdgeInsets.all(10);

double getBoxedContainerWidth(context) => MediaQuery.of(context).size.width;

class AppColors{
	static final MaterialColor primaryColor = createSwatch(62, 222, 158, 1);  
  static final MaterialColor canvasColor = createSwatch(33, 50, 58, 1);
}

MaterialColor createSwatch(int r, int g, int b, double o){
	Map<int, Color> swatch = {};
	List<int> opacities = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
	for(int opacity in opacities)
		swatch[opacity] = Color.fromRGBO(r, g, b, opacity/1000);
	return MaterialColor(
		Color.fromRGBO(r, g, b, o).value,
		swatch
	);
}

class AppTextStyle {
  static final TextStyle labelTextStyle = TextStyle(fontSize: 16, color: AppColors.primaryColor);
  static final TextStyle formulaHeadingTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.primaryColor);
  static final TextStyle formulaTextStyle = TextStyle(fontSize: 16, color: AppColors.primaryColor);
}