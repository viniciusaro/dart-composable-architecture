import 'package:flutter_test/flutter_test.dart';
import 'package:tca_flutter_example/app/clients.dart';
import 'package:tca_flutter_example/app/shared.extensions.dart';

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

    test('list coding', () {
      final data = [TestModel(0), TestModel(1)];

      final encoded = ListEncoder(TestModelEncoder()).call(data);
      expect(encoded['items'] is List, true);
      expect(encoded['items'][0]['id'], 0);
      expect(encoded['items'][1]['id'], 1);

      final decoded = ListDecoder(TestModelDecoder()).call(encoded);
      expect(decoded.length, 2);
      expect(decoded[0].id, 0);
      expect(decoded[1].id, 1);
    });
  });
}
