import Foundation
import CoreData


extension SubscriptionCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubscriptionCD> {
        return NSFetchRequest<SubscriptionCD>(entityName: "SubscriptionCD")
    }

    @NSManaged public var uuid: UUID
    @NSManaged public var name: String
    @NSManaged public var startDate: String
    @NSManaged public var endDate: String
    @NSManaged public var visits: String
    @NSManaged public var price: String
    @NSManaged public var type: String

}

extension SubscriptionCD : Identifiable {

}
