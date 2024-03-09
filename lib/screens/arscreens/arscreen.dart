// import 'dart:io';
// import 'dart:typed_data';
// import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
// import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
// import 'package:ar_flutter_plugin/models/ar_node.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// import 'package:path_provider/path_provider.dart';
//
// class ARScreen extends StatefulWidget {
//   @override
//   _ARScreenState createState() => _ARScreenState();
// }
//
// class _ARScreenState extends State<ARScreen> {
//   late List<CameraDescription> cameras;
//   late CameraController controller;
//   late ARSessionManager arSessionManager;
//   late ARObjectManager arObjectManager;
//   late ARNode arNode;
//   late File _stickerFile;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeAR();
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     // arSessionManager.dispose();
//     super.dispose();
//   }
//
//   void _initializeAR() async {
//     cameras = await availableCameras();
//     controller = CameraController(cameras[0], ResolutionPreset.medium);
//     await controller.initialize();
//
//     arSessionManager = ARSessionManager(
//       onARViewCreated: (arController, arObjectManager, arAnchorManager, arLocationManager) {
//         this.arObjectManager = arObjectManager;
//         arNode = ARNode(
//           geometry: ARBox(size: Vector3(0.2, 0.2, 0.001)),
//           position: Vector3(0, 0, -1),
//           rotation: Vector4(0, 0, 0, 0),
//           scale: Vector3(1, 1, 1),
//         );
//         arObjectManager.addNode(arNode);
//       },
//     );
//
//     _stickerFile = await _loadSticker();
//   }
//
//   Future<File> _loadSticker() async {
//     final picker = ImagePicker();
//     final image = await picker.pickImage(source: ImageSource.gallery);
//     if (image == null) {
//       throw Exception('Failed to load sticker image');
//     }
//     return File(image.path!);
//   }
//
//   Future<void> _onTryWithARPressed() async {
//     final screenShot = await arObjectManager.captureImage();
//     final filePath = await _saveImage(screenShot);
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('AR Image'),
//         content: Image.file(File(filePath)),
//       ),
//     );
//   }
//
//   Future<String> _saveImage(Uint8List imageBytes) async {
//     final directory = await getTemporaryDirectory();
//     final filePath = '${directory.path}/ar_image.png';
//     await File(filePath).writeAsBytes(imageBytes);
//     return filePath;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('AR Screen'),
//       ),
//       body: Center(
//         child: ARView(
//           onARViewCreated: arSessionManager.onARViewCreated,
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _onTryWithARPressed,
//         child: Icon(Icons.camera),
//       ),
//     );
//   }
// }
//
//
