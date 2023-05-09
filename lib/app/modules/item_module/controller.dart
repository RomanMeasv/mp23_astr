import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp23_astr/app/data/model/item.dart';
import 'package:mp23_astr/app/modules/item_module/repository.dart';

class ItemController extends GetxController {
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
    super.onInit();
    _initializeControllers();
    _initializeCamera();
    _retrieveItems();
  }

  ItemController(this.repository);

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

  _retrieveItems() {
    try {
      final retrievedItems = repository.getAll(shoppingListId);
      print("Retrieve success: $retrievedItems");
    } catch (e) {
      print("Retrieving failed");
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

  CameraController get cameraController => _cameraController;
  List<CameraDescription> get cameras => _cameras;
  Rx<CameraDescription?> get selectedCamera => _selectedCamera;
  Rx<bool> get isCameraReady => _isCameraReady;
  Rx<XFile?> get capturedImage => _capturedImage;

  final _items = RxList.empty();
  get items => _items.value;
  set items(value) => _items.value = value;
  get itemCount => items.length;
  item(index) => _items[index].value;

  saveItem() {
    try {
      String text = _textFieldController.text;
      XFile image = _capturedImage.value!;
      repository.addItem(shoppingListId, text, image);
      // print("Saving success: $newItem");
    } catch (e) {
      print("Saving failed");
    }
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
