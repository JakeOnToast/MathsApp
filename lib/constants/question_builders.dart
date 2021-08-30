import 'dart:math';

import '../models/question.dart';

final _random = Random();

List<int> generateWrongAnswers({required final int correctAnswer, final int minAnswer=0, required final int maxAnswer, final int stepSize=1}){
  assert(correctAnswer > minAnswer, "min answer must be less than correct answer");
  assert(correctAnswer < maxAnswer, "max answer must be greater than correct answer");
  // create an array from min value to maxAnswer skipping the correct answer
  // then shuffle array to get random answers in the range
  return [for(var i = minAnswer; i < maxAnswer + 1; i+=stepSize) i]..remove(correctAnswer)..shuffle(_random);
}

Question fakeQuestionBuilder(final int level){
  return const Question("a+b", "c", ["c", "b", "a"]);
}

Question addQuestionBuilder(final int level){
  late final String questionString;
  late final String answerString;
  final List<String> choices = [];
  late final List<int> wrongAnswers;

  switch(level){

    case 0:
      final a = _random.nextInt(10) + 1;
      final b = _random.nextInt(10) + 1;
      final answer = a + b;
      questionString = "$a+$b";
      answerString = answer.toString();
      wrongAnswers = generateWrongAnswers(correctAnswer: answer, minAnswer: max(answer - 8, 0), maxAnswer: min(2*answer, answer + 8));
      break;

    case 1:
      final a = _random.nextInt(50) + 1;
      final b = _random.nextInt(50) + 1;
      final answer = a + b;
      questionString = "$a+$b";
      answerString = answer.toString();
      wrongAnswers = generateWrongAnswers(correctAnswer: answer, minAnswer: max(answer - 12, 0), maxAnswer: min(2*answer, answer + 12));
      break;

    case 2:
      // haven't actually done this one
      final a = _random.nextInt(50) + 1;
      final b = _random.nextInt(50) + 1;
      final answer = a + b;
      questionString = "$a+$b";
      answerString = answer.toString();
      wrongAnswers = generateWrongAnswers(correctAnswer: answer, minAnswer: max(answer - 12, 0), maxAnswer: min(2*answer, answer + 12));
      break;

    case 3:
      final a = _random.nextInt(10) + 1;
      final b = _random.nextInt(a);
      final answer = a - b;
      questionString = "$a-$b";
      answerString = answer.toString();
      wrongAnswers = generateWrongAnswers(correctAnswer: answer, minAnswer: 0, maxAnswer: 9);
      break;

    case 4:
      final a = _random.nextInt(75) + 26;
      final b = _random.nextInt(a - 10);
      final answer = a - b;
      questionString = "$a-$b";
      answerString = answer.toString();
      wrongAnswers = generateWrongAnswers(correctAnswer: answer, minAnswer: answer - 12, maxAnswer: answer + 12);
      break;

    case 5:
      final a = _random.nextInt(100);
      final b = _random.nextInt(100) + a + 1;
      final answer = a - b;
      questionString = "$a-$b";
      answerString = answer.toString();
      wrongAnswers = generateWrongAnswers(correctAnswer: answer, minAnswer: answer - 22, maxAnswer: min(answer + 22, 0), stepSize: 2);
      break;

    default:
      questionString = "No level";
      answerString = "N/A";
      wrongAnswers = [1, 2];
      break;
  }

  // add the answer and the first two wrong answers
  choices.add(answerString);
  choices.add(wrongAnswers[0].toString());
  choices.add(wrongAnswers[1].toString());
  // give answers in random order
  choices.shuffle(_random);

  return Question(questionString, answerString, choices);
}