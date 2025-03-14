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
    late ConstructorElement factory;
    try {
      factory = clazz.constructors.firstWhere((c) => c.isFactory);
    } catch (_) {
      throw Exception("No factory constructor found for type ${clazz.name} at ${clazz.library}");
    }
    final fields = factory.parameters;
    final rootType = clazz.name;

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

      code += """
static final $prop = WritableKeyPath<$rootType, $propType>(
    get: (obj) => obj.$prop,
    set: (obj, $prop) => obj!.copyWith($prop: $propAssignment),
  );""";
    }

    code += "\n}";
    return code;
  }
}

bool isGetterOnly(ParameterElement field) {
  return false;
}
