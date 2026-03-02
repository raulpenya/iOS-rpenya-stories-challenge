# iOS-rpenya-stories-challenge

## Overview

This project is an implementation of a Stories feature inspired by common social media patterns.  
The goal was to deliver a functional, clean, and maintainable solution within a **4-hour time constraint**, focusing on architecture, state management, and user experience.

The application allows:

- Horizontal browsing of stories
- Full-screen story presentation
- Marking stories as seen
- Liking/unliking stories
- Persisting user activity
- Paginated story loading
- Basic error handling

---

# Challenge Constraints

## Time Limit

- ⏱ 4 hours maximum

The solution prioritizes:
- Architectural clarity
- Separation of concerns
- Testability
- Correct state ownership
- Simplicity over premature optimization

---

# Implemented Features

## 1. Stories List (Horizontal)

- Horizontally scrollable list using `ScrollView` + `LazyHStack`
- Pagination triggered when reaching the last element
- Seen stories visually differentiated
- Tap opens full-screen story view

## 2. Full-Screen Story Viewer

- Horizontal paginated scroll
- Paging behavior via `.scrollTargetBehavior(.paging)`
- Vertical drag-to-dismiss gesture
- Marks story as seen on appearance
- Like/Unlike interaction
- Error alerts bound to ViewModel state

## 3. Persistence

- User activity stored in `UserDefaults`
- Persisted data:
  - `seenStoryIds`
  - `likedStoryIds`
- Codable-based encoding/decoding

## 4. Data Layer

- Stories loaded from local JSON
- Paginated via modulo logic
- Repository abstraction to isolate data source

## 5. Error Handling

- Errors propagated to ViewModel
- UI-bound alert state via `Identifiable` wrapper
- Graceful bootstrap failure handling

---

# Architecture & Design Decisions

## 1. MVVM with Clear Dependency Boundaries

The architecture follows:
```
View
↓
ViewModel (@Observable)
↓
Repository Protocols
↓
Concrete Data Implementations
```

This ensures:

- UI logic isolated from business logic
- Data layer replaceable
- ViewModel fully testable
- Clear separation of responsibilities

---

## 2. Repository Pattern

Two repository protocols were defined:

```swift
protocol StoryRepository
protocol UserActivityRepository
```
Benefits:
- Abstraction over data source
- Enables mocking
- Allows replacing local JSON with network layer
- Decouples persistence from business logic

## 3. Coordinator for Bootstrapping

RootCoordinator is responsible for:
- Creating repositories
- Injecting dependencies
- Constructing the ViewModel
This avoids:
- Dependency creation inside views
- Tight coupling between UI and infrastructure

## 4. State Management Strategy
Observation System (Swift 6 / iOS 17)

@Observable is used for:
```swift
@Observable
final class StoryListViewModel
```
Views use:
```swift
@Bindable var viewModel
```
Rationale:
- ViewModel lifecycle is not owned by the View
- Binding access required for alert state
- Avoids misuse of @State for injected dependencies
## 5. Controlled Mutability

`private(set) is used extensively:
```swift
private(set) var stories: [Story]
private(set) var userActivity: UserActivity
```
This ensures:
- Read access from Views
- Mutation restricted to ViewModel methods
- Clear state transition boundaries

## 6. Persistence Design

`PersistenceService` abstracts `UserDefaults`.
Reasons:
- Keeps repository focused on domain logic
- Isolates serialization concerns
- Replaceable with other storage mechanisms

## 7. Pagination Logic

Pagination is simulated via:
```swift
let index = page % pages.count
```
# Technical Stack

- Swift 6
- SwiftUI
- iOS 17 minimum target
- Swift Observation framework
- XcodeGen for project generation

# Project Setup

This project uses XcodeGen to generate the .xcodeproj.

## 1. Install XcodeGen

If not installed:
```swift
brew install xcodegen
```
## 2. Generate the Project

From the root directory:
```swift
make generate
```

This will:
- Run `xcodegen generate`
- Open the generated `.xcodeproj`

Alternatively:
```swift
xcodegen generate
open rpenya-stories-challenge.xcodeproj
```
## 3. Available Make Commands
```swift
make generate   # Generate and open project
make open       # Open existing project
make clean      # Remove project + DerivedData
```

# What I Would Improve With More Time
## 1. Testing
### Unit Tests

- Full ViewModel coverage
- Repository mocking
- Pagination edge cases
- Persistence failure scenarios
- State transition testing
### Snapshot Tests
- Story card UI
- Full-screen layout

## 2. Architecture Enhancements

- Extract domain logic into a dedicated domain layer
- Introduce use-case layer (Clean Architecture style)
- Make persistence asynchronous
- Introduce dependency container instead of manual coordinator

## 3. Concurrency Improvements

Currently synchronous JSON loading.

Improvements:

- Async story loading
- Task cancellation handling
- Loading state exposure
- Proper error domain modeling

## 4. Better Error Modeling

Instead of:
```swift
AlertError(message: String)
```
Use:
```swift
enum StoryError: Error
```
Then map to presentation layer.

## 5. Performance Improvements

- Image caching layer
- Preloading next page
- Memory usage optimization in full-screen mode

## 6. UI/UX Improvements

- Story progress indicator
- Animated like button
- Haptic feedback
- Seen state animation
- Pull-to-refresh

## 7. Code Quality Refinements

- Fix minor naming typo (loadUserActitvity)
- Remove unused helper (generateStories)
- Stronger domain modeling for IDs
- Replace NSError with domain-specific error types

# Summary

Within a 4-hour constraint, this implementation focuses on:

- Clean architecture
- Proper state management
- Clear separation of concerns
- Persistence abstraction
- Scalable design decisions

The project is structured to be easily extendable toward:
- Network-backed data
- Production-ready architecture
- Full test coverage
- Advanced UI polish


