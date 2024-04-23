

import UIKit

class Home: UIViewController {
    
    @IBOutlet var startbtn: UIButton!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        // changed boarder radius of the start button
        startbtn.layer.cornerRadius = 15
        startbtn.layer.masksToBounds = true
    }

}
