// import 'package:dio/dio.dart';
// import 'helper.dart';

// class UserApiProvider{
//   final String _endpoint = "https://api.thingspeak.com/channels/983649/fields/1.json?api_key=0ADMCKQ1UGKBIQIJ&results=2";
//   final Dio _dio = Dio();

//   Future<UserResponse> getUser() async {
//     try {
//       Response response = await _dio.get(_endpoint);
//       return UserResponse.fromJson(response.data);
//     } catch (error, stacktrace) {
//       print("Exception occured: $error stackTrace: $stacktrace");
//       return UserResponse.withError("$error");
//     }
//   }
// }