# J'Donuts

Offline-first Flutter app (auth, home, product, rewards) built with Clean Architecture.

## Versions

| Tool | Version |
|---|---|
| Flutter | 3.47.9 (stable) |
| Dart | 3.13.7 |

## Architecture

Three layers, feature-first (`lib/features/{auth,home,product,rewards}/{presentation,domain,data}`):

- **Presentation** — screens, widgets, BLoC, `go_router` with an auth redirect guard.
- **Domain** — pure Dart: entities, use cases, repository interfaces, validators. No Flutter imports.
- **Data** — repository implementations. The UI reads only the local **Drift (SQLite)** database
  (seeded from bundled JSON); the optional mock server only refreshes it in the background.
  Fake auth uses a local user store and a session in `flutter_secure_storage`.

Repositories and use cases return typed failures as `Result<T>` (`Either<Failure, T>` from fpdart).

## Why BLoC

- Explicit events → states make each screen's loading / error / empty / success flow easy to
  follow and to test with `bloc_test`.
- Keeps business logic out of widgets and fits the use-case layer one-to-one.
- Paired with **get_it + injectable** for DI, so nothing is constructed inside widgets and
  fakes (auth, mock server) can be swapped without touching the UI.

## Run

```bash
flutter pub get
flutter gen-l10n
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## Test

```bash
flutter analyze
flutter test
flutter test integration_test
```

## Database migrations

1. Change tables and bump `schemaVersion` in `lib/core/database/app_database.dart`.
2. `dart run build_runner build --delete-conflicting-outputs`
3. `dart run drift_dev make-migrations` — saves the schema snapshot in `drift_schemas/` and
   generates step helpers and migration tests in `test/drift/`.
4. Add the new step to `onUpgrade` (`stepByStep(...)`).
