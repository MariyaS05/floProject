//
//  FirstTableViewCell.swift
//  floProject2
//
//  Created by Мария  on 15.12.22.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    @IBOutlet weak var imageViewCell: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    static let identifier  = "FirstTableViewCell"
    static let nib =  UINib(nibName: identifier, bundle: nil)

   
 
    override func awakeFromNib() {
        super.awakeFromNib()
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
