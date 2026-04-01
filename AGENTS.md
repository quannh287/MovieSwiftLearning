# AGENTS.md — MovieSwiftLearning

## Project Overview

SwiftUI iOS application for browsing movies (TMDB-based). Uses the MVVM architecture
pattern with `ObservableObject` ViewModels and SwiftUI Views. Currently uses mock data;
real API integration is planned. The project is a learning codebase with Vietnamese
comments comparing SwiftUI patterns to React Native and Flutter equivalents.

- **Language:** Swift 5
- **UI Framework:** SwiftUI (iOS 18.4+)
- **Architecture:** MVVM (Model → ViewModel → View)
- **Dependency Management:** None (no SPM, CocoaPods, or Carthage)
- **Linter/Formatter:** None configured (no SwiftLint or SwiftFormat)

## Build / Test / Run Commands

All commands use the `MovieSwiftLearning` scheme. Default simulator: `iPhone 16 Pro`.

### Build
```sh
xcodebuild -project MovieSwiftLearning.xcodeproj \
  -scheme MovieSwiftLearning \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro' \
  build
```

### Run All Unit Tests
```sh
xcodebuild -project MovieSwiftLearning.xcodeproj \
  -scheme MovieSwiftLearning \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro' \
  test
```

### Run a Single Test (by class or method)
```sh
# Single test class:
xcodebuild test \
  -project MovieSwiftLearning.xcodeproj \
  -scheme MovieSwiftLearning \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro' \
  -only-testing:MovieSwiftLearningTests/MovieSwiftLearningTests

# Single test method:
xcodebuild test \
  -project MovieSwiftLearning.xcodeproj \
  -scheme MovieSwiftLearning \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro' \
  -only-testing:MovieSwiftLearningTests/MovieSwiftLearningTests/example
```

### Run UI Tests
```sh
xcodebuild test \
  -project MovieSwiftLearning.xcodeproj \
  -scheme MovieSwiftLearning \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro' \
  -only-testing:MovieSwiftLearningUITests
```

## Project Structure

```
MovieSwiftLearning/
├── App/                          # App entry point and root views
│   ├── MovieSwiftLearningApp.swift   # @main App struct
│   └── ContentView.swift             # TabView root (Movies, Discover, Fan Club, My Lists)
├── Features/                     # Feature modules (one per tab/domain)
│   ├── Movie/
│   │   ├── Models/               # Data models (Codable structs)
│   │   ├── ViewModels/           # ObservableObject classes
│   │   └── Views/                # SwiftUI View structs
│   ├── Discover/Views/
│   ├── FanClub/Views/
│   └── MyList/Views/
├── Shared/                       # Cross-feature reusable code
│   ├── Components/               # Reusable View structs
│   └── Modifiers/                # ViewModifier structs + View extensions
└── Assets.xcassets/
MovieSwiftLearningTests/          # Swift Testing framework (unit tests)
MovieSwiftLearningUITests/        # XCTest UI tests
```

## Code Style Guidelines

### File Headers
Every file starts with a comment block containing the filename and project name:
```swift
//
//  FileName.swift
//  MovieSwiftLearning
//
```

### Imports
- Import only what is needed: `SwiftUI` for views, `Foundation` for models/logic,
  `Combine` for ViewModels using reactive patterns.
- One import per line, no blank line between imports.
- Order: `Foundation` / `SwiftUI` / `Combine` (standard frameworks first).

### Naming Conventions
- **Types** (structs, classes, enums, protocols): `UpperCamelCase`
- **Properties, methods, variables**: `lowerCamelCase`
- **Views**: Suffix with `View` (e.g., `MoviesListView`, `MovieDetailView`)
- **ViewModels**: Suffix with `ViewModel` (e.g., `MoviesListViewModel`)
- **ViewModifiers**: Named as style structs (e.g., `ShimmerStyle`, `PosterStyle`)
- **View extensions** for modifiers: use `lowerCamelCase` method names (e.g., `.shimmerStyle()`, `.posterStyle(size:)`)
- **Enums**: Cases are `lowerCamelCase` (e.g., `PosterSize.small`, `.medium`, `.big`)
- **CodingKeys**: Map `snake_case` JSON keys to `camelCase` Swift properties explicitly.

### Types and Data Modeling
- Models are `struct` conforming to `Identifiable` and `Codable`.
- Use `CodingKeys` enum to map between JSON `snake_case` and Swift `camelCase`.
- Computed properties for derived values (e.g., `posterURL`, `formattedRating`).
- Mock data lives as `static let mockData` in an extension on the model, under `// MARK: - Mock Data`.

### Views
- Views are `struct` conforming to `View`.
- Use `@StateObject` for ViewModels owned by the view.
- Use `let` properties for data passed in (props).
- Private computed properties for sub-views (e.g., `private var loadingRow: some View`).
- Every view file should include a `#Preview {}` block at the bottom.
- Use `// MARK: -` comments to separate logical sections.

### ViewModels
- Declared as `final class` conforming to `ObservableObject`.
- Published properties use `@Published`.
- Private methods for internal logic (e.g., `private func loadMockData()`).

### ViewModifiers
- Defined as `struct` conforming to `ViewModifier`.
- Accompanied by a `View` extension providing a convenience method.
- Pattern: `struct FooStyle: ViewModifier` + `extension View { func fooStyle() -> some View }`.

### Formatting
- 4-space indentation (Xcode default).
- Trailing closures for SwiftUI modifiers and builders.
- Chained modifiers each on their own line, indented under the view.
- Use `Group {}` to conditionally switch between view branches.
- Spacing values are passed as explicit numeric literals (e.g., `spacing: 12`, `.padding(16)`).

### Error Handling
- AsyncImage uses `switch phase` to handle `.empty`, `.success`, `.failure`, and `@unknown default`.
- Optional values use `guard let` or `if let` unwrapping (not force-unwrapping).
- No `try!` or `as!` — always handle errors gracefully.

### Comments
- This is a learning codebase: comments compare SwiftUI patterns to React Native / Flutter.
- Use `//` inline comments for explanations, not `/* */` block comments.
- `// MARK: -` for section headers in longer files.
- Comments may be in Vietnamese for learning context; code identifiers are always in English.

### Previews
- Every `View` file must have a `#Preview {}` block.
- Previews should demonstrate the component with realistic mock data.
- Use `Movie.mockData` for preview data rather than creating ad-hoc instances.

### Adding New Features
1. Create a new directory under `Features/<FeatureName>/` with `Models/`, `ViewModels/`, `Views/` subdirectories as needed.
2. Reusable components go in `Shared/Components/`.
3. Reusable modifiers go in `Shared/Modifiers/` with a corresponding `View` extension.
4. Wire new top-level views into `ContentView.swift` TabView.
5. Add `#Preview` blocks to all new View files.
