//
//  RecordTableViewController.swift
//  Borrowed
//
//  Created by Mitali Chandna on 2015-11-15.
//  Copyright © 2015 Mitali Chandna. All rights reserved.
//

import UIKit

class RecordTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var records = [Record]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem()
        
        if let savedRecords = loadRecords() {
            records += savedRecords
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "RecordTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RecordTableViewCell
        
        let record = records[indexPath.row]
        
        if record.borrowed == true {
            cell.backgroundColor = UIColor.blackColor()
            cell.descriptionLabel.textColor = UIColor.whiteColor()
            cell.lastRemindedLabel.textColor = UIColor.whiteColor()
            cell.descriptionLabel.text = "Borrowed " + record.itemName + " from " + record.contactName
        }
        if record.lent == true {
            cell.backgroundColor = UIColor.whiteColor()
            cell.descriptionLabel.textColor = UIColor.blackColor()
            cell.lastRemindedLabel.textColor = UIColor.blackColor()
            cell.descriptionLabel.text = "Lent " + record.itemName + " to " + record.contactName
        }
        
        cell.lastRemindedLabel.text = record.reminderName
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            records.removeAtIndex(indexPath.row)
            saveRecords()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Top)
        }
        else if editingStyle == UITableViewCellEditingStyle.Insert {
            
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
//    func loadRecords() {
//        let record1 = Record(borrowed: true, lent: false, itemName: "item1", contactName: "person1", reminderName: "Once a week", reminderNumber: 3)
//        
//        records += [record1]
//    }
    
    @IBAction func unwindToRecordList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.sourceViewController as? RecordViewController, record = sourceViewController.newRecord {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                records[selectedIndexPath.row] = record
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: UITableViewRowAnimation.None)
            }
            else {
                let newIndexPath = NSIndexPath(forRow: records.count, inSection: 0)
                records.append(record)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            saveRecords()
        }
    }
    
    // MARK: Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let recordDetailViewController = segue.destinationViewController as! RecordViewController
            if let selectedCell = sender as? RecordTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedCell)!
                let selectedRecord = records[indexPath.row]
                recordDetailViewController.newRecord = selectedRecord
            }
        }
    }
    
    //MARK: NSCoding
    
    func saveRecords() {
        let isSuccessful = NSKeyedArchiver.archiveRootObject(records, toFile: Record.ArchiveURL.path!)
        if !isSuccessful {
            print("Failed save")
        }
    }
    
    func loadRecords() -> [Record]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Record.ArchiveURL.path!) as? [Record]
    }
}
