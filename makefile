# https://medium.com/flutter-community/automating-flutter-workflows-with-the-makefile-423b8e023c9a
.PHONY: build_runner clean gen gen_locale install integration_test test

build_runner: # Run build_runner
	@fvm dart run build_runner watch --delete-conflicting-outputs

clean: # Clean everything in the project, download dependencies, generate code
	@rm ios/Podfile.lock || true
	@fvm flutter clean
	@fvm flutter pub get
	@make gen

gen: # Generates localization and freezed files in project
	@make gen_locale
	@fvm dart run build_runner build --delete-conflicting-outputs

gen_locale: # Generates localization and freezed files in project
	@fvm flutter gen-l10n --arb-dir "assets/localization" --template-arb-file "app_en.arb" --output-localization-file "app_localizations.gen.dart" --output-dir "lib/assets" --no-synthetic-package

install: # Install any required packages
	@dart pub global activate fvm
	@fvm install 3.27.3
	@fvm use 3.27.3
	@fvm dart pub global activate patrol_cli

integration_test: # Runs Patrol Integration tests 
	@patrol test --target integration_test --flavor develop

test: # Runs Flutter tests 
	@fvm flutter test
