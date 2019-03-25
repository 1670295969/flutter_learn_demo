

class NetException implements Exception{

  int netCode;
  dynamic netErrorData;

  NetException(this.netCode,this.netErrorData);



}
