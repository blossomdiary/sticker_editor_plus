# Repository Guidelines

## Project Structure & Module Organization
- `lib/` contains the plugin source, with public entrypoints in `lib/sticker_editor_plus.dart` and implementation under `lib/src/`.
- `assets/` holds built-in icons used by the editor UI; example images live in `example/assets/`.
- Platform integrations are under `android/`, `ios/`, and `macos/`; web support is in `lib/src/sticker_editor_web.dart`.
- The example app lives in `example/` (see `example/lib/` and `example/test/`).

## Build, Test, and Development Commands
- `flutter pub get` installs dependencies.
- `flutter analyze` runs static analysis using `flutter_lints`.
- `flutter test` runs package tests (none in the root today) and should still pass.
- `cd example && flutter run` launches the demo app for manual verification.

## Coding Style & Naming Conventions
- Dart formatting is standard `dart format`/`flutter format` with 2-space indentation.
- File names are `snake_case.dart`; classes and widgets use `UpperCamelCase`; private members use leading `_`.
- Keep public API changes minimal and document any new parameters or behaviors in `README.md` when relevant.

## Testing Guidelines
- Tests use `flutter_test` and follow `*_test.dart` naming.
- Place plugin tests at `test/` (if added) and example app tests in `example/test/`.
- There is no stated coverage threshold; add tests for new behaviors or bug fixes when feasible.

## Commit & Pull Request Guidelines
- Recent history uses short, imperative subjects with optional prefixes like `feat:`, `fix:`, `ui:`, or `example:` and release tags like `Release vX.Y.Z`.
- Match this style and keep commits scoped to a single logical change.
- PRs should include a concise description, link related issues, and attach screenshots or GIFs for UI changes.

## Configuration Notes
- macOS requires the `com.apple.security.network.client` entitlement for `NetworkImage` usage in the example app (see `README.md`).
