import 'dart:io';

import 'package:daya5_test_arif_rahman/src/pages/add_movie/bloc/add_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';

class AddMovie extends StatefulWidget {
  const AddMovie({super.key});

  @override
  State<AddMovie> createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  final AddMovieBloc _addMovieBloc = AddMovieBloc();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _imagePath;
  File? imagefile;

  void _postData() {
    if (_formKey.currentState!.validate()) {
      if (imagefile == null) {
        _addMovieBloc
            .add(PostMovie(_titleController.text, _descController.text));
      } else {
        _addMovieBloc.add(PostMovieWithPoster(
            _titleController.text, _descController.text, imagefile));
      }
    }
  }

  void _selectPicture() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      File compress =
          await FlutterNativeImage.compressImage(image.path, quality: 50);
      setState(() {
        imagefile = File(compress.path);
        _imagePath = compress.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Movie"),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _postData();
          },
          label: const Text("Submit")),
      body: BlocProvider(
        create: (context) => _addMovieBloc,
        child: BlocListener<AddMovieBloc, AddMovieState>(
          listener: (context, state) {
            if (state is AddMovieError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          child: BlocBuilder<AddMovieBloc, AddMovieState>(
            builder: (context, state) {
              if (state is AddMovieInitial) {
                return Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Movie Titles:"),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          controller: _titleController,
                          decoration: const InputDecoration(labelText: 'Title'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Description:"),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          controller: _descController,
                          decoration:
                              const InputDecoration(labelText: 'Description'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              _selectPicture();
                            },
                            child: const Text("Select Photo")),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(_imagePath.toString()),
                      ],
                    ),
                  ),
                );
              } else if (state is AddingMovies) {
                return _buildLoading();
              } else if (state is AddedMovies) {
                return const Center(child: Text("Success"));
              } else if (state is AddMovieError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
