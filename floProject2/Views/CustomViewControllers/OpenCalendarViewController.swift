//
//  OpenCalendarViewController.swift
//  floProject2
//
//  Created by Мария  on 18.01.23.
//

import UIKit
import FSCalendar


class OpenCalendarViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate,FSCalendarDelegateAppearance {
    fileprivate weak var calendar : FSCalendar!
    let dateOfStartperiod =  LocalStorageManager.getUserInfo().last?.dateOfPeriod
    var endOfMenstruation = Date()
    var startOfOvulation = Date()
    var endOfOvulation = Date()
    var endOfCycle = Date()
    
    init(calendarScope : FSCalendarScope, scrollDirection : FSCalendarScrollDirection ){
        super.init(nibName: nil, bundle: nil)
        configureCalendar()
        self.calendar.scope =  calendarScope
        self.calendar.scrollDirection =  scrollDirection
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDatesOfPeriod()
    }
    
    func configureCalendar(){
        
        let calendar = FSCalendar()
        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
        self.calendar = calendar
        calendar.translatesAutoresizingMaskIntoConstraints =  false
        calendar.firstWeekday =  2
        calendar.pagingEnabled = false
        calendar.rowHeight = 70
        calendar.locale = .current
        calendar.appearance.selectionColor = Color.blue
        calendar.appearance.todayColor = Color.pinkColor
        calendar.placeholderType = FSCalendarPlaceholderType.none
        
    
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
    func setDatesOfPeriod(){
        endOfMenstruation = getNewDate(from: dateOfStartperiod!, with: DaysOfPeriod.durationOfMenstruation)
        startOfOvulation =  getNewDate(from: dateOfStartperiod!, with: DaysOfPeriod.startOfOvulation)
        endOfOvulation =  getNewDate(from: startOfOvulation, with: DaysOfPeriod.ovulationPeriod)
        endOfCycle =  getNewDate(from: dateOfStartperiod!, with: DaysOfPeriod.cycleTime)
    }
}
