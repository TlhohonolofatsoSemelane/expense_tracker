class Budget {
  final String category;
  final double limit;

  Budget({required this.category, required this.limit});

  Map<String, dynamic> toJson() => {
        'category': category,
        'limit': limit,
      };

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      category: json['category'] as String,
      limit: (json['limit'] as num).toDouble(),
    );
  }
}
