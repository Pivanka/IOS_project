
import Foundation

@objc public enum Category: Int16, CaseIterable
{
    case groceries
    case photos
    case appointments
    case birthdays
    case chores
    case inbox
    case drinks
    case trips
    case other
}

func categoryName(category: Category) -> String
{
    switch category{
    case .photos:
        return "Photos"
    case .appointments:
        return "Appointments"
    case .birthdays:
        return "Birthdays"
    case .chores:
        return "Chores"
    case .inbox:
        return "Inbox"
    case .drinks:
        return "Drinks"
    case .other:
        return "Other"
    case .groceries:
        return "Groceries"
    case .trips:
        return "Trips"
        
    default:
        return "Other"
    }
}
