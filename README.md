# vilgain-product-viewer

## Quick note

I did not had an access to an Apple machine, so sadly this project is not tested that it is going to work on iOS devices right now.

## Quick Introduction

Vilgain Product Viewer is a Dart-based application designed to display a list of products. It leverages the BLoC pattern for state management and integrates with both local storage and remote APIs to fetch product data.

## Techstack

- **BLoC**: Business Logic Component pattern for state management.
- **Freezed**: Code generation for immutable classes.
- **getIt**: Dependency Injection.
- **dio**: Networking.
- **auto_route**: Navigation.
- **Mockito**: Mocking framework for unit tests.
- **bloc_test**: Testing utilities for BLoC.

## Makefile Description

The `Makefile` contains various commands to streamline development tasks. Here are some of the key targets:

- `make install`: Should be executed first. Install any necesary dependencies.
- `make clean`: Clean the project, run build_runner again.
- `make build_runner`: Runs the build_runner in watch mode.
- `make test`: Run tests.

## How to Run the Code

- Run `make install` to install `fvm` and other dependencies.
- In VSC run `Debug` target OR run `flutter run` with a connected device.
