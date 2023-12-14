//
//  SideMenuViewController.swift
//  zaamConsumerApp
//
//  Created by Monisa Hassan on 3/16/22.
//

import Foundation
import UIKit
import RxSwift
import LGSideMenuController
//import SDWebImageSVGKitPlugin

class SideMenuViewController: UIViewController{
    
    weak var parentVC:DrawerController?
    @IBOutlet weak var tableViewMenu: UITableView!
    private var userObj : LoginInfo?
    
    var defaultMenuItems: [DrawerItemModel] = [
        DrawerItemModel(title: "Profile", image: UIImage(named: "ic_menu_profile")!, type: .Profile),
        DrawerItemModel(title: "Saving Hub", image: UIImage(named: "ic_menu_saving_hub")!, type: .SavingHub),
        DrawerItemModel(title: "Stush Debit Card", image: UIImage(named: "ic_menu_creditcard")!, type: .StushDebitCard),
        DrawerItemModel(title: "Transaction History", image: UIImage(named: "ic_menu_transaction_history")!, type: .TransactionHistory),
        DrawerItemModel(title: "Change Password", image: UIImage(named: "ic_menu_change_password")!, type: .ChangePassword),
        DrawerItemModel(title: "Delete Account", image: UIImage(named: "ic_menu_delete_account")!, type: .DeleteAccount),
        DrawerItemModel(title: "Contact Us", image: UIImage(named: "ic_menu_contact_us")!, type: .ContactUs),
        DrawerItemModel(title: "Logout", image: UIImage(named: "ic_menu_logout")!, type: .Logout),
    ]
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserData()
        parentVC = self.navigationController?.parent as? DrawerController
        self.tableViewMenu.dataSource = self
        self.tableViewMenu.delegate = self
    }
    
    private func setUserData (){
       userObj = UserDefaultsHandler.sharedInstance.getMyUserObj()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.view.layoutIfNeeded()
        tableViewMenu.reloadData()
    }

    
    override func dismissController() {
        parentVC?.hideLeftView()
    }
    
    private func pushController(viewController: UIViewController) {
        dismissController()
        if let root = parentVC?.rootViewController as? DashboardViewController {
            root.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    private func getSeparatorView(forTableView tableView: UITableView) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20))
        
        let separatorView = UIView(frame: CGRect(x: 22, y: 10, width: tableView.frame.size.width-44 , height: 1))
        separatorView.backgroundColor = UIColor.init(hex: "#E8E8E8")
        
        view.addSubview(separatorView)
        return view
    }
    
    private func showDashboardController() {
        let navController = Storyboards.MAIN.instantiateInitialViewController() as? DashboardViewController
        parentVC?.rootViewController = navController
        dismissController()
    }
    
    
    func logoutUser() {
        AlertPopupService.sharedInstance.showAlert(inVC: parentVC!, alertDescription: Constants.alertLogoutConfirmation, buttonTitle: Constants.kYes, completionButtonClick: {
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
            ModeSelection.instance.signupMode()
        }, isTwoButton: true, buttonCancelTitle: Constants.kNo)
    }
    
    func deleteUser() {
        AlertPopupService.sharedInstance.showAlert(inVC: parentVC!, alertDescription: Constants.alertDeleteUserConfirmation, buttonTitle: Constants.kYes, completionButtonClick: {
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
            ModeSelection.instance.signupMode()
        }, isTwoButton: true, buttonCancelTitle: Constants.kNo)
    }
}


extension SideMenuViewController : UITableViewDelegate, UITableViewDataSource{

    // MARK: - UITableViewDelegate / UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        if indexPath.section == 1 {
            return 50.0
        } else {
            return 134.0

        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return defaultMenuItems.count
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {

        if section == 0 {
            return 50
        }
        
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        _ = DispatchSemaphore(value: 1)

        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DrawerProfileCell") {
                if let titleLabel = cell.viewWithTag(20) as? UILabel {
                    let fullname = (userObj?.firstName ?? "") + " " + (userObj?.lastName ?? "")
                    titleLabel.text = fullname
                    titleLabel.textColor = .white
                }

                if let imageView = cell.viewWithTag(10) as? UIImageView {
                    imageView.image = self.userObj!.profileImage.convertBase64ToImage()
                }
                return cell
            }

        } else {
            if let menuCell = tableViewMenu.dequeueReusableCell(withIdentifier: SideMenuCell.className) as? SideMenuCell {

                let faqsData = defaultMenuItems
                let menuItem = faqsData[indexPath.row]
                menuCell.imgMenuItem.image = menuItem.image
                //menuCell.lblMenuItem.configureLabel(fontTitle: Fonts.DMSans.Medium, fontSize: 16)
                menuCell.lblMenuItem.text = menuItem.title
                return menuCell
            }
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewMenu.deselectRow(at: indexPath, animated: true)

        if indexPath.section == 0 {
//            showUserAccountController()
        }
        else if indexPath.section == 1 {

            switch defaultMenuItems[indexPath.row].type {
            case .Profile:
                let profileVC = Storyboards.PROFILE.instantiateViewController(withIdentifier: ProfileViewController.className) as! ProfileViewController
                pushController(viewController: profileVC)
                break
            case .SavingHub:
                let savingHubVC = Storyboards.SAVING_HUB.instantiateViewController(withIdentifier: SavingHubViewController.className) as! SavingHubViewController
                pushController(viewController: savingHubVC)
                break
            case .StushDebitCard:
                let profileVC = Storyboards.OTHER.instantiateViewController(withIdentifier: StushDebitCardViewController.className) as! StushDebitCardViewController
                pushController(viewController: profileVC)
                break
            case .TransactionHistory:
                dismissController()
                break
            case .ChangePassword:
                dismissController()
                break
            case .DeleteAccount:
                dismissController()
                deleteUser()
                break
            case .ContactUs:
                let contactUsVC = Storyboards.OTHER.instantiateViewController(withIdentifier: ContactUsViewController.className) as! ContactUsViewController
                pushController(viewController: contactUsVC)
                break
            case .Logout:
                dismissController()
                logoutUser()
                break
            }
        }
    }
}
