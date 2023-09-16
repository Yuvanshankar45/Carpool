//
//  CreateRideViewController.swift
//  iOS App
//
//  Created by Yuvan Shankar on 16/09/2023.
//

import UIKit

class SearchRideViewController: UIViewController {

    @IBOutlet weak var ibFromTextField: UITextField!
    @IBOutlet weak var ibToTextField: UITextField!
    @IBOutlet weak var ibDatePicker: UIDatePicker!
    @IBOutlet weak var ibUserNameLabel: UILabel!
    
    var selectedDateAndTime: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ibUserNameLabel.text = "Hi \(UserStorage.userName)!"
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func searchBtnTapped(_ sender: Any) {
        guard ibFromTextField.text != "" else {
            self.alterMessageWithTitle(message: "Please enter leaving from location", title: "Error")
            return
        }
        
        guard ibToTextField.text != "" else {
            self.alterMessageWithTitle(message: "Please enter going to location", title: "Error")
            return
        }
        
        
        guard selectedDateAndTime != nil else {
            self.alterMessageWithTitle(message: "Please select date and time", title: "Error")
            return
        }
        
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Customize the date format as needed
        let formattedDate = String(dateFormatter.string(from: selectedDate))
        self.selectedDateAndTime = formattedDate
        print(formattedDate)
    }
}
