import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

typedef Widget FullResponse<E>(E data);

class MyFutureBuilder<E> extends StatelessWidget {
  final Widget networkError, empty, serverError, loading;
  final FullResponse<E> fullResponse;

  final Future request;
  MyFutureBuilder(
      {this.request,
      this.networkError,
      this.empty,
      this.serverError,
      this.fullResponse,
      this.loading});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<E>(
      builder: (BuildContext context, snapshot) {
        print('helloo');
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            DioError e = snapshot.error;
            if (e.type == DioErrorType.DEFAULT) {
              return networkError;
            } else {
              return serverError;
            }
          }
          return fullResponse(snapshot.data);
        } else {
          return loading;
        }
      },
      future: request,
    );
  }
}
