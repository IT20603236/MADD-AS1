
import UIKit

class More: UIViewController {
    
    // connected UI elements
    @IBOutlet var Goal: UILabel!
    @IBOutlet var goalSlider: UISlider!
    @IBOutlet var goalVal: UILabel!
    @IBOutlet var updatebtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "More"
        Goal.text = "\(DataModel.goalval)"
        goalVal.text = "\(DataModel.goalval)"
        goalSlider.value = Float(DataModel.goalval)
        updatebtn.layer.cornerRadius = 10 // Set the corner radius to 8 pixels
        updatebtn.layer.masksToBounds = true // Make sure the corner radius is applied and visible
        
    }

    @IBAction func goalSlide(_ sender: UISlider) {
        goalVal.text = "\(Int(sender.value))ml"
    }
    @IBAction func AddGoal(_ sender: Any) {
        DataModel.goalval = Int(goalSlider.value)
        Goal.text = "\(DataModel.goalval)"
        savedata(goal : DataModel.goalval)
    }

}
