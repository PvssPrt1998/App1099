import Foundation
import CoreData


extension FinanceCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FinanceCD> {
        return NSFetchRequest<FinanceCD>(entityName: "FinanceCD")
    }

    @NSManaged public var uuid: UUID
    @NSManaged public var name: String
    @NSManaged public var price: String
    @NSManaged public var benefit: String
    @NSManaged public var promotion: String

}

extension FinanceCD : Identifiable {

}
