//
//  TableViewCell.swift
//  GetContactSchedule
//
//  Created by Marco Dos Santos on 18/02/2020.
//  Copyright © 2020 Marco Dos Santos. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell{
    
//    func getBoolValue() -> Bool {
//        return switchSelected.isOn
//    }
    
    
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelNumber: UILabel!
    
    @IBOutlet weak var switchSelected: UISwitch!
    
    var delegate : TableViewCellSelected?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
//
//    @IBAction func switchChanged(_ sender: UISwitch) {
//        delegate?.didSwitchEbalbed(enabled: sender.isOn, fromCell: self)
//    }
}
protocol TableViewCellSelected {
    func didSwitchEbalbed(enabled : Bool, fromCell cell : TableViewCell)
}
