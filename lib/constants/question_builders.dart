import '../models/question.dart';

Question addQuestionBuilder(final int level){
  return Question(level + 1, level + 1);
}