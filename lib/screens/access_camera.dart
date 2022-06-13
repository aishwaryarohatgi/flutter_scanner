import 'dart:math';
import 'package:flutter_camera_demo/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'camera_view.dart';
// import 'package:flutter_camera_demo/screens/camera_view.dart';

// class CameraScreen extends StatefulWidget {
//   const CameraScreen({Key? key}) : super(key: key);

//   @override
//   State<CameraScreen> createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   CameraController? _cameraController;
//   Future<void>? cameraValue;
//   bool isRecoring = false;
//   bool flash = false;
//   bool iscamerafront = true;
//   double transform = 0;

//   @override
//   void initState() {
//     //onNewCameraSelected(cameras[0]);
//     _cameraController = CameraController(cameras[0], ResolutionPreset.high);
//     cameraValue = _cameraController.initialize();
//     super.initState();

//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
//       SystemUiOverlay.bottom,
//     ]);
//   }

//   @override
//   void dispose() {
//     //controller?.dispose();
//     _cameraController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           FutureBuilder(
//               future: cameraValue,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   return SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height,
//                       child: CameraPreview(_cameraController!));
//                 } else {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               }),
//           Positioned(
//             bottom: 0.0,
//             child: Container(
//               color: Colors.black,
//               padding: const EdgeInsets.only(top: 5, bottom: 5),
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       IconButton(
//                           icon: Icon(
//                             flash ? Icons.flash_on : Icons.flash_off,
//                             color: Colors.white,
//                             size: 28,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               flash = !flash;
//                             });
//                             flash
//                                 ? _cameraController
//                                     ?.setFlashMode(FlashMode.torch)
//                                 : _cameraController?.setFlashMode(FlashMode.off);
//                           }),
//                       GestureDetector(
//                         onTap: () {
//                           takePhoto(context);
//                         },
//                       ),
//                       IconButton(
//                           icon: Transform.rotate(
//                             angle: transform,
//                             child: const Icon(
//                               Icons.flip_camera_ios,
//                               color: Colors.white,
//                               size: 28,
//                             ),
//                           ),
//                           onPressed: () async {
//                             setState(() {
//                               iscamerafront = !iscamerafront;
//                               transform = transform + pi;
//                             });
//                             int cameraPos = iscamerafront ? 0 : 1;
//                             _cameraController = CameraController(
//                                 cameras[cameraPos], ResolutionPreset.high);
//                             cameraValue = _cameraController?.initialize();
//                           }),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 4,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void takePhoto(BuildContext context) async {
//     XFile? file = await _cameraController?.takePicture();
//     if (!mounted) return;
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (builder) => CameraViewPage(
//                   path: file.path,
//                 )));
//   //   Navigator.of(context).push(MaterialPageRoute(
//   //       builder: (builder) => CameraViewPage(
//   //             path: file.path,
//   //           )));
//   }

// }

class AccessCamera extends StatefulWidget {
  const AccessCamera({Key? key}) : super(key: key);

  @override
  State<AccessCamera> createState() => _AccessCameraState();
}

class _AccessCameraState extends State<AccessCamera> {
  CameraController? _cameraController;
  Future<void>? cameraValue;
  bool isRecoring = false;
  bool flash = false;
  bool iscamerafront = true;
  double transform = 0;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _cameraController?.initialize();
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CameraPreview(_cameraController!));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          Positioned(
            bottom: 0.0,
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          icon: Icon(
                            flash ? Icons.flash_on : Icons.flash_off,
                            color: Colors.white,
                            size: 28,
                          ),
                          onPressed: () {
                            setState(() {
                              flash = !flash;
                            });
                            flash
                                ? _cameraController
                                    ?.setFlashMode(FlashMode.torch)
                                : _cameraController
                                    ?.setFlashMode(FlashMode.off);
                          }),
                      GestureDetector(
                        onTap: () {
                          // takePhoto(context);
                        },
                      ),
                      IconButton(
                          icon: Transform.rotate(
                            angle: transform,
                            child: const Icon(
                              Icons.flip_camera_ios,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              iscamerafront = !iscamerafront;
                              transform = transform + pi;
                            });
                            int cameraPos = iscamerafront ? 0 : 1;
                            _cameraController = CameraController(
                                cameras[cameraPos], ResolutionPreset.high);
                            cameraValue = _cameraController?.initialize();
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void takePhoto(BuildContext context) async {
    XFile? file = await _cameraController?.takePicture();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => CameraViewPage(
                  path: file!.path,
                )));
  }
}
