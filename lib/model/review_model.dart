class Review {
  final String author;
  final String content;

  Review({required this.author, required this.content});

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      author: map['author'] ?? 'Anónimo',
      content: map['content'] ?? '',
    );
  }
}