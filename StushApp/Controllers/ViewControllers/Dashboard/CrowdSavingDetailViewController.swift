//
//  CrowdSavingDetailViewController.swift
//  StushApp
//
//  Created by Moiz Farasat on 22/09/2023.
//

import UIKit

class CrowdSavingDetailViewController: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTopBar: UILabel!
    @IBOutlet weak var tblDetailView: UITableView!
    
    var dummyItems: [String] = [
        "Price", "Price", "Price","Price", "Price","Price","Price"
    ]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        // Do any additional setup after loading the view.
    }
    
    func setupViews(){
        tblDetailView.delegate = self
        tblDetailView.dataSource = self
        tblDetailView.register(UINib(nibName: CrowdSavingDetailCellTableViewCell.className, bundle: nil), forCellReuseIdentifier: CrowdSavingDetailCellTableViewCell.className)
        tblDetailView.register(UINib(nibName: StushSaversTableViewCell.className, bundle: nil), forCellReuseIdentifier: StushSaversTableViewCell.className)

    }

    
    @IBAction func btnActionBack(_ sender: Any) {
        self.popController()
    }
    
}

extension CrowdSavingDetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == dummyItems.count - 1 {
            
            
            if let stushUsersCell = tblDetailView.dequeueReusableCell(withIdentifier: StushSaversTableViewCell.className) as? StushSaversTableViewCell {
                
                addStushUsers(cell: stushUsersCell)
                return stushUsersCell
            }

        } else {
            let cell = tblDetailView.dequeueReusableCell(withIdentifier: CrowdSavingDetailCellTableViewCell.className) as? CrowdSavingDetailCellTableViewCell
            if let programCell = cell {
                
                programCell.lblKey.text = dummyItems[indexPath.row]
                
                
                return programCell
            }
        }
        
        return UITableViewCell()
    }
    
    func addStushUsers(cell : StushSaversTableViewCell){
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.textAlignment = .center
        label.font = UIFont(name: "SF-Pro-Text-Black", size: 15)
        label.text = "A"
        label.backgroundColor = Colors.USERS_BLUE_COLOR
        label.borderColor = .white
        label.borderWidth = 2
        label.textColor = .white
        label.layer.cornerRadius = 25
        label.layer.masksToBounds = true
        cell.svNameInitals.addArrangedSubview(label)
    }
    
    func joinNowButtonPressed(index: Int){
        //Router.shared.showScanningBankConfirmationDialog(inViewController: self)
        Router.shared.gotoProgramConfirmationController(inViewController: self)

    }
}

