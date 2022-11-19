import 'dart:io';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class BrainTumor extends StatefulWidget {
  const BrainTumor({Key? key}) : super(key: key);

  @override
  State<BrainTumor> createState() => _BrainTumorState();
}

class _BrainTumorState extends State<BrainTumor> {
  bool _isLoading = true;
  bool isGet = false;
  late File _image;
  late List _output;

  getImageFromUser() async {
    _image = (await PickImage.getImage())!;
    _output = await Model.runModelBrainTumorDetection(_image);
    setState(() {
      isGet = true;
    });

  }


  @override
  void initState() {
    super.initState();
    Model.loadModelBrainTumorDetection().then((value) {
      _isLoading = false;
      _image = File('assets/logo.png');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0f3570),
        title: const Text('MedicAid'),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xffffffff),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isGet ?
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(_image), fit: BoxFit.cover),
              ),
            ):Image.asset('assets/upload.gif'),
            isGet ?
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _output[0]['label'] == '1 Yes'
                    ? "No Brain Tumor Detected."
                    : "We detected Brain Tumor in the MRI, consult doctor ASAP and take proper medication.",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ):const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Please upload an image of your MRI with a white background.",
                textAlign: TextAlign.center,
                ),
            ),
          Container(
            width: 300,
            child: OutlinedButton.icon(
              onPressed: () {
                getImageFromUser();
              },
              icon: const Icon(Icons.add_photo_alternate),
              label: const Text("Choose Image"),
            ),
          ),
          ],
        ),
      ),
    );
  }

}


abstract class PickImage {
  static Future<File?> getImage() async {
    var selectedImage =
    await ImagePicker().getImage(source: ImageSource.gallery);
    if (selectedImage == null) return null;
    File image = File(selectedImage.path);
    return image;
  }
}

abstract class Model {
  static Future<String?> loadModelBrainTumorDetection() async {
    return await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt");
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