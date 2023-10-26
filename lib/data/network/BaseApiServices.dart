abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getPostApiResponse(String url, dynamic data);
  Future<dynamic> getPostApiResponse_(String url, dynamic data);
}
