import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

abstract class GeneratorForMixin<T> extends Generator {
  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) async {
    final keyPathableCalsses = library.classes
        .where((c) => c.mixins.map((t) => t.getDisplayString()).contains(T.toString()));
    String code = '';
    for (final clazz in keyPathableCalsses) {
      code += await generateForMixinElement(clazz);
    }
    return code;
  }

  FutureOr<String> generateForMixinElement(ClassElement clazz);
}
