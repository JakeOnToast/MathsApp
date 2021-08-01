enum Mode{
  play,
  practice,
  learn,
  endless,
}

String getModeName(Mode mode){
  switch (mode){

    case Mode.play:
      return "Play";
    case Mode.practice:
      return "Practice";
    case Mode.learn:
      return "Learn";
    case Mode.endless:
      return "Endless";
  }
}