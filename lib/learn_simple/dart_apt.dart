import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
//https://juejin.im/post/5d1ac884f265da1bad571f3a
class ParamMetadata {
  final String name;
  final int id;

  //注解构造器 const
  const ParamMetadata(this.name, this.id);
}


@ParamMetadata("GeneratorModel",100)
class GeneratorModel{
  String name = "";
  void han(){

  }

}


class TestGenerator extends GeneratorForAnnotation<ParamMetadata>{
  /**
   * element : 被 annotation 所修饰的元素，通过它可以获取到元素的name、可见性等等。
   *
   * annotation：表示注解对象，通过它可以获取到注解相关信息以及参数值
   *
   * buildStep：这一次构建的信息，通过它可以获取到一些输入输出信息，例如输入文件名等
   */
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {


//    if(element!=null){
//      print("${element.name} \n");
////      print("${annotation.typeValue} \n");
//      print("${element.kind} \n");
//    }
//
//
//    if(element.kind is ClassElement){
//      ClassElement ckind = element.kind as ClassElement;
//      print("\n--------------\n");
//      print(ckind.fields);
//      print("\n--------------\n");
//
//      print(ckind.methods);
//      print("\n--------------\n");
//      print(annotation.read("name").stringValue);
//      print("\n--------------\n");
//    }


    //annotation.read("name")
    //annotation.read("id")
    return """
    import 'dart_apt.dart';
    class CreateModel{
    
      static ${element.name} create(){
        var data =   ${element.name}();
        data.name = "${annotation.read("name").stringValue}";
        return data;
      }
      
      
    
      void info(){
        print("${element.kind}");
        print("${element.name}");
      }
    
    }
    
    """;
  }

}

Builder testBuilder(BuilderOptions options) =>
    LibraryBuilder(TestGenerator());
