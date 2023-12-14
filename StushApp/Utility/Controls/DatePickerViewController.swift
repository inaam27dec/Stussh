//
//  DatePickerViewController.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/8/23.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Customize the date picker and layout as needed
    }

    @IBAction func doneButtonTapped(_ sender: Any) {
        // Handle the selected date when the "Done" button is tapped
        let selectedDate = datePicker.date
        
        // Format the selected date (optional)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" // You can use your desired date format
        let formattedDate = dateFormatter.string(from: selectedDate)
        
        // Now you can use 'formattedDate' or 'selectedDate' as needed
        print("Selected Date: \(formattedDate)")

        // Dismiss the date picker view controller
        dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        // Handle the cancel button action (optional)
        dismiss(animated: true, completion: nil)
    }
}

