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

## Folder structure

```
lib/
├─ main.dart, app.dart     app entry: seed DB, restore session, start connectivity
├─ core/
│  ├─ bloc/                shared bloc state types: PageStatus, SubmissionStatus
│  ├─ constants/           asset paths, seed file names
│  ├─ database/            Drift AppDatabase, migrations, tables/, seed/ loader
│  ├─ di/                  get_it + injectable setup (generated config)
│  ├─ entities/            shared entities (PaginatedResponse)
│  ├─ error/               Failure types, Result<T>, Dio error mapping
│  ├─ extensions/          context.l10n, price formatting
│  ├─ l10n/                app language + locale controller
│  ├─ models/              ApiEnvelope<T> (the /v1 response wrapper)
│  ├─ network/             Dio, ApiClient, mock server, NetworkInfo, ConnectivityCubit, image cache
│  ├─ repositories/        BaseRepository (failure mapping, refresh-when-online)
│  ├─ router/              go_router config, auth guard, bottom-nav shell
│  ├─ storage/             secure session storage
│  ├─ theme/               colours, typography, spacing tokens, AppTheme
│  ├─ time/                Clock and OTP countdown ticker (testable time)
│  ├─ usecase/             UseCase base class
│  └─ widgets/             shared widgets: AppNetworkImage, Loading/Error/Empty views, offline banner
├─ features/
│  ├─ auth/                phone + OTP sign-in, profile, fake auth
│  ├─ home/                banners, product sections, nearby shops, member header
│  ├─ product/             product detail
│  ├─ rewards/             member tier and loyalty points
│  └─ settings/            profile header and settings tiles (presentation only)
└─ l10n/                   app_en.arb, app_my.arb

Each feature follows the same layout:

features/<feature>/
├─ data/
│  ├─ datasources/         local (Drift), seed (bundled JSON), remote (mock server)
│  ├─ models/              freezed + json_serializable models with toEntity()
│  └─ repositories/        implementations: read local DB, refresh in background
├─ domain/                 pure Dart, no Flutter imports
│  ├─ entities/            immutable entities
│  ├─ repositories/        abstract interfaces returning Result<T>
│  ├─ usecases/            one call() each
│  └─ validators/          input validation (auth)
└─ presentation/
   ├─ bloc/                events, states, blocs
   ├─ pages/               screens (provide blocs via getIt)
   └─ widgets/             feature-specific widgets

assets/
├─ seed/                   products.json, home.json, member.json
├─ images/                 bundled seed images (donuts/, products/)
└─ icons/                  SVG logos and bottom-nav icons

drift_schemas/             exported schema snapshots for migration tests

test/                      mirrors lib/ (core/, features/, drift/ migration tests, helpers/)
integration_test/          register → home → product detail flow
```

## Offline-first data

- **Seed:** on first launch, `assets/seed/{products,home,member}.json` are loaded into Drift
  (products first, since Home sections point at them). Seed images are bundled under `assets/`,
  so a first launch without network still shows them.
- **Read:** Home, Product detail and Rewards read only the local database, through Drift streams.
  After the first launch the app works fully in airplane mode.
- **Refresh:** when online, the app refreshes in the background on opening Home, on
  pull-to-refresh and when the connection returns. A failed refresh shows a small message;
  saved data stays on screen. A small banner shows while offline.
- **Connectivity:** `connectivity_plus` plus a real DNS reachability check (`NetworkInfo`),
  exposed app-wide by `ConnectivityCubit`.
- **Mock server:** Dio with `MockServerInterceptor` answers `/v1/home`, `/v1/products` and
  `/v1/members/me` in a `{ data, meta, error }` envelope. To use a real API, remove the
  interceptor in `core/network/network_module.dart`; feature code doesn't change.
- **Images:** `AppNetworkImage` renders asset paths with `Image.asset` and URLs with
  `cached_network_image` on a shared disk cache. Both have a placeholder and an error state.
- **One member record:** the mock-ups disagree (Home: Bronze, 1,290 points to Gold; Rewards:
  Silver, 500). The app keeps a single `members` row, seeded as **Silver, 500 points, 500 to
  Gold**. Home, Rewards and Settings all read it through `MemberBloc`, so they always match.

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
