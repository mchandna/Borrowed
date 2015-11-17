//
//  RecordViewController.swift
//  Borrowed
//
//  Created by Mitali Chandna on 2015-11-13.
//  Copyright © 2015 Mitali Chandna. All rights reserved.
//

//LOOK UP IN CONTACTS
//FIGURE OUT DELEGATE
//NOTIFICATIONS

import UIKit
import Contacts
import ContactsUI

class RecordViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    //MARK: Properties
    
    @IBOutlet weak var borrowedOrLentControl: UISegmentedControl!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var personLabel: UILabel!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var reminderLabel: UILabel!
    @IBOutlet weak var reminderPicker: UIPickerView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var borrowed = true
    var lent = false
    var item = ""
    //var contact: CNContact TO USE CONTACTS
    var contactValue = ""
    var reminder = "" //REMINDER OBJECT?
    var reminderNumber = 0
    
    var newRecord: Record?
    
    var reminderPickerDataSource = ["Twice a day", "Once a day", "Once in two days", "Once a week", "Once a month", "Never"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        itemTextField?.delegate = self
        contactTextField?.delegate = self
        reminderPicker.delegate = self
        reminderPicker.dataSource = self
        
        if let newRecord = newRecord {
            itemTextField.text = newRecord.itemName
            contactTextField.text = newRecord.contactName
            reminderPicker.selectRow(newRecord.reminderNumber, inComponent: 0, animated: false)
        }
        checkValidTextFields()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: borrowedOrLentControl Actions
    
    @IBAction func borrowedOrLent(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            itemTextField?.placeholder = "What did you borrow?"
            contactTextField.placeholder = "Who did you borrow from?"
            borrowed = true
            lent = false
        case 1:
            itemTextField?.placeholder = "What did you lend?"
            contactTextField.placeholder = "Who did you lend to?"
            borrowed = false
            lent = true
        default:
            break
        }
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        saveButton.enabled = false
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if textField == itemTextField {
            item = (itemTextField?.text)!
            return true
        }
        
        if textField == contactTextField {
            
            contactValue = (contactTextField.text)!
            return true
        }
        return false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidTextFields()
    }
    
    func checkValidTextFields() {
        // Disable the Save button if the text field is empty.
        let itemString = itemTextField.text ?? ""
        let contactString = contactTextField.text ?? ""
        saveButton.enabled = !itemString.isEmpty && !contactString.isEmpty
    }
    
    //MARK: UIPickerViewDelegate
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return reminderPickerDataSource.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return reminderPickerDataSource[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        reminder = reminderPickerDataSource[row]
    }
    
    //MARK: Navigation 
    
    @IBAction func Cancel(sender: UIBarButtonItem) {
        let isPresentingFromAdd = presentingViewController is UINavigationController
        if isPresentingFromAdd == true {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
                item = (itemTextField?.text)!
                contactValue = (contactTextField?.text)!
                reminder = reminderPickerDataSource[reminderPicker.selectedRowInComponent(0)]
                reminderNumber = reminderPicker.selectedRowInComponent(0)
                
            newRecord = Record(borrowed: borrowed, lent: lent, itemName: item, contactName: contactValue, reminderName: reminder, reminderNumber: reminderNumber)
            
            
            //ONLY GO TO TABLE ONCE OKAY IS PRESSED 
            
//            let savedNewRecordAlert = UIAlertController(title: "Record Saved", message: "", preferredStyle: UIAlertControllerStyle.Alert)
//            savedNewRecordAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//            
//            self.presentViewController(savedNewRecordAlert, animated: true, completion:nil)
        }
    }
}

