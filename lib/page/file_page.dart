import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FilePage extends StatefulWidget {
  final String title;

  FilePage({Key key, this.title}) : super(key: key);

  @override
  _FilePageState createState() => new _FilePageState();
}

class _FilePageState extends State<FilePage> {
  Future<Directory> _tempDirectory;
  Future<Directory> _appSupportDirectory;
  Future<Directory> _appLibaryDirectory;
  Future<Directory> _appDocumentsDirectory;
  Future<Directory> _externalDocumentsDirectory;
  Future<List<Directory>> _externalStorageDirectories;
  Future<List<Directory>> _externalCacheDirectories;

  void _requestTempDirectory() {
    setState(() {
      _tempDirectory = getTemporaryDirectory();
    });
  }

  void _requestAppDocumentsDirectory() {
    setState(() {
      _appDocumentsDirectory = getApplicationDocumentsDirectory();
    });
  }

  void _requestAppSupportDirectory() {
    setState(() {
      _appSupportDirectory = getApplicationSupportDirectory();
    });
  }

  void _requestAppLibraryDirectory() {
    setState(() {
      _appLibaryDirectory = getLibraryDirectory();
    });
  }

  void _requestExternalStorageDirectory() {
    setState(() {
      _externalDocumentsDirectory = getExternalStorageDirectory();
    });
  }

  void _requestExternalStorageDirectories(StorageDirectory type) {
    setState(() {
      _externalStorageDirectories = getExternalStorageDirectories(type: type);
    });
  }

  void _requestExternalCacheDirectories() {
    setState(() {
      _externalCacheDirectories = getExternalCacheDirectories();
    });
  }

  Widget _buildDirectory(
      BuildContext context, AsyncSnapshot<Directory> snapshot) {
    Text text = const Text('');
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        text = Text('Error ${snapshot.error}');
      } else if (snapshot.hasData) {
        text = Text('path: ${snapshot.data.path}');
      } else {
        text = const Text('path unvaliable');
      }
    }

    return Padding(
      padding: const EdgeInsets.all(1),
      child: text,
    );
  }

  Widget _buildDirectories(
      BuildContext context, AsyncSnapshot<List<Directory>> snapshot) {
    Text text = const Text('');
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        text = Text('Error ${snapshot.error}');
      } else if (snapshot.hasData) {
        final String combined =
            snapshot.data.map((Directory d) => d.path).join(', ');
        text = Text('path: $combined');
      } else {
        text = const Text('path unvaliable');
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: RaisedButton(
                child: const Text('get temporary directory'),
                onPressed: _requestTempDirectory,
              ),
            ),
            FutureBuilder<Directory>(
                future: _tempDirectory, builder: _buildDirectory),
            Padding(
              padding: const EdgeInsets.all(16),
              child: RaisedButton(
                child: const Text('get application documents directory'),
                onPressed: _requestAppDocumentsDirectory,
              ),
            ),
            FutureBuilder<Directory>(
                future: _appDocumentsDirectory, builder: _buildDirectory),
            Padding(
              padding: const EdgeInsets.all(16),
              child: RaisedButton(
                child: const Text('get application support directory'),
                onPressed: _requestAppSupportDirectory,
              ),
            ),
            FutureBuilder<Directory>(
                future: _appSupportDirectory, builder: _buildDirectory),
            Padding(
              padding: const EdgeInsets.all(16),
              child: RaisedButton(
                child: const Text('get application library directory'),
                onPressed: _requestAppLibraryDirectory,
              ),
            ),
            FutureBuilder<Directory>(
                future: _appLibaryDirectory, builder: _buildDirectory),
            Padding(
              padding: const EdgeInsets.all(16),
              child: RaisedButton(
                child: const Text('get external Storage directory'),
                onPressed: _requestExternalStorageDirectory,
              ),
            ),
            FutureBuilder<Directory>(
                future: _externalDocumentsDirectory, builder: _buildDirectory),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: RaisedButton(
                      child: const Text('get external Storage directories'),
                      onPressed: () {
                        _requestExternalStorageDirectories(
                            StorageDirectory.music);
                      }),
                ),
              ],
            ),
            FutureBuilder<List<Directory>>(
                future: _externalStorageDirectories,
                builder: _buildDirectories),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: RaisedButton(
                    child: const Text('get external cache directories'),
                    onPressed: _requestExternalCacheDirectories,
                  ),
                ),
              ],
            ),
            FutureBuilder<List<Directory>>(
                future: _externalStorageDirectories,
                builder: _buildDirectories),
          ],
        ),
      ),
    );
  }
}
