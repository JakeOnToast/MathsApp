class MathsAppError extends Error{

  final String message;

  MathsAppError(this.message);

  @override
  String toString() {
    return "Maths App Error: $message";
  }

}