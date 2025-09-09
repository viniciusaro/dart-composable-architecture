import 'package:flutter_test/flutter_test.dart';
import 'package:tca_flutter_example/app/clients.dart';

final class TestModel {
  final int id;
  TestModel(this.id);
}

final class TestModelEncoder with Encoder<TestModel> {
  @override
  Map<String, dynamic> call(TestModel value) {
    return {'id': value.id};
  }
}

final class TestModelDecoder with Decoder<TestModel> {
  @override
  TestModel call(Map<String, dynamic> args) {
    return TestModel(args['id']);
  }
}

void main() {
  group('shared.extensions.dart', () {
    test("data coding", () {
      final data = TestModel(0);

      final encoded = TestModelEncoder().call(data);
      expect(encoded['id'], 0);

      final decoded = TestModelDecoder().call(encoded);
      expect(decoded.id, data.id);
    });
  });
}
