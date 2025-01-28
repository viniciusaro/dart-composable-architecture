import 'dart:async';

import 'package:macros/macros.dart';

macro class KeyPathable implements ClassDeclarationsMacro {
  const KeyPathable();

  @override
  Future<void> buildDeclarationsForClass(ClassDeclaration clazz, MemberDeclarationBuilder builder) async {
    final fields = await builder.fieldsOf(clazz);
    final rootType = clazz.identifier.name;
    
    builder.declareInLibrary(DeclarationCode.fromString("import 'package:key_path/key_path.dart' as kp;"),);

    for (final field in fields) {
      final propType = (field.type as NamedTypeAnnotation).identifier.name;
      final prop = field.identifier.name;
      String code;

      if (field.hasFinal) {
        code = """
  static final ${prop}Path = kp.KeyPath<$rootType, $propType>(
    get: (obj) => obj.$prop,
  );""";
      } else {
        code = """
  static final ${prop}Path = kp.WritableKeyPath<$rootType, $propType>(
    get: (obj) => obj.$prop,
    set: (obj, $prop) => obj.$prop = $prop,
  );""";
      }

      builder.declareInType(DeclarationCode.fromString(code));
    }
  }
}