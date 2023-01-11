//
//  ThirdAdvicesTableViewCell.swift
//  floProject2
//
//  Created by Мария  on 15.12.22.
//

import UIKit

class ThirdAdvicesTableViewCell: UITableViewCell {
    static let identifier = "ThirdAdvicesTableViewCell"
    static let nib =  UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var informationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configure(){
        informationLabel.textColor = .lightGray
        informationLabel.numberOfLines = 0
        informationLabel.text = ""
    }
}
