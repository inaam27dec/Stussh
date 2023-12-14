//
//  DashboardViewController.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/4/23.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var cvDashboard: UICollectionView!
    @IBOutlet weak var btnSideMenu: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cvDashboard.delegate = self
        self.cvDashboard.dataSource = self
        registerCells()
    }
    
    
    @IBAction func actionButtonPress(_ sender: UIButton) {
        switch (sender) {
        case btnSideMenu:
            actionMenuDrawer()
            break
        default:
            break
        }
    }
    
    
    func actionMenuDrawer() {
        if let window = AppDelegate.appDelegate().window, let navController = window.rootViewController as? UINavigationController {
            if let drawerMenu = navController.viewControllers.first as? DrawerController {
                drawerMenu.showLeftView()
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func registerCells (){
        self.cvDashboard.register(UINib(nibName: DashboardCell.className, bundle: nil), forCellWithReuseIdentifier: DashboardCell.className)
    }
    
    
}


extension DashboardViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dashboardItemsArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DashboardCell.className, for: indexPath) as! DashboardCell
        
        cell.setData(programName: dashboardItemsArray[indexPath.row].dashboardType.rawValue)
        if dashboardItemsArray[indexPath.row].isActive == true
        {
            cell.vBackground.backgroundColor = Colors.CELL_ENABLED_COLOR
            cell.btnComingSoon.isHidden = true
        } else{
            cell.vBackground.backgroundColor = Colors.CELL_DISABLED_COLOR
            cell.btnComingSoon.isHidden = false
        }
        
        
        cell.CallVConButtonClick = { [self] in
            if dashboardItemsArray[indexPath.row].isActive == true
            {
                buttonClicks(type: dashboardItemsArray[indexPath.row].dashboardType)
            } else {
                AlertPopupService.sharedInstance.showComingSoonDialog(self)
            }
        }
        return cell
    }
    
    func buttonClicks(type: DashboardType){
        switch (type) {
        case .CrowdSaving :
            if(UserDefaultsHandler.sharedInstance.getMyUserObj()?.isProfileCompleted ?? false){
                moveToCrowdSavingScreen()
            } else {
                openCompleteProfileDialog()
            }
            
            break
        case .SavingHub:
            Router.shared.gotoSavingHubScreen(inViewController: self)
            break
        case .Profile:
            Router.shared.gotoProfileScreen(inViewController: self)
            break
        case .Wallet:
            Router.shared.gotoSTUSHCardScreen(inViewController: self)
            break
        case .CreditBuilding :
            break
        case .TransformDeposits:
            break
        case .CashEarning:
            break
        case .DirectDeposit:
            break
        default:
            break
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.frame.width/2) - 25
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func openCompleteProfileDialog(){
        AlertPopupService.sharedInstance.showAlert(inVC: self,alertDescription: Constants.completeProfileInfoTxt, buttonTitle: Constants.buttonCompleteProfileTxt, completionButtonClick: {
            Router.shared.gotoProfileScreen(inViewController: self)
        })
    }
    
    func moveToCrowdSavingScreen(){
        let crowdSavingVC = Storyboards.MAIN.instantiateViewController(withIdentifier: CrowdSavingViewController.className) as! CrowdSavingViewController
        self.navigationController?.pushViewController(crowdSavingVC, animated: true)
    }
}

