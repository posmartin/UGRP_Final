import 'package:get_it/get_it.dart';

/*import 'face_detection/face_detection_service.dart';
import 'face_mesh/face_mesh_service.dart';
import 'hands/hands_service.dart';*/
import 'model_inference_service.dart';
import 'pose_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<Pose>(Pose());

  locator.registerLazySingleton<ModelInferenceService>(
      () => ModelInferenceService());
}
