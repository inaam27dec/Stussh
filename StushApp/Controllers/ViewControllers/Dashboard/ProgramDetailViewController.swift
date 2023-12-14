//
//  ProgramDetailViewController.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/6/23.
//

import UIKit

class ProgramDetailViewController: UIViewController {

    @IBOutlet weak var btnJoinNow: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tblDetails: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    @IBAction func actionButtonPressed(_ sender: UIButton) {
        switch (sender){
        case btnJoinNow:
            break
        case btnBack:
            navigationController?.popViewController(animated: true)
            break
        default:
            break
        }
    }
    
    func setTableView(){
        tblDetails.delegate = self
        tblDetails.dataSource = self
        tblDetails.register(UINib(nibName: ProgramDetailCell.className, bundle: nil), forCellReuseIdentifier: ProgramDetailCell.className)
    }

}

extension ProgramDetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblDetails.dequeueReusableCell(withIdentifier: ProgramDetailCell.className) as? ProgramDetailCell
        
        if let programDetailCell = cell {
            
            return programDetailCell
        }
        
        return UITableViewCell()
    }
}
