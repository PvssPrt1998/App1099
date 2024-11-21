import Foundation

struct Subscription: Hashable {
    var uuid: UUID
    var name: String
    var startDate: String
    var endDate: String
    var visits: String
    var price: String
    var type: String
}

struct Workout: Hashable {
    var uuid: UUID
    var sport: String
    var date: String
    var time: String
    var visits: String
    var tag: String
}

struct Progress: Hashable {
    var uuid: UUID
    var name: String
    var description: String
    var unit: String
    var totalQuantity: Int
    var quantity: Int
}

struct Finance: Hashable {
    let uuid: UUID
    var name: String
    var price: String
    var benefit: String
    var promotion: String
}
