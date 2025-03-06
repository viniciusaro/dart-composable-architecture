import 'package:http/http.dart' as http;

final class NumberFactClient {
  Future<String> Function(int) factFor;
  NumberFactClient({required this.factFor});
}

final liveNumberFactClient = NumberFactClient(
  factFor: (number) async {
    final uri = Uri.parse("http://numbersapi.com/$number/trivia");
    final response = await http.get(uri);
    return response.body;
  },
);
