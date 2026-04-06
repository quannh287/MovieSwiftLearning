# MovieSwiftLearning

A SwiftUI iOS learning project for browsing movies (TMDB-based), built with MVVM architecture.
Vietnamese comments throughout the codebase compare SwiftUI patterns to React Native and Flutter equivalents.

## Design

Figma: https://www.figma.com/design/ZsMehrnhxSu8n6U2tY5vS7/Movie-App--Community-?node-id=0-1&p=f&t=rBRRsgHH2hlwznI1-0

## Tech Stack

- **Language:** Swift 5
- **UI Framework:** SwiftUI (iOS 18+)
- **Architecture:** MVVM (`ObservableObject` ViewModels + SwiftUI Views)
- **Navigation:** Centralized router (`MovieSwiftRouter`) with `NavigationStack`
- **Persistence:** `UserDefaults` (login flag, selected genres)
- **Dependencies:** None (no SPM / CocoaPods / Carthage)

## App Flow

```
Onboarding
  ├─ (Skip / Next) + isLoggedIn = true  →  Main
  └─ (Skip / Next) + isLoggedIn = false →  Auth (SignIn / SignUp / Success)
                                                    ↓
                                                  Main
                                                    ↓ Logout
                                                Onboarding
```

## Project Structure

```
MovieSwiftLearning/
├── App/
│   ├── MovieSwiftLearningApp.swift   # @main entry point
│   ├── ContentView.swift             # Root route switch
│   └── MovieSwiftRouter.swift        # Global navigation state
├── Features/
│   ├── Onboarding/                   # Poster grid + genre picker
│   ├── Auth/                         # SignIn / SignUp / Success
│   ├── Main/                         # TabView: Movies, Tickets, Profile
│   └── Movie/                        # List, Detail, Row views + ViewModel
├── Shared/
│   ├── Components/                   # MoviePosterImage, MovieRatingBadge
│   ├── Modifiers/                    # ShimmerStyle, PosterStyle
│   └── Extensions/                   # Color+Theme
└── Services/                         # (planned) TMDB API integration
```

## Build & Run

Requires Xcode 16+ and an iOS 18 simulator.

```sh
xcodebuild -project MovieSwiftLearning.xcodeproj \
  -scheme MovieSwiftLearning \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro' \
  build
```

## Tests

```sh
# All unit tests
xcodebuild test \
  -project MovieSwiftLearning.xcodeproj \
  -scheme MovieSwiftLearning \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro'
```
