import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  final int? id;
  final String title;
  final String? description;
  final bool isCompleted;

  const TodoModel({
    this.id,
    required this.title,
    this.description,
    this.isCompleted = false,
  });

  TodoModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  // Chuyển đổi từ Map (JSON nhận được từ Dio/Supabase) sang Object Model
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as int?,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      isCompleted: json['is_completed'] as bool? ?? false,
    );
  }

  // Chuyển đổi từ Object Model sang Map để gửi lên API (POST/PATCH)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'title': title,
      'description': description,
      'is_completed': isCompleted,
    };
    if (id != null) {
      data['id'] = id;
    }
    return data;
  }

  @override
  List<Object?> get props => [id, title, description, isCompleted];
}
