import XCTest
import CoreData
@testable import WaterTracker

class WaterTrackerTests: XCTestCase {

    var coreDataStack: NSPersistentContainer!
    var managedObjectContext: NSManagedObjectContext!

    override func setUpWithError() throws {
        try super.setUpWithError()

        coreDataStack = TestCoreDataStack().persistentContainer
        managedObjectContext = coreDataStack.viewContext
    }

    override func tearDownWithError() throws {
        managedObjectContext = nil
        coreDataStack = nil

        try super.tearDownWithError()
    }

    // Test saving data to Core Data
    func testSaveIntakeData() throws {
        // Create a new Intake entity
        let intake = Intake(context: managedObjectContext)
        intake.daily = 1000

        // Save the data
        try managedObjectContext.save()

        // Fetch the saved data from Core Data
        let fetchRequest: NSFetchRequest<Intake> = Intake.fetchRequest()
        let intakes = try managedObjectContext.fetch(fetchRequest)

        // Assert that the fetched data matches the saved data
        XCTAssertEqual(intakes.count, 1)
        XCTAssertEqual(intakes.first?.daily, 1000)
    }

    // Test fetching data from Core Data
    func testFetchGoalData() throws {
        // Create a new Goal entity
        let goal = Goal(context: managedObjectContext)
        goal.goalval = 3000

        // Save the data
        try managedObjectContext.save()

        // Fetch the goal data
        let fetchedGoal = try fetchGoal()

        // Assert that the fetched goal matches the saved goal
        XCTAssertEqual(fetchedGoal, 3000)
    }

    // Test updating data in Core Data
    func testUpdateGoalData() throws {
        // Create a new Goal entity
        let goal = Goal(context: managedObjectContext)
        goal.goalval = 3000

        // Save the data
        try managedObjectContext.save()

        // Update the goal value
        goal.goalval = 3500

        // Save the updated data
        try managedObjectContext.save()

        // Fetch the updated goal data
        let fetchedGoal = try fetchGoal()

        // Assert that the fetched goal matches the updated value
        XCTAssertEqual(fetchedGoal, 3500)
    }

    // Helper function to fetch goal data
    private func fetchGoal() throws -> Int64? {
        let fetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
        let goals = try managedObjectContext.fetch(fetchRequest)
        return goals.first?.goalval
    }

    // Mock Core Data stack for testing
    private class TestCoreDataStack {
        let persistentContainer: NSPersistentContainer

        init() {
            persistentContainer = NSPersistentContainer(name: "WaterTracker")
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType // Use in-memory store for testing
            persistentContainer.persistentStoreDescriptions = [description]

            persistentContainer.loadPersistentStores { (_, error) in
                if let error = error as NSError? {
                    fatalError("Failed to load test store: \(error), \(error.userInfo)")
                }
            }
        }
    }
}

