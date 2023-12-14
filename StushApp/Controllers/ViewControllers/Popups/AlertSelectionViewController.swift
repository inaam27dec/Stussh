//
//  AlertSelectionViewController.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/21/23.
//

import UIKit

protocol ItemSelected {
    func onItemSelected (selectedItem : String)
}

class AlertSelectionViewController: UIViewController {

    @IBOutlet weak var tblSelection: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    var dialogTitle : String = ""
    var delegate : ItemSelected?
    var itemsList : [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    

    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setupTableView(){
        lblTitle.text = dialogTitle
        tblSelection.delegate = self
        tblSelection.dataSource = self
        tblSelection.register(UINib(nibName: SelectionCell.className, bundle: nil), forCellReuseIdentifier: SelectionCell.className)
    }
    
}

extension AlertSelectionViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblSelection.dequeueReusableCell(withIdentifier: SelectionCell.className) as? SelectionCell
        
        if let selectionCell = cell {
            selectionCell.lblItem.text = itemsList?[indexPath.row]
            return selectionCell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true)
        delegate?.onItemSelected(selectedItem: itemsList?[indexPath.row] ?? "")
    }
}
