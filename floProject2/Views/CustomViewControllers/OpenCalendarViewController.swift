//
//  OpenCalendarViewController.swift
//  floProject2
//
//  Created by Мария  on 18.01.23.
//

import UIKit
import FSCalendar


class OpenCalendarViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate,FSCalendarDelegateAppearance {
    var calendar = FSCalendarWeek(calendarScope: .month, scrollDirection: .vertical)
    let dateOfStartperiod =  LocalStorageManager.getUserInfo().last?.dateOfPeriod

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCalendar()
    }
    
    func configureCalendar(){
        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
        calendar.pagingEnabled = false
        calendar.rowHeight = 70
        
        self.navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: SFSymbols.calendar), style: .plain, target: self, action: #selector(closeCalendar))
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func closeCalendar(){
        dismiss(animated:true)
    }
    
}
