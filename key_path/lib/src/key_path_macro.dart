import 'dart:async';

import 'package:macros/macros.dart';

macro class KeyPathable implements ClassDeclarationsMacro {
  const KeyPathable();

  @override
  Future<void> buildDeclarationsForClass(ClassDeclaration clazz, MemberDeclarationBuilder builder) async {
    final fields = await builder.fieldsOf(clazz);
    final rootType = clazz.identifier.name;
    
    builder.declareInLibrary(DeclarationCode.fromString(
      """
// ignore: non_part_of_directive_in_part
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
      }

      String code;

      if (field.hasFinal) {
        code = """
  static final ${prop}Path = kp.KeyPath<$rootType, $propType$optional>(
    get: (obj) => obj.$prop,
  );""";
      } else {
        code = """
  static final ${prop}Path = kp.WritableKeyPath<$rootType, $propType$optional>(
    get: (obj) => obj.$prop,
    set: (obj, $prop) => obj..$prop = $propAssignment,
  );""";
      }

      builder.declareInType(DeclarationCode.fromString(code));
    }
  }
}