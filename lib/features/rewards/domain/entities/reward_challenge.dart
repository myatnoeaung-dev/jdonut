import 'package:equatable/equatable.dart';

/// What the member has to do: eat donuts or drink cups.
enum ChallengeKind { eat, drink }

/// An "Eat more earn more" challenge: buy [goal] items to earn [rewardPoints].
class RewardChallenge extends Equatable {
  const RewardChallenge({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.kind,
    required this.progress,
    required this.goal,
    required this.rewardPoints,
  });

  final String id;
  final String title;

  /// Bundled asset path or network URL.
  final String imageUrl;
  final ChallengeKind kind;

  /// Items bought so far, out of [goal].
  final int progress;
  final int goal;
  final int rewardPoints;

  /// The member can claim the points.
  bool get isCompleted => progress >= goal;

  /// Progress from 0 to 1.
  double get completion => goal <= 0 ? 1 : (progress / goal).clamp(0, 1).toDouble();

  @override
  List<Object?> get props => [id, title, imageUrl, kind, progress, goal, rewardPoints];
}
