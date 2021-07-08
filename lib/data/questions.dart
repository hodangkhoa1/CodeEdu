class Question {
  final int id, answer;
  final String question;
  final List<String> code;
  final List<String> options;

  Question({
    this.code,
    this.id,
    this.question,
    this.answer, 
    this.options
  });
}

const List question_data = [
  {
    "id": 1,
    "question": "The C programming language developed by Dennish is based on which programming language?",
    "options": ['Language B', 'Language BCPL', 'Language DEC PDP', 'Language B and BCPL'],
    "answer_index": 3,
  },
  {
    "id": 2,
    "question": "What year was the programming language introduced by Dennish?",
    "options": ['1967', '1972', '1970', '1976'],
    "answer_index": 1,
  },
  {
    "id": 3,
    "question": "Which of the following is a structured programming language?",
    "options": ['Assembler language', 'C and Pascal languages', 'Cobol language', 'A, B and C'],
    "answer_index": 1,
  },
  {
    "id": 4,
    "question": "Which of the following variable names are spelled correctly according to the naming conventions of the C programming language?",
    "options": ['diem toan', '3diemtoan', '_diemtoan', '-diemtoan'],
    "answer_index": 2,
  },
];