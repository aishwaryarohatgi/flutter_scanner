import 'dart:math';
import 'package:flutter_camera_demo/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'camera_view.dart';

class AccessCamera extends StatefulWidget {
  const AccessCamera({Key? key}) : super(key: key);

  @override
  State<AccessCamera> createState() => _AccessCameraState();
}

class _AccessCameraState extends State<AccessCamera> {
  CameraController? _cameraController;
  Future<void>? cameraValue;
  bool flash = false;
  bool isCameraFront = true;
  // double transform = 0;

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
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
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
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      flash = !flash;
                    });
                    flash
                        ? _cameraController?.setFlashMode(FlashMode.torch)
                        : _cameraController?.setFlashMode(FlashMode.off);
                  },
                  icon: Icon(flash ? Icons.flash_on : Icons.flash_off)),
              IconButton(
                  onPressed: () {takePhoto(context);},
                  icon: const Icon(Icons.camera)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      isCameraFront = !isCameraFront;
                    });
                    int cameraPos = isCameraFront ? 0 : 1;
                    _cameraController = CameraController(
                        cameras[cameraPos], ResolutionPreset.high);
                    cameraValue = _cameraController?.initialize();
                  },
                  icon: const Icon(Icons.flip_camera_ios)),
            ],
          ),
        ],
      ),
      // body: Stack(
      //   children: [
      //     FutureBuilder(
      //         future: cameraValue,
      //         builder: (context, snapshot) {
      //           if (snapshot.connectionState == ConnectionState.done) {
      //             return SizedBox(
      //                 width: MediaQuery.of(context).size.width,
      //                 height: MediaQuery.of(context).size.height,
      //                 child: CameraPreview(_cameraController!));
      //           } else {
      //             return const Center(
      //               child: CircularProgressIndicator(),
      //             );
      //           }
      //         }),
      //     Positioned(
      //       bottom: 0.0,
      //       child: Column(
      //         children: [
      //           Row(
      //             mainAxisSize: MainAxisSize.max,
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             children: [
      //               IconButton(
      //                   icon: Icon(
      //                     flash ? Icons.flash_on : Icons.flash_off,
      //                     color: Colors.white,
      //                     size: 28,
      //                   ),
      //                   onPressed: () {
      //                     setState(() {
      //                       flash = !flash;
      //                     });
      //                     flash
      //                         ? _cameraController?.setFlashMode(FlashMode.torch)
      //                         : _cameraController?.setFlashMode(FlashMode.off);
      //                   }),
      //               GestureDetector(
      //                 onTap: () {
      //                   // takePhoto(context);
      //                   XFile? file =
      //                       _cameraController?.takePicture() as XFile?;
      //                   Navigator.of(context).push(MaterialPageRoute(
      //                       builder: (context) => CameraViewPage(
      //                             path: file!.path,
      //                           )));
      //                 },
      //               ),
      //               IconButton(
      //                   icon: const Icon(
      //                       Icons.flip_camera_ios,
      //                       color: Colors.white,
      //                     ),
      //                   onPressed: () async {
      //                     setState(() {
      //                       isCameraFront = !isCameraFront;
      //                       // transform = transform + pi;
      //                     });
      //                     int cameraPos = isCameraFront ? 0 : 1;
      //                     _cameraController = CameraController(
      //                         cameras[cameraPos], ResolutionPreset.high);
      //                     cameraValue = _cameraController?.initialize();
      //                   }),
      //             ],
      //           )
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
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
