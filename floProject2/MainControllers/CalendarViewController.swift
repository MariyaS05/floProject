//
//  CalendarViewController.swift
//  floProject2
//
//  Created by Мария  on 19.09.22.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {
    var calendar = FSCalendarWeek(calendarScope: .week, scrollDirection: .vertical)
    let dateOfStartperiod =  LocalStorageManager.getUserInfo().last?.dateOfPeriod
    var endOfMenstruation = Date()
    var startOfOvulation = Date()
    var endOfOvulation = Date()
    var endOfCycle = Date()
    var durationOfMenstruation :[String] = []
    var durationOfOvulation : [String] = []
   static var durationOfCycle : [String] = []
    var circleView =  CircleDaysOfPeriodView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBar()
        configureCalendar()
        setDatesOfPeriod()
        makePeriodsArray()
        configureCircleView()
    }
    func setNavBar(){
        view.backgroundColor =  UIColor(patternImage: UIImage(named: "celendarBackground")!)
        self.navigationItem.leftBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: SFSymbols.personalProfile), style: .plain, target: self, action: #selector(returnToSettings))
        self.navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: SFSymbols.calendar), style: .plain, target: self, action: #selector(calendarButtonTapped))
    }
    func configureCalendar(){
        view.addSubview(calendar)
        calendar.dataSource = self
        calendar.delegate = self
     
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendar.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    func configureCircleView(){
        view.addSubview(circleView)
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: -150),
            circleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            circleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            circleView.heightAnchor.constraint(equalTo: circleView.widthAnchor)
        ])
        print(circleView.frame.width)
    }
    
    @objc func calendarButtonTapped(){
        presentCalendar()
    }
    
    func setDatesOfPeriod(){
        endOfMenstruation = getNewDate(from: dateOfStartperiod!, with: DaysOfPeriod.durationOfMenstruation)
        startOfOvulation =  getNewDate(from: dateOfStartperiod!, with: DaysOfPeriod.startOfOvulation)
        endOfOvulation =  getNewDate(from: startOfOvulation, with: DaysOfPeriod.ovulationPeriod)
        endOfCycle =  getNewDate(from: dateOfStartperiod!, with: DaysOfPeriod.cycleTime)
    }
    func makePeriodsArray(){
       let durationOfMenstruation =  dates(from: dateOfStartperiod!, to: endOfMenstruation)
       let  durationOfOvulation = dates(from: startOfOvulation, to: endOfOvulation)
        let durationOfPeroiod  =  dates(from: dateOfStartperiod!, to: endOfCycle)
        for i in durationOfMenstruation {
            let newDate  =  i.convertToMonthYearFormat()
            self.durationOfMenstruation.append(newDate)
        }
        for i in durationOfOvulation {
            let newDate  =  i.convertToMonthYearFormat()
            self.durationOfOvulation.append(newDate)
        }
        for i in durationOfPeroiod {
            let newDate  =  i.convertToMonthYearFormat()
            CalendarViewController.durationOfCycle.append(newDate)
        }
    }
}
extension CalendarViewController : FSCalendarDataSource, FSCalendarDelegate,FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false
    }
 
   
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendar.frame.size.height = bounds.height
    }
   
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let newDate  =  date.convertToMonthYearFormat()
        if newDate == Date().convertToMonthYearFormat() {
            return Color.pinkColor
        }
        if durationOfOvulation.contains(newDate){
            return Color.blue
        }else {
            if durationOfMenstruation.contains(newDate){
                return Color.pinkColor
            }
            return .white
        }
    }
}


