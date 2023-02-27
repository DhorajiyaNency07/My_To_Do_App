class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});

  Task.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        isCompleted = json['isCompleted'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'isCompleted': isCompleted,
      };
}