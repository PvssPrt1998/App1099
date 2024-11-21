import Foundation
import CoreData


extension WorkoutCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutCD> {
        return NSFetchRequest<WorkoutCD>(entityName: "WorkoutCD")
    }

    @NSManaged public var uuid: UUID
    @NSManaged public var sport: String
    @NSManaged public var date: String
    @NSManaged public var time: String
    @NSManaged public var visits: String
    @NSManaged public var tag: String

}

extension WorkoutCD : Identifiable {

}
