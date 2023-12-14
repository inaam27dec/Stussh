//
//  StushDebitCardViewController.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/23/23.
//

import UIKit
import RxSwift

class StushDebitCardViewController: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblExiryDate: UILabel!
    @IBOutlet weak var lblCVV: UILabel!
    @IBOutlet weak var viewInActive: UIView!
    @IBOutlet weak var lblAvailableBalance: UILabel!
    @IBOutlet weak var btnLostStolen: UIButton!
    @IBOutlet weak var btnActivateCard: UIButton!
    @IBOutlet weak var lblCardNumber: UILabel!
    @IBOutlet weak var lblCardHolderName: UILabel!
    
    var cardViewModel = StushCardViewModel.shared
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerObservers()
        getCardDetails()
    }
    
    private func getCardDetails() {
        cardViewModel.getCardDetails(requestModel: GetCardDetailsRequestModel(userUid: UserDefaultsHandler.sharedInstance.getMyUserObj()?.uid ?? ""))
    }
    
    fileprivate func registerObservers() {
        
        cardViewModel.cardActivated.observe(on: MainScheduler.instance)
            .subscribe({ [weak self] (event) in
                guard let `self` = self else { return }
                
                if let element = event.element {
                    switch element.state {
                    case .loading:
                        self.showLoader()
                        break
                    case .success:
                        self.hideLoader()
                        if let error = element.data?.isError {
                            if error == false {
                                
                                AlertPopupService.sharedInstance.showAlert(inVC: self,alertDescription: Constants.alertCardActivatedSuccess, buttonTitle: Constants.buttonOkTxt, completionButtonClick: {
                                    self.getCardDetails()
                                    
                                })
                                
                            } else {
                                showAlertDialog(errorMsg: element.data?.message ?? "")
                            }
                        }
                        break
                    case .failure:
                        self.hideLoader()
                        showAlertDialog(errorMsg: element.error?.localizedDescription ?? Constants.kFailed)
                        break
                    }
                }
                
            })
            .disposed(by: bag)
        
        cardViewModel.cardDetails.observe(on: MainScheduler.instance)
            .subscribe({ [weak self] (event) in
                guard let `self` = self else { return }
                
                if let element = event.element {
                    switch element.state {
                    case .loading:
                        self.showLoader()
                        break
                    case .success:
                        self.hideLoader()
                        if let error = element.data?.isError {
                            if error == false {
                                
                                setCardData(obj: element.data?.data)
                            } else {
                                showAlertDialog(errorMsg: element.data?.message ?? "")
                            }
                        }
                        break
                    case .failure:
                        self.hideLoader()
                        showAlertDialog(errorMsg: element.error?.localizedDescription ?? Constants.kFailed)
                        break
                    }
                }
                
            })
            .disposed(by: bag)
    }
    
    private func setCardData(obj : StushCardDetails?) {
        if let cardDetails = obj {
            lblCardNumber.text = cardDetails.cardNumber.addSpacesAfter4Digits()
            lblCardHolderName.text = "\(UserDefaultsHandler.sharedInstance.getMyUserObj()?.firstName ?? "") \(UserDefaultsHandler.sharedInstance.getMyUserObj()?.lastName ?? "")"
            lblExiryDate.text = cardDetails.expiryDate
            lblCVV.text = "\(cardDetails.cvv)"
            viewInActive.isHidden = cardDetails.isActivated
            btnActivateCard.isHidden = cardDetails.isActivated
            
            lblAvailableBalance.text = cardDetails.isActivated ? "$0" : "N/A"
        }
    }
    
    
    func showAlertDialog(errorMsg : String){
        AlertPopupService.sharedInstance.showAlert(inVC: self,alertDescription: errorMsg, buttonTitle: Constants.buttonOkTxt, completionButtonClick: {
            
        })
    }
    

    @IBAction func actionButtonPress(_ sender: UIButton) {
        switch sender {
        case btnActivateCard:
            cardViewModel.activateCard(requestModel: GetCardDetailsRequestModel(userUid: UserDefaultsHandler.sharedInstance.getMyUserObj()?.uid ?? ""))
            break
        case btnBack:
            self.navigationController?.popViewController(animated: true)
            break
        case btnLostStolen:
            break
        default:
            break
        }
    }
    
}
