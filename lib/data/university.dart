class University {
  int id;
  String name;

  University(
    this.id,
    this.name,
  );

  static List<University> getUniversity() {
    return <University>[
      University(1, ''),
      University(2, 'KHTN'),
      University(3, 'Bách Khoa'),
      University(4, 'KHTN'),
    ];
  }
}