//
//  CrowdSavingViewController.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/5/23.
//

import UIKit

struct ProgramInfo {
    var programName : String = ""
    var perWeekAmount : String = ""
    var programTime : String = ""
    var receivedAmount: String = ""
}



var programList : [ProgramInfo] = [
    ProgramInfo(programName: "Basic Program", perWeekAmount: "25$", programTime: "10 Weeks", receivedAmount: "2500$"),
    ProgramInfo(programName: "Basic General Program", perWeekAmount: "15$", programTime: "10 Weeks", receivedAmount: "1500$"),
    ProgramInfo(programName: "Premium Program", perWeekAmount: "50$", programTime: "10 Weeks", receivedAmount: "5000$"),
    ProgramInfo(programName: "Economy Program", perWeekAmount: "10$", programTime: "10 Weeks", receivedAmount: "1000$"),
]


class CrowdSavingViewController: UIViewController {
    
    
    @IBOutlet weak var tblPrograms: UITableView!
    @IBOutlet weak var btnMyPrograms: UIButton!
    @IBOutlet weak var btnAllPrograms: UIButton!
    @IBOutlet weak var btnClearFilters: UIButton!
    @IBOutlet weak var btnFilterBy: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblSavingHub: UILabel!
    @IBOutlet weak var viewSavingsHub: UIView!
    private var isMyProgram : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews(){
        tblPrograms.delegate = self
        tblPrograms.dataSource = self
        tblPrograms.register(UINib(nibName: SavingProgramCell.className, bundle: nil), forCellReuseIdentifier: SavingProgramCell.className)
        viewSavingsHub.roundCorners(corners: [.topLeft, .topRight], radius: 25)
        let textToHighlight = "Savings Hub"
        var text = Constants.savingHubJoiningxt
        let attributedText = text.attributedStringWithColor([textToHighlight], color: Colors.APP_BLUE!)
        lblSavingHub.attributedText = attributedText
        //self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func actionButtonPressed(_ sender: UIButton) {
        switch (sender){
        case btnBack:
            navigationController?.popViewController(animated: true)
            break
        case btnFilterBy:
            break
        case btnClearFilters:
            break
        case btnAllPrograms:
            isMyProgram = false
            handleTabBarClick()
            break
        case btnMyPrograms:
            isMyProgram = true
            handleTabBarClick()
            break
        default:
            break
        }
    }
    
    func handleTabBarClick(){
        if isMyProgram {
            btnAllPrograms.borderWidth = 1.0
            btnAllPrograms.borderColor = Colors.APP_GRAY_COLOR
            btnAllPrograms.backgroundColor = .clear
            btnAllPrograms.setTitleColor(Colors.APP_GRAY_COLOR, for: .normal)
            
            
            btnMyPrograms.borderColor = .clear
            btnMyPrograms.borderWidth = 0.0
            btnMyPrograms.backgroundColor = Colors.APP_SECONDARY_COLOR
            btnMyPrograms.setTitleColor(.black, for: .normal)
            tblPrograms.reloadData()
            
        } else {
            btnMyPrograms.borderWidth = 1.0
            btnMyPrograms.borderColor = Colors.APP_GRAY_COLOR
            btnMyPrograms.backgroundColor = .clear
            btnMyPrograms.setTitleColor(Colors.APP_GRAY_COLOR, for: .normal)
            
            btnAllPrograms.borderColor = .clear
            btnAllPrograms.borderWidth = 0.0
            btnAllPrograms.backgroundColor = Colors.APP_SECONDARY_COLOR
            btnAllPrograms.setTitleColor(.black, for: .normal)
            tblPrograms.reloadData()
        }
    }
    
}

extension CrowdSavingViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isMyProgram ? 1 : programList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblPrograms.dequeueReusableCell(withIdentifier: SavingProgramCell.className) as? SavingProgramCell
        
        if let programCell = cell {
            
            if isMyProgram {
                programCell.btnJoin.setTitle("Details", for: .normal)
                programCell.setData(obj: programList[0])
            } else {
                programCell.btnJoin.setTitle("Join", for: .normal)
                programCell.setData(obj: programList[indexPath.row])
            }
            
            programCell.CallVConJoinButtonClick = { [self] in
                joinNowButtonPressed(index: indexPath.row)
            }
            
            return programCell
        }
        
        return UITableViewCell()
    }
    
    func joinNowButtonPressed(index: Int){
        if isMyProgram {
            Router.shared.gotoProgramDetailnController(inViewController: self)
        } else {
            Router.shared.showScanningBankConfirmationDialog(inViewController: self)
        }
    }
}
