import Foundation
import CoreData


extension ProgressCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProgressCD> {
        return NSFetchRequest<ProgressCD>(entityName: "ProgressCD")
    }

    @NSManaged public var uuid: UUID
    @NSManaged public var name: String
    @NSManaged public var descr: String
    @NSManaged public var unit: String
    @NSManaged public var quantity: Int32
    @NSManaged public var totalQuantity: Int32

}

extension ProgressCD : Identifiable {

}
