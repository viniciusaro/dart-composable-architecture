import 'dart:async';
import 'package:build/build.dart';
import 'package:composable_architecture/composable_architecture.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

class CaseKeyPathGenerator extends GeneratorForAnnotation<CaseKeyPathable> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final clazz = element as ClassElement;
    String code = "";
    code += await buildDeclarationsForClass(clazz);
    code += await buildTypesForClass(clazz);
    code += await buildKeyPathsForClass(clazz);
    return code;
  }

  FutureOr<String> buildDeclarationsForClass(ClassElement clazz) {
    final rootType = clazz.name;

    String code = """
extension ${clazz.name}Enum on ${clazz.name} {
""";

    for (final type in clazz.typeParameters) {
      final prop = type.name.lowerCaseFirst();
      final genericTypeName = extendsOf(type);

      if (genericTypeName == "void") {
        code += """
  static $rootType $prop() => $rootType${type.name}();""";
      } else {
        code += """
  static $rootType $prop($genericTypeName p) => $rootType${type.name}(p);""";
      }
    }

    code += "\n}\n\n";
    return code;
  }

  FutureOr<String> buildTypesForClass(ClassElement clazz) {
    String code = "";
    final rootType = clazz.name;
    const letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I"];
    final genericsWithExtends = <String>[];
    final genericsOnly = <String>[];

    for (final typeIndexed in clazz.typeParameters.indexed) {
      final genericTypeName = extendsOf(typeIndexed.$2);
      final nextGeneric = letters[typeIndexed.$1];
      genericsOnly.add(nextGeneric);
      if (genericTypeName == "void") {
        genericsWithExtends.add(nextGeneric);
      } else {
        genericsWithExtends.add("$nextGeneric extends $genericTypeName");
      }
    }

    final genericsString = genericsWithExtends.isEmpty ? "" : "<${genericsWithExtends.join(", ")}>";
    final genericsOnlyString = genericsOnly.isEmpty ? "" : "<${genericsOnly.join(", ")}>";

    for (final typeIndexed in clazz.typeParameters.indexed) {
      final typeName = typeIndexed.$2.name;
      final prop = typeName.lowerCaseFirst();
      final newClassName = "$rootType$typeName";
      final genericTypeName = extendsOf(typeIndexed.$2);
      final genericLetter = letters[typeIndexed.$1];

      if (genericTypeName == "void") {
        code += '''final class $newClassName$genericsString extends $rootType$genericsOnlyString {
  $newClassName(): super();
}\n\n''';
      } else {
        code += '''final class $newClassName$genericsString extends $rootType$genericsOnlyString {
  final $genericLetter $prop;
  $newClassName(this.$prop): super();
}\n\n''';
      }
    }

    return code;
  }

  FutureOr<String> buildKeyPathsForClass(ClassElement clazz) {
    final rootType = clazz.name;
    String code = """
extension ${clazz.name}Path on ${clazz.name} {
""";

    for (final type in clazz.typeParameters) {
      final genericTypeName = extendsOf(type);
      final prop = type.name.lowerCaseFirst(); // $1
      final propUpper = prop.capitalized();
      final propType = genericTypeName == "void" ? "$rootType${type.name}" : genericTypeName; // $2

      if (genericTypeName == "void") {
        code += """
  static final $prop = WritableKeyPath<$rootType, $propType?>(get: (action) {
    if (action is $rootType$propUpper) {
      return action;
    }
    return null;
  }, set: (rootAction, propAction) {
    if (propAction != null) {
      rootAction = ${rootType}Enum.$prop();
    }
    return rootAction!;
  },);""";
      } else {
        code += """
  static final $prop = WritableKeyPath<$rootType, $propType?>(get: (action) {
    if (action is $rootType$propUpper) {
      return action.$prop;
    }
    return null;
  }, set: (rootAction, propAction) {
    if (propAction != null) {
      rootAction = ${rootType}Enum.$prop(propAction);
    }
    return rootAction!;
  },);""";
      }
    }
    code += "\n}\n\n";
    return code;
  }
}

extension on String {
  String lowerCaseFirst() {
    final first = substring(0, 1).toLowerCase();
    final remaining = substring(1);
    return "$first$remaining";
  }

  String capitalized() {
    final first = substring(0, 1).toUpperCase();
    final remaining = substring(1);
    return "$first$remaining";
  }
}

String extendsOf(TypeParameterElement type) {
  return type.bound?.getDisplayString() ?? "void";
}
