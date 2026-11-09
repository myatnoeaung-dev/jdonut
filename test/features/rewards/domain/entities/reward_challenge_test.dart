import 'package:flutter_test/flutter_test.dart';

import 'package:jdonut/features/rewards/domain/entities/reward_challenge.dart';

RewardChallenge _challenge({required int progress, int goal = 4}) => RewardChallenge(
  id: 'c',
  title: 'Eat 4 Coco donuts',
  imageUrl: 'assets/images/donuts/marshmallow.png',
  kind: ChallengeKind.eat,
  progress: progress,
  goal: goal,
  rewardPoints: 100,
);

void main() {
  test('is completed once progress reaches the goal', () {
    expect(_challenge(progress: 4).isCompleted, isTrue);
    expect(_challenge(progress: 3).isCompleted, isFalse);
  });

  test('completion is progress over goal, capped at 1', () {
    expect(_challenge(progress: 1).completion, 0.25);
    expect(_challenge(progress: 6).completion, 1);
  });

  test('completion is full when there is no goal', () {
    expect(_challenge(progress: 0, goal: 0).completion, 1);
  });
}
