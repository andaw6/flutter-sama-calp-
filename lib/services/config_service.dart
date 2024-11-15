import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';

class ConfigService {
  late Map<String, dynamic> _config;

  Future<Map<String, dynamic>> loadConfig() async {
    final yamlString = await rootBundle.loadString('assets/config.yaml');
    final yamlMap = loadYaml(yamlString);
    _config = Map<String, dynamic>.from(yamlMap);
    return _config;
  }

  String get apiBaseUrl {
    return _config['services']['api_base_url'] as String;
  }
}
