import 'dart:async';

import 'package:macros/macros.dart';

macro class KeyPathable implements ClassDeclarationsMacro {
  const KeyPathable();

  @override
  Future<void> buildDeclarationsForClass(ClassDeclaration clazz, MemberDeclarationBuilder builder) async {
    final fields = await builder.fieldsOf(clazz);
    final methods = await builder.methodsOf(clazz);
    final getterMethods = methods.where((m) => m.isGetter);
    final rootType = clazz.identifier.name;
    final hasCopyWith = methods.where((m) => m.identifier.name == "copyWith").firstOrNull != null;

    builder.declareInLibrary(DeclarationCode.fromString(
      """
// ignore: non_part_of_directive_in_part, duplicate_import
import 'package:key_path/key_path.dart' as kp;
"""),);

    for (final field in fields) {
      final propType = (field.type as NamedTypeAnnotation).identifier.name;
      final optional = field.type.isNullable ? "?" : "";
      final prop = field.identifier.name;
      var propAssignment = prop;
      if (propType == "List") {
        propAssignment = "List.from($prop)";
      } else if (propType == "Map") {
        propAssignment = "Map.from($prop)";
      } else if (propType == "Set") {
        propAssignment = "Set.from($prop)";
      }

      String code;

      if (field.hasFinal) {
        if (hasCopyWith) {
          code = """
static final ${prop}Path = kp.WritableKeyPath<$rootType, $propType$optional>(
    get: (obj) => obj.$prop,
    set: (obj, $prop) => obj!.copyWith($prop: $propAssignment),
  );""";
        }
        else {
          code = """
  static final ${prop}Path = kp.KeyPath<$rootType, $propType$optional>(
    get: (obj) => obj.$prop,
  );""";
        }
      } else {
        code = """
  static final ${prop}Path = kp.WritableKeyPath<$rootType, $propType$optional>(
    get: (obj) => obj.$prop,
    set: (obj, $prop) => obj!..$prop = $propAssignment,
  );""";
      }

      builder.declareInType(DeclarationCode.fromString(code));
    }

    for (final method in getterMethods) {
      final propType = (method.returnType as NamedTypeAnnotation).identifier.name;
      final optional = method.returnType.isNullable ? "?" : "";
      final prop = method.identifier.name;

        final code = """
  static final ${prop}Path = kp.KeyPath<$rootType, $propType$optional>(
    get: (obj) => obj.$prop,
  );""";

      builder.declareInType(DeclarationCode.fromString(code));
    }
  }
}