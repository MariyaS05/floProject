//
//  SecondReviewTableViewCell.swift
//  floProject2
//
//  Created by Мария  on 4.12.22.
//

import UIKit

class SecondReviewTableViewCell: UITableViewCell {

    static let indentifier = "SecondReviewTableViewCell"
    static let nib =  UINib(nibName: indentifier, bundle: nil)
    
    @IBOutlet weak var imageViewReview: UIImageView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var reviewTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageViewReview.image = UIImage(named: "review")
        configLabel()
        configLabelText()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configLabel(){
        reviewLabel.text =  "Рецензент"
        reviewLabel.textColor = .lightGray
        reviewLabel.font = .systemFont(ofSize: 12)
    }
    private func configLabelText(){
        reviewTextLabel.text =  "Медицинская коллегия Flo, Более 50 врачей и экспертов из Европы и Северной Америки."
        reviewTextLabel.lineBreakMode = .byWordWrapping
        reviewTextLabel.numberOfLines = 0
        reviewTextLabel.font = .systemFont(ofSize: 12)
        
    }
    
}
