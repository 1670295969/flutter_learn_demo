


class ArrayUtils {

  static List convertToList(List<dynamic> data, Function callBack) {
    return data?.map((value) {
      return callBack(data);
    })?.toList();
  }


}