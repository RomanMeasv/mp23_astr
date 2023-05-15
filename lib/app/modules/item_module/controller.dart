import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/data/model/item.dart';
import 'package:mp23_astr/app/modules/item_module/repository.dart';
import 'package:mp23_astr/app/modules/shopping_list_menu_module/controller.dart';

class ItemController extends GetxController with StateMixin<List<ItemModel>> {
  final ItemRepository repository;

  late PageController _horizontalController;
  late PageController _verticalController;

  late TextEditingController _textFieldController;

  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  late Rx<CameraDescription?> _selectedCamera;
  late Rx<bool> _isCameraReady;
  late Rx<XFile?> _capturedImage;

  final shoppingListId = "W1FcrBpQwEAvDm41Pz4X";

  @override
  void onInit() {
    _retrieveAllItems();
    _initializeControllers();
    _initializeCamera();
    super.onInit();
  }

  ItemController(this.repository);

  PageController get verticalController => _verticalController;
  PageController get horizontalController => _horizontalController;

  TextEditingController get textFieldController => _textFieldController;

  CameraController get cameraController => _cameraController;
  List<CameraDescription> get cameras => _cameras;
  Rx<CameraDescription?> get selectedCamera => _selectedCamera;
  Rx<bool> get isCameraReady => _isCameraReady;
  Rx<XFile?> get capturedImage => _capturedImage;

  Future<void> captureImage() async {
    if (!_isCameraReady.value) return;

    try {
      final XFile capturedFile = await _cameraController.takePicture();
      _capturedImage.value = capturedFile;
    } catch (e) {
      print('Error capturing image (captureImage): $e');
    }
  }

  saveItem() async {
    String text = _textFieldController.text;
    XFile image = _capturedImage.value!;
    //append(repository.addItem(shoppingListId, text, image))
  }

  _initializeControllers() {
    _horizontalController = PageController();
    _verticalController =
        PageController(initialPage: 1); // (1) starts on carousel
    _textFieldController = TextEditingController();
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

  _resetCameraFields() {
    _selectedCamera = Rx<CameraDescription?>(null);
    _isCameraReady = Rx<bool>(false);
    _capturedImage = Rx<XFile?>(null);
  }

  _retrieveAllItems() {
    repository.getAll(shoppingListId).then((resp) {
      change(resp, status: RxStatus.success());
    }, onError: (err) {
      change(
        null,
        status: RxStatus.error(err.toString()),
      );
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _textFieldController.dispose();
    _verticalController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }
}
