import 'package:bookly_app/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  final Dio dio;

  final String? staticToken;
  const ApiClient(this.dio, {this.staticToken});

  // final accessToken2 =
  // 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5ZGJiMjVhNS1jZDM2LTQyM2QtYTAyMy0yMTZiNWEyODEwOWEiLCJqdGkiOiIxZDQyNTFmNWYxNTJkNjZjZDQyOTk3MTFiNDA0MGIwZDA4NGU2NDU5MDBmYmUyYzA2MTZkMDIwYzg1YTJhMjBlNzEzZjcwNDQ3NWIyNTRjMCIsImlhdCI6MTc0NDEwNzg5Mi40MzU4MTIsIm5iZiI6MTc0NDEwNzg5Mi40MzU4MTUsImV4cCI6MTc3NTY0Mzg5Mi40MzA0ODksInN1YiI6IjQyNSIsInNjb3BlcyI6WyJjdXN0b21lciJdfQ.rkyNus5r-y281VU1Tydcqw-eIXNlzoPPmCOuRFI-X5srEsQNIEEh7xJnZeYFmBkWleUCxCSmOoofgXGtsSSEL0ZNRou97nK2Ghb1tapD-Tfcj9qwT-DOS3tW8bItaaLohCOHY5vBXkq-WYnrfkfVIlBgLnAMQcFKTCw0A1jqpcpSTMCCgoFogpxPhKd5kz3dc2Q4zlp-2B9o0QRalxehjKetDk1BdROnLet6B47h8ytBndogaTXPNOT8WHvwBrgbxgFBRc4tzo6TMpPxHVUPe5iTI66c5nn8ab6azr8_ASR1B4GnucHzvfsdtrWm45upXsNSH-2ptznL44myaOmis2Du7pBkf-O6o74HG3roJM1Fu1r65TTyd6GfgUwHcdNqFR6h82dMEsptiSD72xi7EX8ZVQRB9IgcQBTF4j00TNgEtt16Q-hVJMzz0cw-X-tYoL9Vnkd--2GFT7rHh1CbYX3dXZsXu29_cCQjjljiWS04c4BJd218c4q1Odkrn4CDkklg-spwQsCjPEKcBCKds-cdD-cEdx5EnXdTqqMrm_UdzpAXTFsfat7eYrBa2C1wU_Lo98zD9UoR4DG7yJx2O3XkZ047qPmjXPz1GywlHfwcEhkRgn9vBvHqk6JVAt5PeER9FQ1A89FO5t6oAiEZTofUeP7r-P6sCzIyCkSUMPY';

  Future<Options> baseOptions({
    bool attachToken = true,
  }) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (attachToken) 'Authorization': 'Bearer ${staticToken}',
    };
    return Options(
      headers: headers,
      followRedirects: false,
      responseType: ResponseType.json,
      sendTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      validateStatus: (status) => (status ?? 0) < 300,
    );
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic> query = const {},
    CancelToken? cancelToken,
  }) async =>
      await dio.get(
        path,
        cancelToken: cancelToken,
        queryParameters: query,
        options: await baseOptions(),
      );

  Future<Response<T>> post<T>(
    String path, {
    Object body = const {},
  }) async =>
      await dio.post(
        path,
        data: body,
        options: await baseOptions(),
      );

  Future<Response<T>> put<T>(
    String path, {
    Object body = const {},
  }) async =>
      await dio.put(
        path,
        data: body,
        options: await baseOptions(),
      );

  Future<Response> delete(
    String path, {
    Map<String, dynamic> query = const {},
  }) async =>
      dio.delete(
        path,
        queryParameters: query,
        options: await baseOptions(),
      );
}
