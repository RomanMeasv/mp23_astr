import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/camera_module/repository.dart';

class CameraPageController extends GetxController {
  final args = Get.arguments;
  final CameraRepository repository;
  CameraPageController(this.repository);

  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  late Rx<CameraDescription?> _selectedCamera;
  late Rx<bool> _isCameraReady;
  late Rx<XFile?> _capturedImage;

  @override
  void onInit() {
    _initializeCamera();
    super.onInit();
  }

  Future<void> _initializeCamera() async {
    _resetCameraFields();
    _cameras = await availableCameras();
    if (_cameras.isNotEmpty) {
      _selectedCamera.value = _cameras[0];
      _cameraController = CameraController(
        _selectedCamera.value!,
        ResolutionPreset.ultraHigh,
      );
      await _cameraController.initialize();
      _isCameraReady.value = true;
    }
  }

  Future<void> captureImage() async {
    if (!_isCameraReady.value) return;

    try {
      // take image from camera controller
      final XFile capturedFile = await _cameraController.takePicture();
      _capturedImage.value = capturedFile;

      // save image in firestorage and firestore
      final imageUrl = await repository.addImage(
          args["ShoppingListId"], args["Item"], capturedFile);

      // return to the previous page
      Get.back();
    } catch (e) {
      print('Error capturing image (captureImage): $e');
    }
  }

  _resetCameraFields() {
    _selectedCamera = Rx<CameraDescription?>(null);
    _isCameraReady = Rx<bool>(false);
    _capturedImage = Rx<XFile?>(null);
  }

  CameraController get cameraController => _cameraController;
  List<CameraDescription> get cameras => _cameras;
  Rx<CameraDescription?> get selectedCamera => _selectedCamera;
  Rx<bool> get isCameraReady => _isCameraReady;
  Rx<XFile?> get capturedImage => _capturedImage;

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  // final _obj = ''.obs;
  // set obj(value) => this._obj.value = value;
  // get obj => this._obj.value;
}
