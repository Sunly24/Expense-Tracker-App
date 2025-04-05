class Expense {
  final String? id;
  final double amount;
  final String category;
  final DateTime date;
  final String? notes;

  Expense({
    this.id,
    required this.amount,
    required this.category,
    required this.date,
    this.notes,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'] as String?,
      amount: (json['amount'] as num).toDouble(),
      category: json['category'] as String,
      date: DateTime.parse(json['date'] as String),
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
      if (notes != null) 'notes': notes,
    };
  }

  Expense copyWith({
    String? id,
    double? amount,
    String? category,
    DateTime? date,
    String? notes,
  }) {
    return Expense(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      notes: notes ?? this.notes,
    );
  }
}
