import 'dart:async';

import 'package:macros/macros.dart';

macro class CaseKeyPathable implements ClassTypesMacro, ClassDeclarationsMacro {
  const CaseKeyPathable();
  
  @override
  FutureOr<void> buildTypesForClass(ClassDeclaration clazz, ClassTypeBuilder builder) async {
    final rootType = clazz.identifier.name;
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
      final prop = typeName.toLowerCase();
      final newClassName = "$rootType$typeName";
      final genericTypeName = extendsOf(typeIndexed.$2);
      final genericLetter = letters[typeIndexed.$1];

      if (genericTypeName == "void") {
        builder.declareType(newClassName, DeclarationCode.fromString(
'''final class $newClassName$genericsString extends $rootType$genericsOnlyString {
  $newClassName(): super();
}'''));
      }
      else {
        builder.declareType(newClassName, DeclarationCode.fromString(
'''final class $newClassName$genericsString extends $rootType$genericsOnlyString {
  final $genericLetter $prop;
  $newClassName(this.$prop): super();
}'''));
    }
      }
  }
  
  @override
  FutureOr<void> buildDeclarationsForClass(ClassDeclaration clazz, MemberDeclarationBuilder builder) async {
    final rootType = clazz.identifier.name;

    builder.declareInType(DeclarationCode.fromString("""
  $rootType();
"""));

    for (final type in clazz.typeParameters) {
      final prop = type.name.lowerCaseFirst();
      final genericTypeName = extendsOf(type);

      if (genericTypeName == "void") {
        builder.declareInType(DeclarationCode.fromString(
"""   
  // ignore: argument_type_not_assignable yo
  factory $rootType.$prop() => $rootType${type.name}();"""));
      } else {
        builder.declareInType(DeclarationCode.fromString(
"""
  // ignore: argument_type_not_assignable
  factory $rootType.$prop(${type.name} p) => $rootType${type.name}(p);"""));
      }
    }

    final caseKeyPathable = _CaseKeyPathable();
    await caseKeyPathable.buildDeclarationsForClass(clazz, builder);
  }
}

final class _CaseKeyPathable {
  const _CaseKeyPathable();

  FutureOr<void> buildDeclarationsForClass(ClassDeclaration clazz, MemberDeclarationBuilder builder) {
    builder.declareInLibrary(
      DeclarationCode.fromString("import 'package:key_path/key_path.dart' as kp;"),
    );
    final rootType = clazz.identifier.name;

    for (final type in clazz.typeParameters) {
      final genericTypeName = extendsOf(type);
      final prop = type.name.lowerCaseFirst(); // $1
      final propUpper = prop.capitalized();
      final propType = genericTypeName == "void" ? "$rootType${type.name}" : genericTypeName; // $2

      if (genericTypeName == "void") {
        builder.declareInType(DeclarationCode.fromString("""
  static final ${prop}Path = kp.WritableKeyPath<$rootType, $propType?>(get: (action) {
    if (action is $rootType$propUpper) {
      return action;
    }
    return null;
  }, set: (rootAction, propAction) {
    if (propAction != null) {
      rootAction = $rootType.$prop();
    }
    return rootAction;
  },);"""));
      } else {
        builder.declareInType(DeclarationCode.fromString("""
  static final ${prop}Path = kp.WritableKeyPath<$rootType, $propType?>(get: (action) {
    if (action is $rootType$propUpper) {
      return action.$prop;
    }
    return null;
  }, set: (rootAction, propAction) {
    if (propAction != null) {
      rootAction = $rootType.$prop(propAction);
    }
    return rootAction;
  },);"""));
      }
    }
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
String extendsOf(TypeParameterDeclaration type) {
    final parts = type.code.parts.lastOrNull;
    if (parts is! NamedTypeAnnotationCode) {
      return "void";
    }

    final parts2 = parts.parts.firstOrNull;

    if (parts2 is! Identifier) {
      return "void";
    }

    return parts2.name;
  }