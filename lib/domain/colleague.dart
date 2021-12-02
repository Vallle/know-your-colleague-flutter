class Colleague {
  final String name;
  final String imageUrl;

  Colleague(this.name, this.imageUrl);

  Colleague.fromJson(Map<String, dynamic> json)
      : name = json['Name'],
        imageUrl = json['Image'];

  Map<String, dynamic> toJson() => {
    'Name': name,
    'Image': imageUrl,
  };
}