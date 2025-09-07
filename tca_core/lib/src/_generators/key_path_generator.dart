import 'dart:async';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
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
    late List<VariableElement> fields;
    try {
      final factory = clazz.constructors.firstWhere((c) => c.isFactory);
      fields = factory.parameters;
    } catch (_) {
      fields = clazz.fields;
    }

    final hasNonFinalSharedFields = fields.where((field) {
      final isShared = field.type.getDisplayString().startsWith("Shared<");
      return isShared && !field.isFinal;
    });

    if (hasNonFinalSharedFields.isNotEmpty) {
      throw Exception("Shared fields must be final: $hasNonFinalSharedFields");
    }

    final rootType = clazz.name;
    final filteredFields = fields.where((field) {
      final existsInConstructor = element.constructors.first.parameters
          .map((p) => p.element)
          .firstWhereOrNull((e) => e.displayName == field.displayName);
      return existsInConstructor != null;
    });

    String code = '''
extension ${element.name}Path on ${element.name} {
''';

    for (final field in filteredFields) {
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

    // Only generate mixin if not using freezed
    if (!_hasFreezedAnnotation(clazz)) {
      code += _generateCopyAndEqualityMixin(clazz, fields);
    }

    return code;
  }

  bool _hasFreezedAnnotation(ClassElement clazz) {
    return clazz.metadata.any((annotation) {
      final value = annotation.computeConstantValue();
      final type = value?.type;
      // Check for both 'freezed' and 'Freezed' for robustness
      return type != null &&
          (type.getDisplayString(withNullability: false) == 'freezed' ||
              type.getDisplayString(withNullability: false) == 'Freezed');
    });
  }

  String _generateCopyAndEqualityMixin(
    ClassElement element,
    List<VariableElement> fields,
  ) {
    String code = '';
    // Generate mixin for value equality, copyWith, and toString
    code += '\nmixin _\$${element.name} {\n';
    // Abstract getters for all fields
    for (final field in fields) {
      final propType = field.type.getDisplayString();
      final prop = field.name;
      code += '  $propType get $prop;\n';
    }

    final filteredFields = fields.where((field) {
      final existsInConstructor = element.constructors.first.parameters
          .map((p) => p.element)
          .firstWhereOrNull((e) => e.displayName == field.displayName);
      return existsInConstructor != null;
    });

    // copyWith
    if (filteredFields.isNotEmpty) {
      final params = fields
          .map((f) =>
              '${f.type.getDisplayStringWithoutFinalNullability()}? ${f.name}')
          .join(', ');
      final args = fields
          .map((f) => '${f.name}: ${f.name} ?? this.${f.name}')
          .join(', ');
      code +=
          '  ${element.name} copyWith({$params}) {\n    return ${element.name}($args);\n  }\n';
    } else {
      code += '\n';
    }
    // operator ==
    code += '  @override\n  bool operator ==(Object other) =>\n';
    code += '      identical(this, other) ||\n';
    code += '      other is ${element.name} &&\n';
    code += '          runtimeType == other.runtimeType';
    for (final field in fields) {
      code +=
          ' &&\n          const DeepCollectionEquality().equals(${field.name}, other.${field.name})';
    }
    code += ';\n';
    // hashCode
    if (fields.isNotEmpty) {
      code += '  @override\n  int get hashCode => Object.hash(runtimeType,';
      code += fields.map((f) => f.name).join(', ');
      code += ');\n';
    } else {
      code += '  @override\n  int get hashCode => runtimeType.hashCode;\n';
    }
    // toString
    code += '  @override\n  String toString() {';
    if (fields.isNotEmpty) {
      final props = fields.map((f) => '${f.name}: \$${f.name}').join(', ');
      code += '\n    return "${element.name}($props)";\n';
    } else {
      code += '\n    return "${element.name}()";\n';
    }
    code += '  }\n';
    code += '}\n';
    return code;
  }
}

extension on DartType {
  String getDisplayStringWithoutFinalNullability() {
    final displayString = getDisplayString();
    if (displayString.endsWith('?')) {
      return displayString.substring(0, displayString.length - 1);
    }
    return displayString;
  }
}
