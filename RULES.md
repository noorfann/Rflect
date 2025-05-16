# Rflect Project Rules

## Project Structure
The codebase follows MVVM architecture with clear separation of concerns:
```
Rflect/
├── Models/            # Data models
├── Core/
│   ├── Components/    # Reusable UI components
│   └── {Feature}/    
│       ├── Views/     # Feature-specific views
│       └── ViewModels/# Feature-specific view models
└── Extensions/        # Swift extensions
```

## Technical Requirements

### SwiftUI and SwiftData Integration
- Models must use `@Model` macro for SwiftData compatibility
- ViewModels must be marked with `@MainActor`
- Views must use `@EnvironmentObject` for shared view model access

### Data Model Requirements
- Models must have unique identifiers using `@Attribute(.unique)`
- Use enums for fixed value sets (like `Mood`)
- Include proper initialization methods
- Follow SwiftData persistence patterns

### ViewModel Guidelines
- Must conform to `ObservableObject`
- Use `@Published` for observable properties
- Include CRUD operations
- Handle errors gracefully with try-catch blocks
- Implement preview providers for testing

### View Guidelines
- Use `NavigationStack` for navigation
- Implement proper state management with `@State`
- Follow iOS design patterns for sheets and navigation
- Include preview providers
- Use custom components for reusability

### Component Rules
- Create reusable UI components
- Follow SwiftUI view modifier pattern
- Implement proper parameter passing
- Use proper naming conventions

### Error Handling
- Use do-catch blocks for error handling
- Proper error logging in catch blocks
- Graceful error recovery when possible

### Preview Requirements
- Include preview providers for views
- Use in-memory storage for previews
- Provide sample data for testing

### Code Style
- Clear file organization
- Proper documentation for complex logic
- Consistent naming conventions
- Clear separation of concerns

## Examples

### Model Example
```swift
@Model
class JournalModel {
    @Attribute(.unique) var id: UUID
    var date: Date
    var title: String
    var notes: String
    var moodValue: Int
    
    // Proper initialization
    init(title: String, notes: String, mood: Mood) {
        self.id = UUID()
        self.date = Date()
        self.title = title
        self.notes = notes
        self.moodValue = mood.rawValue
    }
}
```

### ViewModel Example
```swift
@MainActor
class JournalViewModel: ObservableObject {
    @Published var journals: [JournalModel] = []
    
    private var context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
        loadJournals()
    }
    
    func loadJournals() {
        // Implementation with error handling
        do {
            journals = try context.fetch(descriptor)
        } catch {
            print("Error loading entries: \(error)")
        }
    }
}
```

### View Example
```swift
struct HomeView: View {
    @EnvironmentObject private var viewModel: JournalViewModel
    @State private var showingJournalForm = false
    
    var body: some View {
        NavigationStack {
            // Implementation
        }
    }
}