import 'package:http/http.dart' as http;


void main() async {
  testHttp();
}

void testHttp() async {
  final result = await http.get("http://www.baidu.com");
  print(result.body);
}
