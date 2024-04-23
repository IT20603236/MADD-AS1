
import UIKit
import Foundation

class ViewController: UIViewController {

    //connected relevant outlets from the mainUI
    @IBOutlet var intakeSlider: UISlider!
    @IBOutlet var sliderLabel: UILabel!
    @IBOutlet var dailyLabel: UILabel!
    @IBOutlet var goal: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var progress: UIProgressView!
    
    //override the viewWillappear function to setup commants to execute when the page appears
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        DataModel.daily = fetchDaily()
        DataModel.goalval  = fetchGoal()
        dailyLabel.text = "\(DataModel.daily)ml"
        goal.text = "Daily Goal : \(DataModel.goalval)ml"
        sliderLabel.text = "\(Int(intakeSlider.value))ml"
        updateStatus()
        }
    
    // set viewDidLoad functions with commands which should be executed when the page loads
    override func viewDidLoad() {
        super.viewDidLoad()
        intakeSlider.value = 0
    }
    
    @IBAction func intakeVol(_ sender: UISlider) {
        sliderLabel.text = "\(Int(sender.value))ml"
    }
    
    @IBAction func addbtn(_ sender: Any) {
        // saving data and update status
        DataModel.daily += Int(intakeSlider.value)
        dailyLabel.text = "\(DataModel.daily)ml"
        updateStatus()
        savedata(intake : DataModel.daily)
    }
    
    @IBAction func reset(_ sender: Any) {
        // data reset alert
        let alert = UIAlertController(title: "Are you sure you want to reset these values?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Reset", style: .destructive, handler: { action in
                // Handle deletion here
                DataModel.daily = 0
                self.dailyLabel.text = "\(DataModel.daily)"
                self.updateStatus()
                savedata(intake : DataModel.daily)
            }))
            present(alert, animated: true, completion: nil)
        
    
    }
    // status function which analyze the intake and goal and fill the progress bar accordingly
    func updateStatus(){
        if DataModel.daily > DataModel.goalval{
            status.text = "Achived"
            status.textColor = UIColor.green
            progress.progress = 1
        }else{
            status.text = "Not Achived"
            status.textColor = UIColor.red
            progress.progress = Float(DataModel.daily) / Float(DataModel.goalval)
        }
    }
    
}

