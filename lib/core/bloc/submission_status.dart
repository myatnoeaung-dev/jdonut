/// Progress of a form submission (a Continue tap and its fake network call).
enum SubmissionStatus {
  idle,
  submitting,
  success,
  failure;

  bool get isSubmitting => this == SubmissionStatus.submitting;
}
