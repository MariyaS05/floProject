//
//  CircleDaysOfPeriodDayView.swift
//  floProject2
//
//  Created by Мария  on 22.01.23.
//

import UIKit

class CircleDaysOfPeriodView: UIView {
    
    let buttonMarkStartOfPeriod =  ButtonStartPeriod()
    let firstTitleLabel = TitleLabel(fontSize: 18, weight: .medium, textAlignment: .center)
    let daysTitleLabel = TitleLabel(fontSize: 50, weight: .bold, textAlignment: .center)
    let discriptionTitleLabel = TitleLabel(fontSize: 16, weight: .regular, textAlignment: .center)
    private var isMenstr : Bool = false
    weak var delegate : CalendarViewControllerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureView(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius =  150
    }
    
    private func configureSubViews(){
        addSubview(buttonMarkStartOfPeriod)
        addSubview(firstTitleLabel)
        addSubview(daysTitleLabel)
        addSubview(discriptionTitleLabel)
        
        firstTitleLabel.text = "Месячные через"
        buttonMarkStartOfPeriod.setButton(with: Color.pinkColor, title: "Отметить месячные", fontSize: 14)
        discriptionTitleLabel.numberOfLines =  2
        buttonMarkStartOfPeriod.addTarget(self, action: #selector(buttonStartMenstrTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            firstTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 60),
            firstTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            firstTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            firstTitleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            daysTitleLabel.topAnchor.constraint(equalTo: firstTitleLabel.bottomAnchor, constant: 10),
            daysTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            daysTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            daysTitleLabel.heightAnchor.constraint(equalToConstant: 60),
            
            discriptionTitleLabel.topAnchor.constraint(equalTo: daysTitleLabel.bottomAnchor, constant: 20),
            discriptionTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            discriptionTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            discriptionTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            
            buttonMarkStartOfPeriod.topAnchor.constraint(equalTo: discriptionTitleLabel.bottomAnchor, constant: 20),
            buttonMarkStartOfPeriod.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 70),
            buttonMarkStartOfPeriod.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -70),
            buttonMarkStartOfPeriod.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    func configureWith(days:Int) {
        guard days > 0 else {
            daysTitleLabel.text = "День Х"
            return }
        daysTitleLabel.text =  String(days)
        switch days {
        case 1...13 :
            isMenstr =  false
            discriptionTitleLabel.text = CycleDescription.lowСhanceOfGettingPregnant
            self.backgroundColor = .white
            buttonChangeColor()
        case 14:
            isMenstr =  false
            discriptionTitleLabel.text =  CycleDescription.chanceOfGettingPregnant
            self.backgroundColor = Color.lightBlue
            buttonChangeColor()
        case 15 :
            isMenstr =  false
            discriptionTitleLabel.text =  CycleDescription.highChanceOfGettingPregnant
            self.backgroundColor =  Color.lightBlue
            buttonChangeColor()
        case 16...19 :
            isMenstr =  false
            discriptionTitleLabel.text =  CycleDescription.chanceOfGettingPregnant
            self.backgroundColor =  Color.lightBlue
            buttonChangeColor()
        case 20...23 :
            isMenstr =  false
            discriptionTitleLabel.text =  CycleDescription.lowСhanceOfGettingPregnant
            self.backgroundColor =  .white
            buttonChangeColor()
        case 24...28 :
            isMenstr =  true
            discriptionTitleLabel.text =  CycleDescription.lowСhanceOfGettingPregnant
            self.backgroundColor = Color.pinkColor
            buttonChangeColor()
        default:
            discriptionTitleLabel.text = ""
        }
    }
    func configereNextPeriod(days: Int){
        daysTitleLabel.text =  String(days)
        switch days {
        case 1...5 :
            self.backgroundColor = Color.pinkColor
            firstTitleLabel.text = "День"
        default:
            discriptionTitleLabel.text = "Что-то пошло не так"
        }
    }
    private func buttonChangeColor(){
        switch isMenstr {
        case true :
            buttonMarkStartOfPeriod.backgroundColor = .white
            buttonMarkStartOfPeriod.setTitleColor(Color.pinkColor, for: .normal)
        case false :
            buttonMarkStartOfPeriod.backgroundColor = Color.pinkColor
            buttonMarkStartOfPeriod.setTitleColor(.white, for: .normal)
        }
    }
    @objc func buttonStartMenstrTapped(){
        delegate?.markPeriods()
    }
}
