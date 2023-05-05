import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/modules/item_module/repository.dart';

class ItemController extends GetxController {
  final ItemRepository repository;

  final _horizontalController = PageController();
  final _verticalController =
      PageController(initialPage: 1); // (1) starts on carousel

  final _textFieldController = TextEditingController();
  final Rx<bool> _isTextFieldVisible = Rx<bool>(false);

  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  late Rx<CameraDescription?> _selectedCamera;
  late Rx<bool> _isCameraReady;
  late Rx<XFile?> _capturedImage;

  @override
  void onInit() {
    super.onInit();
    _selectedCamera = Rx<CameraDescription?>(null);
    _isCameraReady = Rx<bool>(false);
    _capturedImage = Rx<XFile?>(null);
    _initializeCamera();
  }

  ItemController(this.repository) {
    repository.getAll();
  }

  Future<void> _initializeCamera() async {
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
      final XFile? capturedFile = await _cameraController.takePicture();
      _capturedImage.value = capturedFile;
    } catch (e) {
      print('Error capturing image (captureImage): $e');
    }
  }

  PageController get verticalController => _verticalController;
  PageController get horizontalController => _horizontalController;

  TextEditingController get textFieldController => _textFieldController;
  get isTextFieldVisible => _isTextFieldVisible.value;
  set isTextFieldVisible(value) => _isTextFieldVisible.value = value;

  CameraController get cameraController => _cameraController;
  List<CameraDescription> get cameras => _cameras;
  Rx<CameraDescription?> get selectedCamera => _selectedCamera;
  Rx<bool> get isCameraReady => _isCameraReady;
  Rx<XFile?> get capturedImage => _capturedImage;

  // final _obj = ''.obs;
  // set obj(value) => this._obj.value = value;
  // get obj => this._obj.value;

  final _items = RxList.empty();
  get items => _items.value;
  set items(value) => _items.value = value;
  get itemCount => items.length;
  item(index) => _items[index].value;

  @override
  void dispose() {
    _cameraController.dispose();
    _textFieldController.dispose();
    _verticalController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }
}
