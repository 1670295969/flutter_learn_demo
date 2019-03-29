class NetResponse {
  dynamic data;
  bool isResult;
  int code;
  dynamic headers;

  NetResponse(this.data, this.isResult, this.code, {this.headers});
}
