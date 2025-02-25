import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/_generators/case_key_path_generator.dart';
import 'src/_generators/key_path_generator.dart';

Builder keyPathBuilder(BuilderOptions options) => SharedPartBuilder(
      [KeyPathGenerator(), CaseKeyPathGenerator()],
      "key_path",
    );
