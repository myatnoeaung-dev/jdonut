import '../../../../core/constants/app_images.dart';
import '../../domain/entities/reward_challenge.dart';

/// Temporary challenges for building the Rewards UI. They will move to
/// `assets/seed/` and the local database, like the rest of the app's data.
const List<RewardChallenge> sampleRewardChallenges = [
  RewardChallenge(
    id: 'c_coco_4_done',
    title: 'Eat 4 Coco donuts',
    imageUrl: AppImages.donutMarshmallow,
    kind: ChallengeKind.eat,
    progress: 4,
    goal: 4,
    rewardPoints: 100,
  ),
  RewardChallenge(
    id: 'c_coco_4',
    title: 'Eat 4 Coco donuts',
    imageUrl: AppImages.donutVanillaCaramel,
    kind: ChallengeKind.eat,
    progress: 1,
    goal: 4,
    rewardPoints: 100,
  ),
  RewardChallenge(
    id: 'c_americano_12',
    title: 'Drink 12 cups americano',
    imageUrl: AppImages.americano,
    kind: ChallengeKind.drink,
    progress: 9,
    goal: 12,
    rewardPoints: 100,
  ),
  RewardChallenge(
    id: 'c_biscoff_3',
    title: 'Eat 3 Chocolate Biscoff donuts',
    imageUrl: AppImages.donutChocolateBiscoff,
    kind: ChallengeKind.eat,
    progress: 3,
    goal: 3,
    rewardPoints: 80,
  ),
  RewardChallenge(
    id: 'c_latte_6',
    title: 'Drink 6 cups latte',
    imageUrl: AppImages.latte,
    kind: ChallengeKind.drink,
    progress: 6,
    goal: 6,
    rewardPoints: 60,
  ),
];
