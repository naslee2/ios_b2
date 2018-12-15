//
//  ViewController2.swift
//  belt2
//
//  Created by Nathan on 3/27/18.
//  Copyright © 2018 Nathan Lee. All rights reserved.
//

import UIKit


class ViewController2: UIViewController {
    weak var delegate: ViewControllerDelegate?
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var number1: UITextField!
    var firstname: String?
    var lastname: String?
    var number: String?
    var indexPath: NSIndexPath?
    var editTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstName.text = firstname
        lastName.text = lastname
        number1.text = number
        self.navigationItem.title = editTitle
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveContact(_ sender: UIBarButtonItem) {
        let newfirstName = firstName.text!
        let newlastName = lastName.text!
        let newnumber = number1.text!
        delegate?.newitemadd(by: self, with: newfirstName, newlastName: newlastName, newnumber: newnumber, at: indexPath)
    }
}

protocol ViewControllerDelegate: class {
    func newitemadd(by Controller: ViewController2, with newfirstname: String, newlastName: String, newnumber: String, at indexPath: NSIndexPath?)
}
