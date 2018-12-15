//
//  ViewController3.swift
//  belt2
//
//  Created by Nathan on 3/27/18.
//  Copyright © 2018 Nathan Lee. All rights reserved.
//

import UIKit
import CoreData

class ViewController3: UIViewController {
    @IBOutlet weak var viewNumber: UILabel!
    @IBOutlet weak var viewName: UILabel!
    var firstname: String?
    var lastname: String?
    var number: String?
    var editTitle: String?
    var indexPath: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewName.text = firstname! + " " + lastname!
        viewNumber.text = number
        self.navigationItem.title = editTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    

}
