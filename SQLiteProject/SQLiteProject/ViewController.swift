import UIKit
import SQLite3

struct Student {
    var id: Int
    var name: String
    var phoneNumber: String
    var age: Int
}

class ViewController: UIViewController {
    @IBOutlet var idTextfield: UITextField!
    @IBOutlet var nameTextField: UITextField!
    
    @IBOutlet var phoneNumberTextfield: UITextField!
    
    @IBOutlet var ageTextfield: UITextField!
    
    
    
    var students = [Student]()  //array
    let databaseName = "bitCode.sqlite"
    var dbDetailsObject: OpaquePointer?

    override func viewDidLoad() {
        super.viewDidLoad()
        openCreateDatabase()
        createStudentTableInDB()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let id = Int(idTextfield.text ?? "") ?? 0
        let age = Int(ageTextfield.text ?? "") ?? 0
        let obj = Student(id: id, name: nameTextField.text ?? "", phoneNumber: phoneNumberTextfield.text ?? "", age: age)

        insertDataInTable(student: obj)
        students.append(obj)
        let alert = UIAlertController(title: "Alert", message: "Successfully Saved", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        idTextfield.text = "" //clear textfield after save data
        ageTextfield.text = ""
        nameTextField.text = ""
        phoneNumberTextfield.text = ""
        
    }
    
    
    
    private func openCreateDatabase() {
        guard let dbPath = getPathForDocumentsDirectory() else {
            print("Documents directory path is missing")
            return
        }
        //S2
        var dbDetails: OpaquePointer?
        if sqlite3_open(dbPath,
                        &dbDetails) == SQLITE_OK {
            print("DB is successfully created or already present and we are able to access/open it: \n\(dbPath)")
            self.dbDetailsObject = dbDetails
        } else {
            print("Unable to create or Open DB")
        }
    }
    
    // S1
    private func getPathForDocumentsDirectory() -> String? {
        do {
            let documentDirectoryURL = try FileManager.default.url(for: .documentDirectory,
                                                                   in: .userDomainMask,
                                                                   appropriateFor: nil,
                                                                   create: false)
            let dbPath = documentDirectoryURL.appendingPathComponent(self.databaseName)
            return dbPath.absoluteString
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    //S3
    private func createStudentTableInDB() {
        var opaquePointerObject_CreateTable: OpaquePointer?

        //Write Query
        //let tableName = "Students"
        let createTableQuery = "CREATE TABLE Students(Id INTEGER PRIMARY KEY, Name TEXT, PhoneNumber TEXT, Age INTEGER);"
        
        // Preapre Query
        if sqlite3_prepare_v2(self.dbDetailsObject,
                           createTableQuery,
                           -1,
                           &opaquePointerObject_CreateTable,
                              nil) == SQLITE_OK {
            print("Query Prepared Create table Successfully")
            
            // Execute Query
            if sqlite3_step(opaquePointerObject_CreateTable) == SQLITE_DONE {
                print("Table Student created successfully")
            } else {
                print("Table Student Not created")
            }
            
        } else {
            print("Query Not Prepared. Some issue in Create table Query")
        }
    }
    
    // Create Query
    private func insertDataInTable(student: Student) {
        var insertStatement: OpaquePointer?
        let insertStatementString = "INSERT INTO Students(Id,Name,PhoneNumber,Age) VALUES (?,?,?,?);"
   
         // 1
         if sqlite3_prepare_v2(self.dbDetailsObject,
                               insertStatementString,
                               -1,
                               &insertStatement,
                               nil) == SQLITE_OK {
            let Id: Int32 = Int32(student.id)
            let Name: NSString = student.name as NSString
            let PhoneNumber: NSString = student.phoneNumber as NSString
            let Age: Int32 = Int32(student.age)
           // 2
           sqlite3_bind_int(insertStatement, 1,Id)
           // 3
           
            sqlite3_bind_text(insertStatement, 2, Name.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, PhoneNumber.utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 4,Age)
           // 4
           if sqlite3_step(insertStatement) == SQLITE_DONE {
             print("\nSuccessfully inserted row.")
           } else {
             print("\nCould not insert row.")
           }
         } else {
           print("\nINSERT statement is not prepared.")
         }
         // 5
         sqlite3_finalize(insertStatement)
       }
    
    // Read Query
    private func fetchStudentsFromDB() -> [Student] {
        return [Student]()
    }
}

