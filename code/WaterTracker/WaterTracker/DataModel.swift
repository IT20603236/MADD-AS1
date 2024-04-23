
import UIKit
import CoreData

class DataModel{
    public static var daily : Int = 0
    public static var goalval : Int = 3000
}

let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


func savedata(intake : Int){
    let staticVariable = Intake(context: context)
    staticVariable.daily = Int64(intake)

    do {
        try context.save()
        print("Total Intake updated : \(intake)ml")
    } catch {
        // Handle the error
        print("Error Saving Data")
    }
    
}

func savedata(goal : Int){
    let staticVariable = WaterTracker.Goal(context: context)
    staticVariable.goalval = Int64(goal)

    do {
        try context.save()
        print("Goal Updated : \(goal)ml")
    } catch {
        // Handle the error
        print("Error Saving Data")
    }

}

func fetchDaily() -> Int{
    var retday : Int = 0
    
    let fetchRequest: NSFetchRequest<Intake> = Intake.fetchRequest()
    do {
      let result = try context.fetch(fetchRequest)
        if let variable = result.last{
            retday = Int(variable.daily)
      }
    } catch {
      // Handle the error
        print("Error Fetching Data")
    }
    return retday
}

func fetchGoal() -> Int{
    var retgoal : Int = 0
    
    let fetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
    do {
      let result = try context.fetch(fetchRequest)
        if let variable = result.last{
            retgoal = Int(variable.goalval)          }
    } catch {
      // Handle the error
        print("Error Fetching Data")
    }
    return retgoal
}
