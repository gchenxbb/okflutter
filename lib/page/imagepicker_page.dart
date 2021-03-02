import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ImagePickerPage extends StatefulWidget {
  final String title;

  ImagePickerPage({Key key, this.title}) : super(key: key);

  @override
  _ImagePickerPageState createState() => new _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  VideoPlayerController _controller;
  VideoPlayerController _toBeDisposed;
  bool isVideo = false;
  PickedFile _imageFile;
  dynamic _pickImageError;
  String _retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed.dispose();
    }
    _toBeDisposed = _controller;
    _controller = null;
  }

  @override
  void dispose() {
    _disposeVideoController();
    maxWidthController.dispose();
    maxHeightController.dispose();
    qualityController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller.setVolume(0);
      _controller.pause();
    }
    super.deactivate();
  }



  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    if (_controller != null) {
      await _controller.setVolume(0);
    }
    if (isVideo) {
      final PickedFile file = await _picker.getVideo(
          source: source, maxDuration: const Duration(seconds: 10));
      await _playVideo(file);
    } else {
      await _displayPickImageDialog(context,
          (maxWidth, maxHeight, quality) async {
        try {
          final pickedFile = await _picker.getImage(
              source: source,
              maxHeight: maxHeight,
              maxWidth: maxWidth,
              imageQuality: quality);
          setState(() {
            _imageFile = pickedFile;
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      });
    }
  }

  Future<void> _playVideo(PickedFile file) async {
    if (file != null && mounted) {
      await _disposeVideoController();
      if (kIsWeb) {
        _controller = VideoPlayerController.network(file.path);
        await _controller.setVolume(0);
      } else {
        _controller = VideoPlayerController.file(File(file.path));
        await _controller.setVolume(1.0);
      }

      await _controller.initialize();
      await _controller.setLooping(true);
      await _controller.play();
      setState(() {});
    }
  }

  /**
   * 图片大小和质量限制
   */
  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Optional Parameters'),
            content: Column(
              children: <Widget>[
                TextField(
                  controller: maxWidthController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration:
                      InputDecoration(hintText: "enter maxwidth if desired"),
                ),
                TextField(
                  controller: maxHeightController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration:
                      InputDecoration(hintText: "enter maxheight if desired"),
                ),
                TextField(
                  controller: qualityController,
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(hintText: "enter quality if desired"),
                ),
              ],
            ),
            actions: <Widget>[
              RaisedButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              RaisedButton(
                child: const Text('Pick'),
                onPressed: () {
                  double width = maxWidthController.text.isNotEmpty
                      ? double.parse(maxWidthController.text)
                      : null;
                  double height = maxHeightController.text.isNotEmpty
                      ? double.parse(maxHeightController.text)
                      : null;
                  int quality = qualityController.text.isNotEmpty
                      ? int.parse(qualityController.text)
                      : null;
                  onPick(width, height, quality);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();

    if (retrieveError != null) {
      return retrieveError;
    }

    if (_imageFile != null) {
      if (kIsWeb) {
        return Image.network(_imageFile.path);
      } else {
        return Semantics(
            child: Image.file(File(_imageFile.path)),
            label: 'image_picker_example_picked_image');
      }
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'you have not yet picked an image',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _previewVideo() {
    final Text retrieveError = _getRetrieveErrorWidget();

    if (retrieveError != null) {
      return retrieveError;
    }
    if (_controller == null) {
      return const Text(
        'you have not yet picked a video',
        textAlign: TextAlign.center,
      );
    }
    return Padding(
      padding: const EdgeInsets.all(10),
      child: AspectRatioVideo(_controller),
    );
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.video) {
        isVideo = true;
        await _playVideo(response.file);
      } else {
        isVideo = false;
        setState(() {
          _imageFile = response.file;
        });
      }
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
            ? FutureBuilder<void>(
                future: retrieveLostData(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Text(
                        'you have not yet piceked an image.',
                        textAlign: TextAlign.center,
                      );
                    case ConnectionState.done:
                      return isVideo ? _previewVideo() : _previewImage();
                    default:
                      if (snapshot.hasError) {
                        return Text(
                          'pick image/video error:${snapshot.error}',
                          textAlign: TextAlign.center,
                        );
                      } else {
                        return Text(
                          'you have not yet picked an image',
                          textAlign: TextAlign.center,
                        );
                      }
                  }
                },
              )
            : (isVideo ? _previewVideo() : _previewImage()),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Semantics(
            label: 'image_picker_example_from_gallery',
            child: FloatingActionButton(
              onPressed: () {
                isVideo = false;
                _onImageButtonPressed(ImageSource.gallery, context: context);
              },
              heroTag: 'image0',
              tooltip: 'pick image from gallery',
              child: const Icon(Icons.photo_library),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: FloatingActionButton(
              onPressed: () {
                isVideo = false;
                _onImageButtonPressed(ImageSource.camera, context: context);
              },
              heroTag: 'image1',
              tooltip: 'take a photo',
              child: const Icon(Icons.camera_alt),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: FloatingActionButton(
              onPressed: () {
                isVideo = true;
                _onImageButtonPressed(ImageSource.gallery, context: context);
              },
              heroTag: 'video0',
              tooltip: 'pick vodeo from gallery',
              child: const Icon(Icons.video_library),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: FloatingActionButton(
              onPressed: () {
                isVideo = true;
                _onImageButtonPressed(ImageSource.camera, context: context);
              },
              heroTag: 'video1',
              tooltip: 'take a video',
              child: const Icon(Icons.videocam),
            ),
          ),
        ],
      ),
    );
  }
}

typedef void OnPickImageCallback(
    double maxWidth, double maxHeight, int quality);

class AspectRatioVideo extends StatefulWidget {
  AspectRatioVideo(this.controller);

  final VideoPlayerController controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController get controller => widget.controller;

  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != controller.value.initialized) {
      initialized = controller.value.initialized;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: AspectRatio(
          aspectRatio: controller.value?.aspectRatio,
          child: VideoPlayer(controller),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_onVideoControllerUpdate);
  }

  @override
  void dispose() {
    controller.removeListener(_onVideoControllerUpdate);
    super.dispose();
  }
}
