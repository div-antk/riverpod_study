import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final dogImageUrlProvider = FutureProvider<String>((ref) async {
  final response =
      await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['message'];
  } else {
    throw Exception('しっぱい！');
  }
});

class DogImageWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dogImageUrlAsyncValue = ref.watch(dogImageUrlProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('🐶'),
      ),
      body: Center(
        child: dogImageUrlAsyncValue.when(
          data: (dogImageUrl) {
            return Image.network(dogImageUrl);
          },
          loading: () {
            return CircularProgressIndicator();
          },
          error: (error, stackTrace) {
            return Text('しっぱい！');
          },
        ),
      ),
    );
  }
}
