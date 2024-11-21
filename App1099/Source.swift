import Foundation

final class Source: ObservableObject {
    
    let store = Store()
    var loaded = false
    
    var subscriptionForEdit: Subscription?
    var workoutForEdit: Workout?
    var progressForEdit: Progress?
    var financeForEdit: Finance?
    
    @Published var subscriptions: Array<Subscription> = []
    @Published var workouts: Array<Workout> = []
    @Published var progresses: Array<Progress> = []
    @Published var finances: Array<Finance> = []
    
    func load() {
        if let subscriptionsCD = try? store.fetchSubscription() {
            subscriptions = subscriptionsCD
        }
        if let workoutsCD = try? store.fetchWorkouts() {
            workouts = workoutsCD
        }
        if let progressesCD = try? store.fetchProgresses() {
            progresses = progressesCD
        }
        if let financesCD = try? store.fetchFinances() {
            finances = financesCD
        }
        loaded = true
    }
    
    func saveProgress(name: String, description: String, unit: String, totalQuantity: String) {
        guard let totalQuantity = Int(totalQuantity) else { return }
        let progress = Progress(uuid: UUID(), name: name, description: description, unit: unit, totalQuantity: totalQuantity, quantity: 0)
        progresses.append(progress)
        store.saveProgress(progress)
    }
    
    func increment(by index: Int) {
        progresses[index].quantity += 1
        store.editProgress(progresses[index])
    }
    
    func decrement(by index: Int) {
        progresses[index].quantity -= 1
        store.editProgress(progresses[index])
    }
    
    func saveFinance(name: String, price: String, benefit: String, promotion: String) {
        let finance = Finance(uuid: UUID(), name: name, price: price, benefit: benefit, promotion: promotion)
        finances.append(finance)
        store.saveFinance(finance)
    }
    
    func editFinance(name: String, price: String, benefit: String, promotion: String) {
        guard let financeForEdit = financeForEdit,
              let index = finances.firstIndex(where: {$0.uuid == financeForEdit.uuid}) else { return }
        let finance = Finance(uuid: financeForEdit.uuid, name: name, price: price, benefit: benefit, promotion: promotion)
        finances[index] = finance
        store.editFinance(finance)
    }
    
    func editProgress(name: String, description: String, unit: String, totalQuantity: String) {
        guard let totalQuantity = Int(totalQuantity),
            let progressForEdit = progressForEdit,
              let index = progresses.firstIndex(where: {$0.uuid == progressForEdit.uuid}) else { return }
        let progress = Progress(uuid: progressForEdit.uuid, name: name, description: description, unit: unit, totalQuantity: totalQuantity, quantity: progressForEdit.quantity)
        progresses[index] = progress
        store.editProgress(progress)
    }
    
    func saveWorkout(sport: String, date: String, time: String, visits: String, tag: String) {
        let workout = Workout(uuid: UUID(), sport: sport, date: date, time: time, visits: visits, tag: tag)
        workouts.append(workout)
        store.saveWorkout(workout)
    }
    
    func editWorkout(sport: String, date: String, time: String, visits: String, tag: String) {
        guard let workoutForEdit = workoutForEdit,
              let index = workouts.firstIndex(where: {$0.uuid == workoutForEdit.uuid}) else { return }
        let workout = Workout(uuid: workoutForEdit.uuid, sport: sport, date: date, time: time, visits: visits, tag: tag)
        workouts[index] = workout
        store.editWorkout(workout)
    }
    
    func saveSubscription(name: String, startDate: String, endDate: String, visits: String, price: String, type: String) {
        let subscription = Subscription(uuid: UUID(), name: name, startDate: startDate, endDate: endDate, visits: visits, price: price, type: type)
        subscriptions.append(subscription)
        store.saveSubscription(subscription)
    }
    
    func editSubscription(name: String, startDate: String, endDate: String, visits: String, price: String, type: String) {
        guard let subscriptionForEdit = subscriptionForEdit,
              let index = subscriptions.firstIndex(where: {$0.uuid == subscriptionForEdit.uuid}) else { return }
        let subscription = Subscription(uuid: subscriptionForEdit.uuid, name: name, startDate: startDate, endDate: endDate, visits: visits, price: price, type: type)
        subscriptions[index] = subscription
        store.editSubscription(subscription)
    }
}
