

import UIKit

class sectionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var sectionTabelView: UITableView!
    
    
    var obj = Snacks()
    var objMaincourse = Maincourse()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        sectionTabelView.delegate = self
        sectionTabelView.dataSource = self
        initializeUI()
    }
    
    func initializeUI(){
        sectionTabelView.register(UINib(nibName: "customTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        obj.menuNames = ["WadaPav","Samosa","Dhokala","Poha","PaniPuri","Burger","Sandwich","PavBhaji","Dabeli","Momo"]
        obj.menuPrice = ["Rs.20","Rs.20","Rs.30","Rs.25","Rs.30","Rs.60","Rs.45","Rs.100","Rs.25","Rs.120"]
        obj.menuImage = ["wadapav","samosa","dhokla","pohe","panipuri","burger","sandwich","pavbhaji","dabeli","momo"]
        
        //Maincourse
        objMaincourse.menuNames = ["PuranPoli","Paneer Masala","Palak Paneer","Veg Kolhapuri","VaranBati","Biryani","MIx bhaji","Chole"]
        objMaincourse.menuPrice = ["Rs.300","Rs.250","Rs.200","Rs.270","Rs.180","Rs.220","Rs.170","Rs.210"]
        objMaincourse.menuImage = ["puran poli","paneer masala","Palak paneer","veg kolhapuri","varan bati","biryani","mix bhaji","chole"]
    }
    
    
    
    
    //MARK: TableViewDelegate datasourse methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Snacks Menu"
            }
        else{
            return "Maincourse Menu"
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return obj.menuNames.count
        }else{
            return objMaincourse.menuNames.count
            
        }
        
        
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! customTableViewCell
        if indexPath.section == 0{
        cell.nameLabel.text = obj.menuNames[indexPath.row]
        cell.pricelabel.text = obj.menuPrice[indexPath.row]
        cell.menuImage.image = UIImage(named:obj.menuImage[indexPath.row])
        }else{
                    cell.nameLabel.text = objMaincourse.menuNames[indexPath.row]
                    cell.pricelabel.text = objMaincourse.menuPrice[indexPath.row]
                    cell.menuImage.image = UIImage(named: objMaincourse.menuImage[indexPath.row])
        }

        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
