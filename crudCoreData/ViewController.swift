//
//  ViewController.swift
//  crudCoreData
//
//  Created by Mohan K on 18/03/23.
//

import UIKit
class usertableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contenttext: UILabel!
    @IBOutlet weak var bgView: UIView!
    
}
class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
 
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items:[User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableSetup()
        fetchUser()
    }

    func tableSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func fetchUser() {
        do {
            self.items = try context.fetch(User.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch{
            
        }
    }
    
    @IBAction func createBtn(_ sender: Any) {
      
        let alert = UIAlertController(title: "Add Text", message: "Enter text", preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        
        let submitButton = UIAlertAction(title: "Add", style: .default) {(action) in
            let titletextField = alert.textFields![0]
            let notetextField = alert.textFields![1]
            
            let newPerson = User(context: self.context)
            newPerson.text = notetextField.text
            newPerson.text = titletextField.text
            
            do {
                try self.context.save()
                
                
            }
            catch{
                
            }
            self.fetchUser()
        }
        alert.addAction(submitButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usertableViewCell", for : indexPath) as! usertableViewCell
//        let person = self.items![indexPath.row]
        
        cell.titleLabel.text = self.items![indexPath.row].title
        cell.contenttext.text = self.items![indexPath.row].text
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let person = self.items![indexPath.row]
        let alert = UIAlertController(title: "Edit", message: "edit text: ", preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        
        let titleTextField = alert.textFields![0]
        let contentTextField = alert.textFields![1]
        
        titleTextField.text = person.title
        contentTextField.text = person.text
        
        let saveButton = UIAlertAction(title: "Save", style: .default) {
            (action) in
            let titleTextField = alert.textFields![0]
            let contentTextField = alert.textFields![1]
            person.title = titleTextField.text
            person.text = contentTextField.text
            
            do {
                try self.context.save()
            }
            catch{
                
            }
            self.fetchUser()
        }
        
        alert.addAction(saveButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") {(action, view, completionHandler) in
            
            let personToRemove = self.items![indexPath.row]
            self.context.delete(personToRemove)
            do {
                try self.context.save()
            }
            catch{
                
            }
            self.fetchUser()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
