//
//  CalendarViewController.swift
//  floProject2
//
//  Created by Мария  on 19.09.22.
//

import UIKit
import FSCalendar
protocol CalendarViewControllerDelegate : AnyObject {
    func markPeriods()
}

class CalendarViewController: UIViewController {
    var calendar = FSCalendarWeek(calendarScope: .week, scrollDirection: .vertical)
    let dateOfStartperiod =  LocalStorageManager.getUserInfo().last?.dateOfPeriod
    var endOfMenstruation = Date()
    var startOfOvulation = Date()
    var endOfOvulation = Date()
    var endOfCycle = Date()
    var ovulationDay =  Date()
    var durationOfMenstruation :[String] = []
    var durationOfOvulation : [String] = []
    var durationOfCycle : [String] = []
    var fromEndOfMenstruationToOvulation : [String] = []
    var circleView =  CircleDaysOfPeriodView()
    var currentDate = Date()
    var days : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDatesOfPeriod()
        makePeriodsArray()
        setNavBar()
        configureCalendar()
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
        days = countTheNumberOfDays(from: endOfCycle, to: currentDate)
        circleView.configureWith(days: days)
        circleView.delegate =  self
        
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: -150),
            circleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            circleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            circleView.heightAnchor.constraint(equalTo: circleView.widthAnchor)
        ])
    }
    
    @objc func calendarButtonTapped(){
        presentCalendar()
    }
    
    func setDatesOfPeriod(){
        endOfMenstruation = getNewDate(from: dateOfStartperiod!, with: DaysOfPeriod.durationOfMenstruation)
        startOfOvulation =  getNewDate(from: dateOfStartperiod!, with: DaysOfPeriod.startOfOvulation)
        endOfOvulation =  getNewDate(from: startOfOvulation, with: DaysOfPeriod.ovulationPeriod)
        endOfCycle =  getNewDate(from: dateOfStartperiod!, with: DaysOfPeriod.cycleTime)
        ovulationDay =  getNewDate(from: dateOfStartperiod!, with: DaysOfPeriod.ovulation)
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
            durationOfCycle.append(newDate)
        }
        let fromMentrToOvul = dates(from: endOfMenstruation, to: startOfOvulation)
        for i in fromMentrToOvul {
            let newDate =   i.convertToMonthYearFormat()
            self.fromEndOfMenstruationToOvulation.append(newDate)
        }
    }
    func countTheNumberOfDays(from nextDate : Date, to todayDate: Date)->Int{
        let units: Set<Calendar.Component> = [.day, .month, .year]
        let countOfDate =  Calendar.current.dateComponents( units, from: todayDate, to: nextDate)
        return countOfDate.day ?? 0
    }
}
extension CalendarViewController : FSCalendarDataSource, FSCalendarDelegate,FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        currentDate = date
        days = countTheNumberOfDays(from: endOfCycle, to: currentDate)
        circleView.configureWith(days: days)
        return true
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendar.frame.size.height = bounds.height
    }
    
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let newDate  =  date.convertToMonthYearFormat()
        if newDate == Date().convertToMonthYearFormat() {
            return Color.pinkColor
        }
        if ovulationDay.convertToMonthYearFormat() == newDate {
            return Color.lightBlue
        } else {
            if durationOfMenstruation.contains(newDate){
                return Color.pinkColor
            }
            return nil
        }
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let newDate  =  date.convertToMonthYearFormat()
        if newDate == Date().convertToMonthYearFormat() {
            return .white
        }
        if ovulationDay.convertToMonthYearFormat() == newDate {
            return .white
        } else {
            if durationOfOvulation.contains(newDate){
                return Color.lightBlue
            } else{
                if durationOfMenstruation.contains(newDate){
                    return .white
                }
                return nil
            }
        }
    }
}
extension CalendarViewController : CalendarViewControllerDelegate {
    func markPeriods() {
        guard var userInfo  = LocalStorageManager.getUserInfo().first else {return}
        if currentDate > Date() {
            presentAlert(title: "", message: "Невозможно выбрать дату", buttonTitle: "Ок")
        } else {
            userInfo.dateOfNextPeriod =  currentDate
            
        }
    }
}

