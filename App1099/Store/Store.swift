import Foundation
import CoreData

final class Store {
    
    private let modelName = "CoreDataModel"
    lazy var coreDataStack = CoreDataStack(modelName: modelName)
    
    func saveSubscription(_ subscription: Subscription) {
        let subscriptionCD = SubscriptionCD(context: coreDataStack.managedContext)
        subscriptionCD.uuid = subscription.uuid
        subscriptionCD.name = subscription.name
        subscriptionCD.startDate = subscription.startDate
        subscriptionCD.endDate = subscription.endDate
        subscriptionCD.visits = subscription.visits
        subscriptionCD.price = subscription.price
        subscriptionCD.type = subscription.type
        coreDataStack.saveContext()
    }
    
    func saveWorkout(_ workout: Workout) {
        let workoutCD = WorkoutCD(context: coreDataStack.managedContext)
        workoutCD.uuid = workout.uuid
        workoutCD.sport = workout.sport
        workoutCD.date = workout.date
        workoutCD.time = workout.time
        workoutCD.visits = workout.visits
        workoutCD.tag = workout.tag
        coreDataStack.saveContext()
    }
    
    func saveProgress(_ progress: Progress) {
        let progressCD = ProgressCD(context: coreDataStack.managedContext)
        progressCD.uuid = progress.uuid
        progressCD.name = progress.name
        progressCD.descr = progress.description
        progressCD.quantity = Int32(progress.quantity)
        progressCD.totalQuantity = Int32(progress.totalQuantity)
        coreDataStack.saveContext()
    }
    
    func saveFinance(_ finance: Finance) {
        let financeCD = FinanceCD(context: coreDataStack.managedContext)
        financeCD.uuid = finance.uuid
        financeCD.name = finance.name
        financeCD.price = finance.price
        financeCD.benefit = finance.benefit
        financeCD.promotion = finance.promotion
        coreDataStack.saveContext()
    }
    
    func fetchFinances() throws -> Array<Finance> {
        var array: Array<Finance> = []
        let financesCD = try coreDataStack.managedContext.fetch(FinanceCD.fetchRequest())
        financesCD.forEach { fcd in
            array.append(Finance(uuid: fcd.uuid, name: fcd.name, price: fcd.price, benefit: fcd.benefit, promotion: fcd.promotion))
        }
        return array
    }
    
    func editFinance(_ finance: Finance) {
        do {
            let fsCD = try coreDataStack.managedContext.fetch(FinanceCD.fetchRequest())
            fsCD.forEach { fcd in
                if fcd.uuid == finance.uuid {
                    fcd.name = finance.name
                    fcd.price = finance.price
                    fcd.benefit = finance.benefit
                    fcd.promotion = finance.promotion
                    coreDataStack.saveContext()
                    return
                }
            }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func fetchProgresses() throws -> Array<Progress> {
        var array: Array<Progress> = []
        let progressesCD = try coreDataStack.managedContext.fetch(ProgressCD.fetchRequest())
        progressesCD.forEach { pcd in
            array.append(Progress(uuid: pcd.uuid, name: pcd.name, description: pcd.descr, unit: pcd.unit, totalQuantity: Int(pcd.totalQuantity), quantity: Int(pcd.quantity)))
        }
        return array
    }
    
    func editProgress(_ progress: Progress) {
        do {
            let psCD = try coreDataStack.managedContext.fetch(ProgressCD.fetchRequest())
            psCD.forEach { pcd in
                if pcd.uuid == progress.uuid {
                    pcd.name = progress.name
                    pcd.descr = progress.description
                    pcd.unit = progress.unit
                    pcd.totalQuantity = Int32(progress.totalQuantity)
                    pcd.quantity = Int32(progress.quantity)
                    coreDataStack.saveContext()
                    return
                }
            }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func editWorkout(_ workout: Workout) {
        do {
            let wsCD = try coreDataStack.managedContext.fetch(WorkoutCD.fetchRequest())
            wsCD.forEach { wcd in
                if wcd.uuid == workout.uuid {
                    wcd.sport = workout.sport
                    wcd.date = workout.date
                    wcd.time = workout.time
                    wcd.visits = workout.visits
                    wcd.tag = workout.tag
                    coreDataStack.saveContext()
                    return
                }
            }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func fetchWorkouts() throws -> Array<Workout> {
        var array: Array<Workout> = []
        let workoutsCD = try coreDataStack.managedContext.fetch(WorkoutCD.fetchRequest())
        workoutsCD.forEach { wcd in
            array.append(Workout(uuid: wcd.uuid, sport: wcd.sport, date: wcd.date, time: wcd.time, visits: wcd.visits, tag: wcd.tag))
        }
        return array
    }
    
    func fetchSubscription() throws -> Array<Subscription> {
        var array: Array<Subscription> = []
        let ssCD = try coreDataStack.managedContext.fetch(SubscriptionCD.fetchRequest())
        ssCD.forEach { scd in
            array.append(Subscription(uuid: scd.uuid, name: scd.name, startDate: scd.startDate, endDate: scd.endDate, visits: scd.visits, price: scd.price, type: scd.type))
        }
        return array
    }
    
    func editSubscription(_ subscription: Subscription) {
        do {
            let ssCD = try coreDataStack.managedContext.fetch(SubscriptionCD.fetchRequest())
            ssCD.forEach { scd in
                if scd.uuid == subscription.uuid {
                    scd.name = subscription.name
                    scd.startDate = subscription.startDate
                    scd.endDate = subscription.endDate
                    scd.visits = subscription.visits
                    scd.price = subscription.price
                    scd.type = subscription.type
                    coreDataStack.saveContext()
                    return
                }
            }
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}

class CoreDataStack {
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                return print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
