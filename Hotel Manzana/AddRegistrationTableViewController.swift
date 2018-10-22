 //
//  AddRegistrationTableViewController.swift
//  Hotel Manzana
//
//  Created by Александр Макаров on 18.10.2018.
//  Copyright © 2018 Александр Макаров. All rights reserved.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet weak var numberAdults: UILabel!
    @IBOutlet weak var stepperAdults: UIStepper!
    @IBOutlet weak var numberChildren: UILabel!
    @IBOutlet weak var stepperChildren: UIStepper!
    
    @IBOutlet weak var wifiLabel: UILabel!
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    @IBOutlet weak var roomTypeLabel: UILabel!
    
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    let roomTypeSelect = IndexPath(row: 0, section: 4)
    
    var isCheckInDatePickerShown: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    
    var isCheckOutDatePickerShown: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
        updateDateViews()
    }
    
    func updateDateViews() {
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(60 * 60 * 24)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath:
            if isCheckInDatePickerShown {
                print(#function, checkInDatePicker.frame.height)
                return 216
            } else {
                return 0
            }
        case checkOutDatePickerCellIndexPath:
            if isCheckOutDatePickerShown {
                print(#function, checkOutDatePicker.frame.height)
                return 216
            } else {
                return 0
            }
        default:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {
        case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row - 1):
            if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
            } else if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
                isCheckInDatePickerShown = true
            } else {
                isCheckInDatePickerShown = true
            }
        case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row - 1):
            if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
            } else if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
                isCheckOutDatePickerShown = true
            } else {
                isCheckOutDatePickerShown = true
            }
        default:
            isCheckInDatePickerShown = false
            isCheckOutDatePickerShown = false
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "popVC":
            let DVC = segue.destination as! RoomTableViewController
            DVC.modalPresentationStyle = .popover
            
            let popDVC = DVC.popoverPresentationController
            popDVC?.delegate = self
            popDVC?.sourceView = self.roomTypeLabel
            popDVC?.sourceRect = CGRect(x: roomTypeLabel.bounds.midX, y: roomTypeLabel.bounds.minY, width: 0, height: 0)
        default:
            break
        }
    }
    
    @IBAction func unwindToAddRegistrationViewController(_ unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.source as? RoomTableViewController {
            roomTypeLabel.text = sourceViewController.selectedRoom?.name
        }
    }
    
    @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberAdults = self.numberAdults.text ?? ""
        let numberChildren = self.numberChildren.text ?? ""
        let wifi = wifiSwitch.isOn ? "\(wifiLabel.text!)" : " не выбрано"
        let roomType = roomTypeLabel.text ?? ""
        
        print(#function)
        print("First Name: \(firstName)")
        print("Last Name: \(lastName)")
        print("E-mail: \(email)")
        print("Check In: \(checkInDate)")
        print("Check Out: \(checkOutDate)")
        print("Adults: \(numberAdults)")
        print("Children: \(numberChildren)")
        print("WiFi: \(wifi)")
        print("Room Type: \(roomType)")
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    @IBAction func stepperAdults(_ sender: UIStepper) {
        numberAdults.text = String(Int(stepperAdults.value))
    }
    
    @IBAction func stepperChildren(_ sender: UIStepper) {
        numberChildren.text = String(Int(stepperChildren.value))
    }
}

extension AddRegistrationTableViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
