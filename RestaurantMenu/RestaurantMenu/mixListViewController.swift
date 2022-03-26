
import UIKit

class mixListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,Datapass {
    func passingData(name: String) {
        print("Name = \(name)")
        objMaincourse.menuPrice[index] = name
        
    }
    
    @IBOutlet weak var mixListTabelview: UITableView!
    
    var objSnaks = Snacks()
    var objMaincourse = Maincourse()
    var mixArray: [String] = []
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        mixListTabelview.delegate = self
        mixListTabelview.dataSource = self
        
        initializeUI()
        mixArray = objSnaks.menuNames + objMaincourse.menuNames
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mixListTabelview.reloadData()
    }
    
    func initializeUI(){
        mixListTabelview.register(UINib(nibName: "customTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        objSnaks.menuNames = ["WadaPav","Samosa","Dhokala","Poha","PaniPuri","Burger","Sandwich","PavBhaji","Dabeli","Momo"]
        objSnaks.menuPrice = ["Rs.20","Rs.20","Rs.30","Rs.25","Rs.30","Rs.60","Rs.45","Rs.100","Rs.25","Rs.120"]
        objSnaks.menuImage = ["wadapav","samosa","dhokla","pohe","panipuri","burger","sandwich","pavbhaji","dabeli","momo"]
        
        //Maincourse
        objMaincourse.menuNames = ["PuranPoli","Paneer Masala","Palak Paneer","Veg Kolhapuri","VaranBati","Biryani","MIx bhaji","Chole"]
        objMaincourse.menuPrice = ["Rs.300","Rs.250","Rs.200","Rs.270","Rs.180","Rs.220","Rs.170","Rs.210"]
        objMaincourse.menuImage = ["puran poli","paneer masala","Palak paneer","veg kolhapuri","varan bati","biryani","mix bhaji","chole"]
    }
    
    //TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8 //mixArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! customTableViewCell
        if (indexPath.row % 2) == 0{
            
                
            print("Even = \(indexPath.row)")
            cell.nameLabel.text = objMaincourse.menuNames[indexPath.row]
            cell.pricelabel.text = objMaincourse.menuPrice[indexPath.row]
                cell.menuImage.image = UIImage(named: objMaincourse.menuImage[indexPath.row])}
            
          else{
            print("Odd = \(indexPath.row)")
            cell.nameLabel.text = objSnaks.menuNames[indexPath.row]
            cell.pricelabel.text = objSnaks.menuPrice[indexPath.row]
            cell.menuImage.image = UIImage(named: objSnaks.menuImage[indexPath.row])
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        if (indexPath.row % 2) == 0{
            let pck = self.storyboard?.instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController
            pck.objName = objMaincourse.menuNames[indexPath.row]
            pck.objImage = objMaincourse.menuImage[indexPath.row]
            pck.objPrice = objMaincourse.menuPrice[indexPath.row]
            pck.delegate = self
            navigationController?.pushViewController(pck, animated: true)
        }
        else{
            
            let alert = UIAlertController(title:
                "Snaks", message: "Does Not Supported", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            
        }
    
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
 
}

