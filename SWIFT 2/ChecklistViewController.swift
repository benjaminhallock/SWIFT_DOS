//
//  ViewController.swift
//  SWIFT 2
//
//  Created by benjaminhallock@gmail.com on 11/5/14.
//  Copyright (c) 2014 BEN. All rights reserved.
//

import UIKit

//Constants for strings
let kStringConstant:String = "Bacon"
let segue1:String = "AddItem"

//This array holds the initial values of the table.
var arrayOfWords = ["bacon", "man", "bacony", "cheese", "america", "slices", "burger", "bun", "Misty", "Ash", "Brock", "Pokemon", "💙💙💙💙"]

var arrayOfItems : NSMutableArray = []

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {

    //These are the delgate methods that get called on button presses from Add Controller.
    func addItemViewControllerDidCancel(controller: AddItemViewController) {
        controller.dismissViewControllerAnimated(true, completion: { () -> Void in
            self.saveArrayToDisk()
        })
    }
    //This is also a delgate of the next View Controller. Alternative to exit "unwind method"
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: Item) {
        controller.dismissViewControllerAnimated(true, completion: { () -> Void in
            if item.text != "" {
//            let newRowIndex = arrayOfItems.count // If you want the end of the array
            arrayOfItems.insertObject(item, atIndex: 0)
             let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            let indexPaths = [indexPath]
            self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
            self.saveArrayToDisk()
            }
        })
    }

    //Start TableView delegate methods
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfItems.count
    }

    //We set the cell for each row, with optional uncessary method for fun.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kStringConstant, forIndexPath: indexPath) as UITableViewCell
        if let item = arrayOfItems[indexPath.row] as? Item {
            if item.isChecked {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
        cell.textLabel.text = item.text
        }
        return cell
    }

    //This is an example of how to do something different. It is not used anymore
    func giveMeTheObjectAtIndexForThisArray (arrayNew: NSArray, andNumber: NSInteger) -> NSObject {
        return arrayNew.objectAtIndex(andNumber) as NSObject
    }

    //Prepare for segue, identify destination, and set the delegate here first.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == segue1 {
         let navigationController = segue.destinationViewController as UINavigationController
        let controller = navigationController.topViewController as AddItemViewController
            controller.delegate = self
        }
    }

    //Tap the cell, and edit or checkmark off.
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if cell.accessoryType == .None {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                if let item = arrayOfItems[indexPath.row] as? Item {
                    item.isChecked = true
                }
            } else {
                cell.accessoryType = .None
                if let item = arrayOfItems[indexPath.row] as? Item {
                    item.isChecked = false
                }
            }
        }
         tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    //Delete each row with a nice animation.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        arrayOfItems.removeObjectAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        saveArrayToDisk()
    }

    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [String]
        return paths[0]
    }

    func saveArrayToDisk() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(arrayOfWords, forKey: "ChecklistItems")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }

    func dataFilePath() -> String {
       return documentsDirectory().stringByAppendingPathComponent("Checklists.plist")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem()

        for word : String in arrayOfWords {
           let item = Item(name: word, Checked: false)
            arrayOfItems.addObject(item)
        }

        tableView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //This is not used anymore, but it could be if you hooked up the bar buttons to exit.
    @IBAction func unwind (segue: UIStoryboardSegue) {
        println("unwind")
        arrayOfWords.append("bacon NEW")
        tableView.reloadData()
    }

}

