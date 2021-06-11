import 'package:avzag/utils.dart';

class Language {
  final String name;
  final String flag;
  final List<String>? family;
  final List<String>? tags;

  Language({
    required this.name,
    required this.flag,
    this.tags,
    this.family,
  });

  Language.fromJson(Map<String, Object?> json)
      : this(
          name: json['name'] as String,
          flag: json['flag'] as String,
          family: json2list(json['family']),
          tags: json2list(json['tags']),
        );

  Map<String, Object?> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['flag'] = flag;
    if (family != null) data['family'] = family;
    if (tags != null) data['tags'] = tags;
    return data;
  }
}
