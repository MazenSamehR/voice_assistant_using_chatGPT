import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:voice_assistant_app/secret_key.dart';

class OpenAiServices {
  final List<Map<String , String>> message = [];

  Future<String> isArtPrompt(String prompt) async {
    try {
      final resp = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey2',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "system", "content": "You are a helpful assistant."},
            {
              "role": "user",
              "content":
                  "Does this message want to generate AI picture , image , art or any thing similar? $prompt . Simply answer with yes or no.",
            }
          ],
        }),
      );
      print(resp.body);
      if(resp.statusCode == 200) {
        String content = jsonDecode(resp.body)['choices'][0]['message']['content'];
        content = content.trim();
        switch(content) {
          case 'Yes':
          case 'yes':
          case 'Yes.':
          case 'yes.':
            final res = await dallEAPI(prompt);
            return res ;
          default:
            final res = await chatGPTAPI(prompt);
            return res;

        }
      }
      return "An internal error occurred.";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGPTAPI(String prompt) async {
    message.add({
      "role": "user",
      "content": prompt,
    });

    try {
      final resp = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey2',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": message,
        }),
      );

      if(resp.statusCode == 200) {
        String content = jsonDecode(resp.body)['choices'][0]['message']['content'];
        content = content.trim();
        message.add({
          "role": "assistant",
          "content": content,
        });
        return content;
      }
      return "An internal error occurred.";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> dallEAPI(String prompt) async {
    message.add({
      "role": "user",
      "content": prompt,
    });

    try {
      final resp = await http.post(
        Uri.parse('https://api.openai.com/v1/images/generations'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey2',
        },
        body: jsonEncode({
          'prompt': prompt,
          'n': 1,
        }),
      );

      if(resp.statusCode == 200) {
        String imageurl = jsonDecode(resp.body)['data'][0]['url'];
        imageurl = imageurl.trim();
        message.add({
          "role": "assistant",
          "content": imageurl,
        });
        return imageurl;
      }
      return "An internal error occurred.";
    } catch (e) {
      return e.toString();
    }
  }
}
