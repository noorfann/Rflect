# Template Feature Technical Decisions

## 1. Template Categories Implementation

### Question
Should we implement template categories as an enum or free-form tags?

### Recommendation
Implement as a hybrid system:
```swift
enum TemplateCategory: String, CaseIterable {
    case morning = "Morning Reflection"
    case evening = "Evening Reflection"
    case gratitude = "Gratitude"
    case goals = "Goals & Planning"
    case custom = "Custom"
}

// In TemplateModel
var category: TemplateCategory
var customTags: [String]? // For user-defined categorization
```

**Rationale:**
- Predefined categories provide structure and easy filtering
- Custom tags allow flexibility for user organization
- Maintains data consistency while supporting extensibility
- Easier to implement UI filters with enum-based categories

## 2. Template Versioning

### Question
Do we want to support template versioning?

### Recommendation
No, defer template versioning for future releases.

**Rationale:**
- Adds significant complexity to data model and sync
- Limited user value in initial release
- Can be added later if user feedback indicates need
- Focus on core template functionality first

## 3. Rich Text Formatting

### Question
Should templates support rich text formatting?

### Recommendation
Start with basic Markdown support:
```swift
extension TemplateModel {
    // Markdown parsing helper
    var formattedBody: AttributedString {
        try? AttributedString(markdown: body) ?? AttributedString(body)
    }
}
```

**Rationale:**
- Markdown is lightweight and familiar
- SwiftUI has built-in Markdown support
- Avoids complexity of full rich text editing
- Can expand formatting options in future releases

## 4. Custom Template Limits

### Question
Do we need a limit on custom template creation?

### Recommendation
Implement soft limits with monitoring:

```swift
class TemplateViewModel: ObservableObject {
    private let maxCustomTemplates = 50
    private let maxTemplateLength = 10000 // characters
    
    func canCreateTemplate() -> Bool {
        return userTemplates.filter { $0.isCustom }.count < maxCustomTemplates
    }
    
    func validateTemplateContent(_ content: String) -> Bool {
        return content.count <= maxTemplateLength
    }
}
```

**Rationale:**
- Prevents potential performance issues
- Protects against abuse
- Still generous for typical use cases
- Can adjust limits based on usage data

## Implementation Impact

These decisions affect our implementation plan in the following ways:

1. **Data Model**
   - Add category enum and tags support
   - Include Markdown processing extensions
   - Add validation fields

2. **ViewModels**
   - Add template validation logic
   - Implement category filtering
   - Add Markdown preview support

3. **Views**
   - Create category selection UI
   - Add Markdown preview in template browser
   - Implement validation feedback
   - Add category-based navigation

## Next Steps

1. Update `TemplateModel` with these decisions
2. Implement basic category system
3. Add Markdown support
4. Create template validation system
5. Update UI components to reflect these choices

Would you like to proceed with implementing these decisions?