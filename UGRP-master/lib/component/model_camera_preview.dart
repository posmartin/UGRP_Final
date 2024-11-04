import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'model_inference_service.dart';
import 'service_locator.dart';
/*import 'face_detection_painter.dart';
import 'face_mesh_painter.dart';
import 'hands_painter.dart';*/
import 'lunge_painter.dart';
import 'side_painter.dart';
import 'squat_painter.dart';

class ModelCameraPreview extends StatelessWidget {
  ModelCameraPreview({
    required this.cameraController,
    required this.index,
    required this.draw,
    Key? key,
  }) : super(key: key);

  final CameraController? cameraController;
  final int index;
  final bool draw;

  late final double _ratio;
  final Map<String, dynamic>? inferenceResults =
      locator<ModelInferenceService>().inferenceResults;



  @override
  Widget build(BuildContext context) {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final screenSize = MediaQuery.of(context).size;
    _ratio = screenSize.width / cameraController!.value.previewSize!.height;

    print(inferenceResults == null ? 'inferenceresults is null' : 'inferenceresults is ${inferenceResults?.length}');
    print('index is ${index}');


    return Stack(
      children: [
        CameraPreview(cameraController!),
        Visibility(
          visible: draw,
          child: IndexedStack(
            index: index,
            children: [
              _drawLunge,
              _drawSide,
              _drawSquat,
            ],
          ),
        ),
      ],
    );
  }

  Widget get _drawLunge => _ModelPainter(
    customPainter: LungePainter(
      points: inferenceResults?['point'] ?? [],
      ratio: _ratio,
    ),
  );

  Widget get _drawSide => _ModelPainter(
    customPainter: SidePainter(
      points: inferenceResults?['point'] ?? [],
      ratio: _ratio,
    ),
  );

  Widget get _drawSquat => _ModelPainter(
    customPainter: SquatPainter(
      points: inferenceResults?['point'] ?? [],
      ratio: _ratio,
    ),
  );
}

class _ModelPainter extends StatelessWidget {
  _ModelPainter({
    required this.customPainter,
    Key? key,
  }) : super(key: key);

  final CustomPainter customPainter;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: customPainter,
    );
  }
}