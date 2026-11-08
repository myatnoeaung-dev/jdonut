# CLAUDE.md — jdonut (J'Donuts App)

Senior Flutter code test. **Offline-first**: the UI reads only the local database; the server
(if any) just refreshes it. Detailed rules live in `.claude/rules/`.

## Stack decisions (fixed)

| Area | Choice |
|---|---|
| Flutter / Dart | Latest stable — list the exact versions (`flutter --version`) in `README.md` |
| State management | **BLoC** (`flutter_bloc`) — reason goes in `README.md` |
| DI | **get_it + injectable** — no services created inside widgets |
| Navigation | `go_router` with an auth redirect guard and a `/product/:id` route |
| Local database | **Drift (SQLite)**, seeded from bundled JSON, versioned migrations |
| Session | `flutter_secure_storage` |
| Models | Immutable — `freezed` + `json_serializable` for data models; Dart 3 sealed classes / records welcome |
| Errors | Typed `Failure`s returned as `Result<T>` (`Either<Failure, T>`, fpdart); no swallowed exceptions |
| Images | `cached_network_image` with disk cache; seed images bundled as assets; placeholder + error widget |
| Connectivity | `connectivity_plus` **plus** a real reachability check (`NetworkInfo`) |
| Theme | Colours, type, spacing as design tokens in one theme — no hard-coded colours in widgets |
| Text | ARB files through `gen-l10n`; Burmese (`my`) locale is a bonus |
| Lints | `flutter analyze` clean (`flutter_lints` or `very_good_analysis`) |

## Architecture — Clean Architecture, 3 layers, feature-first

```
Presentation (Flutter)  screens, widgets, BLoC, go_router + auth guard
        │ calls use cases
Domain (pure Dart)      entities, use cases, repository interfaces, validators — NO Flutter imports
        ▲ implements the interfaces
Data                    repository impls: read the local DB, refresh in background when online,
                        return typed failures
   ├─ Local database    Drift (SQLite), seeded from JSON — what the UI reads
   ├─ Remote source     optional mock server, /v1 with a response envelope — writes into local DB
   ├─ Image cache       disk cache, seed images as assets, placeholder + error
   └─ Fake auth         fake repository, local user store, secure session
```

Presentation depends on domain; data implements domain's interfaces. Swapping fake auth or the
mock server for real ones must never touch the UI.

```
lib/
  core/              theme tokens, router, DI (get_it+injectable), Drift database + migrations,
                     dio client, NetworkInfo, secure storage, Failure/Result, BaseRepository,
                     PageStatus, shared widgets
  l10n/              app_en.arb, app_my.arb
  features/
    auth/  home/  product/  rewards/
      data/
        datasources/   local (Drift DAO) + remote (mock server) — throw Failure, never raw exceptions
        models/        freezed + json_serializable, always toEntity()
        repositories/  implement domain interfaces; local-first read + background refresh
      domain/          pure Dart only
        entities/      immutable
        repositories/  abstract, return Result<T>
        usecases/      @lazySingleton, single call()
        validators/    email, password, name, phone… (pure functions/classes)
      presentation/
        bloc/          events + states + bloc (@injectable)
        pages/         BlocProvider via getIt<XBloc>()
        widgets/       feature-specific widgets
assets/
  seed/              products.json, rewards.json …
  images/            bundled seed images
test/  integration_test/
```

## Non-negotiables

- Domain layer: no `package:flutter/...` imports (pure Dart packages like `fpdart`, `equatable` are fine).
- Every screen has **loading, error and empty** states.
- Portrait phones 4.7"–6.9"; text scale up to **1.3** without overflow.
- Functions ≈ 20 lines max, files ≈ 300 lines max; named constants, no magic numbers;
  names that say what things are.
- All user-facing strings come from ARB (`AppLocalizations`), never string literals in widgets.
- Run `dart run build_runner build --delete-conflicting-outputs` after annotation changes.
- `README.md` must state Flutter/Dart versions, why BLoC, how to run, and how to run tests.
