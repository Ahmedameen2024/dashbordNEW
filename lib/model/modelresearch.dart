class Research {
  String id;
  String departmentId;
  String title;
  String team;
  String year;
  String summary;
  String fileUrl;

  Research({
    required this.id,
    required this.departmentId,
    required this.title,
    required this.team,
    required this.year,
    required this.summary,
    required this.fileUrl,
  });

  factory Research.fromMap(Map<String, dynamic> data, String docId) {
    return Research(
      id: docId,
      departmentId: data['departmentId'],
      title: data['title'],
      team: data['team'],
      year: data['year'],
      summary: data['summary'],
      fileUrl: data['fileUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'departmentId': departmentId,
      'title': title,
      'team': team,
      'year': year,
      'summary': summary,
      'fileUrl': fileUrl,
    };
  }
}
