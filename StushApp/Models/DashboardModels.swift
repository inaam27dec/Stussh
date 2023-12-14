//
//  DashboardModels.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/18/23.
//

import Foundation
import UIKit

struct DashboardItem {
    let isActive : Bool
    let dashboardType: DashboardType
}


enum DashboardType: String {
    case CrowdSaving = "Crowd Saving Program"
    case SavingHub = "My Saving Hub"
    case Profile = "My Profile"
    case Wallet = "My Wallet"
    case CreditBuilding = "Auto & Credit Billings"
    case TransformDeposits = "Transfer & Deposits"
    case CashEarning = "Cash Earning"
    case DirectDeposit = "Direct Deposit"
}


let dashboardItemsArray : [DashboardItem] = [
    DashboardItem(isActive: true, dashboardType: .CrowdSaving),
    DashboardItem(isActive: true, dashboardType: .SavingHub),
    DashboardItem(isActive: true, dashboardType: .Profile),
    DashboardItem(isActive: true, dashboardType: .Wallet),
    DashboardItem(isActive: false, dashboardType: .CreditBuilding),
    DashboardItem(isActive: false, dashboardType: .TransformDeposits),
    DashboardItem(isActive: false, dashboardType: .CashEarning),
    DashboardItem(isActive: false, dashboardType: .DirectDeposit),
]
