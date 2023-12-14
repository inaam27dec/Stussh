//
//  SavingHubViewController.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/26/23.
//

import UIKit

class SavingHubViewController: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnClearFilters: UIButton!
    @IBOutlet weak var btnFilters: UIButton!
    @IBOutlet weak var tblSavingHub: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        // Do any additional setup after loading the view.
    }
    
    private func setTableView(){
        tblSavingHub.delegate = self
        tblSavingHub.dataSource = self
        tblSavingHub.register(UINib(nibName: SavingHubCell.className, bundle: nil), forCellReuseIdentifier: SavingHubCell.className)
    }
    
    @IBAction func actionButtonPress(_ sender: UIButton) {
        switch (sender) {
        case btnBack :
            navigationController?.popViewController(animated: true)
            break
        case btnFilters:
            break
        case btnClearFilters:
            break
        default:
            break
        }
    }

}

extension SavingHubViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblSavingHub.dequeueReusableCell(withIdentifier: SavingHubCell.className) as? SavingHubCell
        
        if let programCell = cell {
            
            return programCell
        }
        
        return UITableViewCell()
    }
}
