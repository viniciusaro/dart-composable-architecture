import 'dart:async';
import 'package:composable_architecture/composable_architecture.dart';
import 'package:analyzer/dart/element/element.dart';

import 'generator_for_mixin.dart';

class KeyPathGenerator extends GeneratorForMixin<KeyPathable> {
  @override
  FutureOr<String> generateForMixinElement(
    ClassElement clazz,
  ) {
    String code = '';
    code += generateKeyPaths(clazz);
    code += generateDataClassEquality(clazz);
    return code;
  }

  String generateKeyPaths(ClassElement clazz) {
    final fields = clazz.fields;
    final rootType = clazz.name;

    String code = '''
extension ${clazz.name}Path on ${clazz.name} {
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
        code += """
static final $prop = WritableKeyPath<$rootType, $propType>(
    get: (obj) => obj.$prop,
    set: (obj, $prop) => obj!.copyWith($prop: $propAssignment),
  );""";
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

    code += "\n}\n\n";
    return code;
  }

  String generateDataClassEquality(ClassElement clazz) {
    String code = "";
    final hasHashcode = clazz.methods.where((m) => m.name == "hashCode").firstOrNull != null;
    final hasCopyWith = clazz.methods.where((m) => m.name == "copyWith").firstOrNull != null;
    if (hasHashcode) {
      return code;
    }

    String copyWith() {
      String copyWithParams = clazz.fields.fold("",
          (acc, field) => "$acc${field.getTypeDisplayStringWithoutOptional()}? ${field.name}, ");

      String copyWithAssignments = clazz.fields
          .fold("", (acc, field) => "$acc${field.name}: ${field.name} ?? this.${field.name},");

      return """
\n\n${clazz.name} copyWith({$copyWithParams}) {
    return ${clazz.name}($copyWithAssignments);
  }
""";
    }

    String props =
        clazz.fields.fold("List<dynamic> get props => [", (acc, field) => "$acc${field.name},");
    props += "]";

    String copyWithCode = hasCopyWith ? "" : copyWith();

    code = '''
extension ${clazz.name}Props on ${clazz.name} {
  $props;$copyWithCode
}
''';

    return code;
  }
}

bool isGetterOnly(FieldElement field) {
  return field.getter != null && field.setter == null;
}

extension on FieldElement {
  String getTypeDisplayStringWithoutOptional() {
    final name = type.getDisplayString();
    return name.contains("?") ? name.replaceAll("?", "") : name;
  }
}
