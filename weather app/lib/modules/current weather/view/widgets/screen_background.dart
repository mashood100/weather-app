import 'package:apis/constants/background_images.dart';
import 'package:flutter/material.dart';

class ScreenBackground extends StatelessWidget {
  final String? weatherType;
  const ScreenBackground({Key? key, required this.weatherType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (weatherType == "haze") {
      return _buildBackgroundImage(imagePath: BackgroundImages.haze);
    } else if (weatherType == "smoke") {
      return _buildBackgroundImage(imagePath: BackgroundImages.smoke);
    } else if (weatherType == "mist") {
      return _buildBackgroundImage(imagePath: BackgroundImages.mist);
    } else if (weatherType == "clear") {
      return _buildBackgroundImage(imagePath: BackgroundImages.clear);
    } else if (weatherType == "clouds") {
      return _buildBackgroundImage(imagePath: BackgroundImages.clouds);
    } else {
      return _buildBackgroundImage(imagePath: BackgroundImages.gernal);
    }
  }
}

Widget _buildBackgroundImage({required String imagePath}) {
  return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
    image: AssetImage(
      imagePath,
    ),
    fit: BoxFit.cover,
  )));
}
