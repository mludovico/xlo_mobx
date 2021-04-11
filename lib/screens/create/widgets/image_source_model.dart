import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceModel extends StatelessWidget {
  final Function(File) onImageSelected;

  ImageSourceModel({this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid)
      return BottomSheet(
        onClosing: () {},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              onPressed: getFromCamera,
              child: Text('Camera'),
            ),
            TextButton(
              onPressed: getFromGallery,
              child: Text('Galeria'),
            )
          ],
        ),
      );
    else
      return CupertinoActionSheet(
        title: Text('Selecionar foto para o anúncio'),
        message: Text('Escolha a origem da foto'),
        cancelButton: CupertinoActionSheetAction(
          child: const Text(
            'Cancelar',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: Navigator.of(context).pop,
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: getFromCamera,
            child: Text('Camera'),
          ),
          CupertinoActionSheetAction(
            onPressed: getFromGallery,
            child: Text('Galeria'),
          ),
        ],
      );
  }

  Future<void> getFromCamera() async {
    final pickedImage = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedImage == null) return;
    final File image = File(pickedImage.path);
    imageCrop(image);
  }

  Future<void> getFromGallery() async {
    final pickedImage = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    final File image = File(pickedImage.path);
    imageCrop(image);
  }

  Future<void> imageCrop(File image) async {
    final croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(
        ratioX: 1,
        ratioY: 1,
      ),
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Editar Imagem',
        toolbarColor: Colors.purple,
        toolbarWidgetColor: Colors.white,
      ),
      iosUiSettings: IOSUiSettings(
        title: 'Editar Imagem',
        cancelButtonTitle: 'Cancelar',
        doneButtonTitle: 'Concluir',
      ),
    );
    if (croppedFile != null) onImageSelected(croppedFile);
  }
}
