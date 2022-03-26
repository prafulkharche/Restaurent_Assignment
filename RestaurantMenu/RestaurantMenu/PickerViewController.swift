
import UIKit
protocol Datapass:AnyObject{
    func passingData(name:String)
}
class PickerViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priceArr.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priceArr[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        priceLabel.text = priceArr[row]
    }
    
    weak var delegate:Datapass?
   
    @IBOutlet weak var pricePickerview: UIPickerView!
    @IBOutlet weak var menuNameLabel: UILabel!
    
    @IBOutlet weak var menuImage: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    var objName : String?
    var objImage : String?
    var objPrice : String?
    var priceArr = ["10","50","80","200","250","350","400"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuNameLabel.text = objName
        menuImage.image = UIImage(named: objImage ?? "")
        priceLabel.text = objPrice
        
        pricePickerview.delegate = self
        pricePickerview.dataSource = self

       
    }
   
    @IBAction func saveButtonTapped(_ sender: Any) {
        let datatopass = priceLabel.text ?? ""
        delegate?.passingData(name: datatopass)
        self.navigationController?.popViewController(animated: true)
    }
    
  
}
