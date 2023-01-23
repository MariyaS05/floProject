//
//  CircleDaysOfPeriodDayView.swift
//  floProject2
//
//  Created by Мария  on 22.01.23.
//

import UIKit

class CircleDaysOfPeriodView: UIView {
   
    let dayCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollectionView()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureView(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray2
       
    }
   private func configureCollectionView(){
        addSubview(dayCollectionView)
        dayCollectionView.delegate =  self
        dayCollectionView.dataSource =  self
        dayCollectionView.register(DaysCollectionViewCell.self, forCellWithReuseIdentifier: DaysCollectionViewCell.reuseId)

        dayCollectionView.translatesAutoresizingMaskIntoConstraints =  false
        dayCollectionView.showsHorizontalScrollIndicator =  false
    
        NSLayoutConstraint.activate([
            dayCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            dayCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            dayCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            dayCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40)
        ])
    }
}
extension CircleDaysOfPeriodView : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CalendarViewController.durationOfCycle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DaysCollectionViewCell.reuseId, for: indexPath) as! DaysCollectionViewCell
        
        return cell
    }
}
