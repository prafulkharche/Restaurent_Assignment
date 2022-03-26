

import UIKit

class ViewController: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    title = "Welcome to Praful Resto.."
}
    
    
    
    @IBAction func snacksButtonClicked(_ sender: Any) {
        let section = self.storyboard?.instantiateViewController(withIdentifier: "sectionViewController") as! sectionViewController
        navigationController?.pushViewController(section, animated: true)
    }
   
    @IBAction func mainCourseButtonClicked(_ sender: Any) {
        let mix = self.storyboard?.instantiateViewController(withIdentifier: "mixListViewController") as! mixListViewController
        navigationController?.pushViewController(mix, animated: true)
    }
    
}

