import 'dart:convert';
import 'dart:html';
import 'dart:math';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as https;

class DioUsage {
  Future<void> LearnDioUsage() async {
    Uri myuri = Uri.parse('Hello world');
    https.Response response = await https.get(myuri);
    var parsedJson = await json.decode(response.body);

    var response2 = Dio().get('https://google.com');

    //* Dio GET REQUEST
    var dio = Dio();
    var response3 = await dio.get('https://google.com');
    var responseWithQuery = await dio.get('https://google.com',
        queryParameters: {'id': 'Berkay Ateş', 'age': '33'});
    print(response3.data.toString());

    //* Dio POST REQUEST
    var dioPost = Dio();
    var postRequset = dioPost.post('https.//google.com',
        data: {'in data': 'we give the information'});

    //* Performing multiple concurrent requests:
    var dioMultiple = Dio();
    var multipleGetResponse = await Future.wait(
        [dioMultiple.get('http.get'), dioMultiple.get('https:/sjg')]);

    var multiplePostResponse = await Future.wait(
        [dioMultiple.post('https:/google'), dioMultiple.post('elonamusk')]);

    //* Downloading the files
    var dioFileDownload = Dio();
    var fileResponse =
        dioFileDownload.download('https:/google.com', 'somewhere to save');

    //* Get response stream
    var dioStream = Dio();
    Response<ResponseBody> streamingResBody;
    streamingResBody = await dioStream.get<ResponseBody>('google.com',
        options: Options(responseType: ResponseType.stream));

    var trythis = await dioStream.get<ResponseBody>('tryandlearn',
        options: Options(responseType: ResponseType.stream));

    //* Get Response with Bytes
    var dioResponseAsBytes = Dio();
    Response<List<int>> responseAsBtes; //? https.Response hata veriyor ???
    responseAsBtes = await dioResponseAsBytes.get<List<int>>(
        'https://google.com',
        options: Options(responseType: ResponseType.bytes));

    responseAsBtes = await dioResponseAsBytes.get<List<int>>('hello world',
        options: Options(responseType: ResponseType.bytes));

    //* Sending Form Data
    var dioFormData = Dio();
    var formData = FormData.fromMap({'name': 'Berkay', 'age': 21});
    var formDataResponse =
        await dioFormData.post('https.google.com', data: formData);

    var dioanother = Dio();
    // creating a form data
    var formDatamine = FormData.fromMap(({'hello': 'world'}));
    var responsesecondFormData =
        dioanother.post('the second form post ', data: formDatamine);

    //* Uploading multiple files
    var dioMultipleFiles = Dio();
    var formDataMultiple = FormData.fromMap({
      'name': 'wendux',
      'age': 25,
      'secondFile':
          MultipartFile.fromFile('.text.txt', filename: 'seconduplad.txt'),
      'Another': MultipartFile.fromFile('../text365.txt', filename: 'hithere'),
      'file':
          await MultipartFile.fromFile('./text.txt', filename: 'upload.txt'),
      'files': [
        await MultipartFile.fromFile('./text1.txt', filename: 'text1.txt'),
        await MultipartFile.fromFile('./text2.txt', filename: 'text2.txt'),
      ]
    });
    var multipleFileResponse =
        dioMultipleFiles.post('google.com', data: formDataMultiple);

    //* Dio Send Progress
    var sendingProgress = Dio();
    var responseofSendingProcessDio = sendingProgress.post('google.com', data: {
      'files': [
        await MultipartFile.fromFile(
            '.textFindtheFacking way of the that Addpication directory',
            filename: 'something not noticed')
      ]
    }, onSendProgress: (int send, int progress) {
      print('it just still lasting');
    });

    //! Creating a Base Dio ....

    var dioBase = Dio();

    dio.options.baseUrl = 'google.com';
    dio.options.connectTimeout = 5000; //? 5seconds
    dio.options.receiveTimeout = 3000;

    //* or a new dio with base options

    var baseOptions = BaseOptions(
        baseUrl: 'https.google.com',
        connectTimeout: 50000,
        receiveTimeout: 3000);

    var dioWithPreDefinedOptions = Dio(baseOptions);
  }
}
