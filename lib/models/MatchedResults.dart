class MatchedResults {
  final String postId;
  final String companyId;
  final String postTitle;
  final String content;

  MatchedResults({
    required this.postId,
    required this.companyId,
    required this.postTitle,
    required this.content,
  });

  factory MatchedResults.fromJson(Map<String, dynamic> json) {
    return MatchedResults(
      postId: json['postId'],
      companyId: json['companyId'],
      postTitle: json['postTitle'],
      content: json['content'],
    );
  }
}