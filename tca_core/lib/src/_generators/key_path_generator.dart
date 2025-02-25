import 'dart:async';
import 'package:build/build.dart';
import 'package:composable_architecture/composable_architecture.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

class KeyPathGenerator extends GeneratorForAnnotation<KeyPathable> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final clazz = element as ClassElement;
    final fields = clazz.fields;
    final methods = clazz.methods;
    // final getterMethods = methods.where((m) => m.isGetter);
    final rootType = clazz.name;
    final hasCopyWith = methods.where((m) => m.name == "copyWith").firstOrNull != null;

    String code = '''
extension ${element.name}Path on ${element.name} {
''';

    for (final field in fields) {
      final propType = field.type.getDisplayString();
      final prop = field.name;
      var propAssignment = prop;
      if (propType == "List") {
        propAssignment = "List.from($prop)";
      } else if (propType == "Map") {
        propAssignment = "Map.from($prop)";
      } else if (propType == "Set") {
        propAssignment = "Set.from($prop)";
      }

      if (field.isFinal) {
        if (hasCopyWith) {
          code += """
static final $prop = WritableKeyPath<$rootType, $propType>(
    get: (obj) => obj.$prop,
    set: (obj, $prop) => obj!.copyWith($prop: $propAssignment),
  );""";
        } else {
          code += """
  static final $prop = KeyPath<$rootType, $propType>(
    get: (obj) => obj.$prop,
  );""";
        }
      } else {
        if (!isGetterOnly(field)) {
          code += """
  static final $prop = WritableKeyPath<$rootType, $propType>(
    get: (obj) => obj.$prop,
    set: (obj, $prop) => obj!..$prop = $propAssignment,
  );""";
        } else {
          code += """
  static final $prop = KeyPath<$rootType, $propType>(
    get: (obj) => obj.$prop,
  );""";
        }
      }
    }

    code += "\n}";
    return code;
  }
}

bool isGetterOnly(FieldElement field) {
  return field.getter != null && field.setter == null;
}
