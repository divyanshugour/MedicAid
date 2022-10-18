import 'dart:io';
import 'package:tflite/tflite.dart';

abstract class Model {
  static Future<String> loadModelBrainTumorDetection() async {
    return await Tflite.loadModel(
        model: "assets/tflite_brain_tumor/model_unquant.tflite",
        labels: "assets/tflite_brain_tumor/labels.txt");
  }

  static Future<List<dynamic>> runModelBrainTumorDetection(File image) async {
    var output;
    try {
      output = await Tflite.runModelOnImage(
          path: image.path,
          imageMean: 127.5,
          imageStd: 127.5,
          threshold: 0.5,
          numResults: 2);
    } catch (e) {
      print("This is an error from method runModelBrainTumorDetection : " +
          e.toString());
    }

    return output;
  }
}
