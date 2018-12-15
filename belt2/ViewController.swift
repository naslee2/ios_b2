//
//  ViewController.swift
//  belt2
//
//  Created by Nathan on 3/27/18.
//  Copyright © 2018 Nathan Lee. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var items = [Entity1]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchItems()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].firstname! + " " + items[indexPath.row].lastname!
        cell.detailTextLabel?.text = items[indexPath.row].phone
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let viewAction = UIAlertAction(title: "View", style: .default) { (action:UIAlertAction) in
            self.performSegue(withIdentifier: "viewSegue", sender: indexPath);
        }
        let editAction = UIAlertAction(title: "Edit", style: .default) { (action:UIAlertAction) in
            self.performSegue(withIdentifier: "addSegue", sender: indexPath);
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action:UIAlertAction) in
            let item = self.items[indexPath.row]
            self.managedObjectContext.delete(item)
            do {
                try self.managedObjectContext.save()
            }
            catch {
                print("\(error)")
            }
            self.items.remove(at: indexPath.row)
            tableView.reloadData();
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
            print("Cancelled");
        }
        
        menu.addAction(viewAction)
        menu.addAction(editAction)
        menu.addAction(deleteAction)
        menu.addAction(cancelAction)
        present(menu, animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = sender as? NSIndexPath {
            if segue.identifier == "addSegue" {
                let navigationController = segue.destination as! UINavigationController
                let addcell = navigationController.topViewController as! ViewController2
                let item = items[indexPath.row]
                addcell.delegate = self
                addcell.firstname = item.firstname!
                addcell.lastname = item.lastname!
                addcell.number = item.phone
                addcell.editTitle = "Edit Contact"
                addcell.indexPath = indexPath
            }
            else {
                let navigationController = segue.destination as! UINavigationController
                let addcell = navigationController.topViewController as! ViewController3
                let item = items[indexPath.row]
                addcell.firstname = item.firstname!
                addcell.lastname = item.lastname!
                addcell.number = item.phone
                addcell.editTitle = item.firstname!
                addcell.indexPath = indexPath
            }
        }
        else if let _ = sender as? UIBarButtonItem {
            let navigationController = segue.destination as! UINavigationController
            let addcell = navigationController.topViewController as! ViewController2
            addcell.editTitle = "New Contact"
            addcell.delegate = self
        }
    }
    
    func newitemadd(by Controller: ViewController2, with newfirstname: String, newlastName: String, newnumber: String, at indexPath: NSIndexPath?) {
        if let ip = indexPath {
            let item = items[ip.row]
            item.firstname = newfirstname
            item.lastname = newlastName
            item.phone = newnumber
        }
        else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "Entity1", into: managedObjectContext) as! Entity1
            item.firstname = newfirstname
            item.lastname = newlastName
            item.phone = newnumber
            items.append(item)
        }
        do{
            try managedObjectContext.save()
        }
        catch {
            print("\(error)")
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func fetchItems () {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity1")
        do {
            items = try managedObjectContext.fetch(request) as! [Entity1]
        }
        catch {
            print("\(error)")
        }
    }
}

