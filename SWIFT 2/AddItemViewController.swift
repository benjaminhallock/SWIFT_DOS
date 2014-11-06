//
//  AddItemViewController.swift
//  SWIFT 2
//
//  Created by benjaminhallock@gmail.com on 11/5/14.
//  Copyright (c) 2014 BEN. All rights reserved.
//

import UIKit


//This delegate is unnessary because of the unwind segue. But if you had a big app, you may want to use delegates instead.
protocol AddItemViewControllerDelegate: class {
    func addItemViewControllerDidCancel(controller: AddItemViewController)
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: Item)
}

class AddItemViewController: UITableViewController {

    //This is a textField.
    @IBOutlet weak var textField: UITextField!

    //We declare this to access the delegate, optional because it could not be set previously.
    weak var delegate: AddItemViewControllerDelegate?

    //We make a new item and send the delegate off when you tap done.
    @IBAction func didPressDone(sender: AnyObject) {
        let text = textField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        let item1 = Item(name: text, Checked: false)
        delegate?.addItemViewController(self, didFinishAddingItem: item1)
    }

    //We hit the cancel button and send the delegate off to whatever view controller is set.
    @IBAction func cancel(sender: AnyObject) {
        delegate?.addItemViewControllerDidCancel(self)
    }


    override func viewDidLoad() {
        textField .becomeFirstResponder()
    }


    
}
