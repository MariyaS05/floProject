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
    var dateOfStartperiod =  LocalStorageManager.getUserInfo().last?.dateOfPeriod
    
    var endOfCycle = Date()
    var ovulationDay =  Date()
    var durationOfMenstruation :[String] = []
    var durationOfOvulation : [String] = []
    var durationOfCycle : [String] = []
    
    var startOfNext =  LocalStorageManager.getUserInfo().last?.dateOfNextPeriod
    
    var endOfSecondCycle = Date()
    var ovulationSecondDay =  Date()
    var duratonOfSecondMnsrt : [String] = []
    var durationOfSecondOvulation : [String] = []
    var durationOfSecondCycle : [String] = []
    
    var fromEndOfMenstruationToOvulation : [String] = []
    
    var circleView =  CircleDaysOfPeriodView()
    var datesView =  DatesView()
    var currentDate = Date()
    var days : Int = 0
    var isSelected : Bool =  false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDatesOfPeriod()
        makePeriodsArray()
        setNavBar()
        configureCalendar()
        days = countTheNumberOfDays(from: endOfCycle, to: currentDate)
        configureCircleView()
        configureDateView()
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
        circleView.configureWith(days: days)
        circleView.delegate =  self
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: -150),
            circleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            circleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            circleView.heightAnchor.constraint(equalTo: circleView.widthAnchor)
        ])
    }
    func configureDateView(){
        view.addSubview(datesView)
        datesView.translatesAutoresizingMaskIntoConstraints =  false
        datesView.configureDate(for: datesView.dateLastMnstrLabel, with: dateOfStartperiod ?? Date())
        datesView.configureDate(for: datesView.dateNextMnstrLabel, with: startOfNext ?? Date())
        
        NSLayoutConstraint.activate([
            datesView.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 30),
            datesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            datesView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            datesView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    @objc func calendarButtonTapped(){
        presentCalendar()
    }
    func setDatesOfPeriod(){
        endOfCycle =  getNewDate(from: dateOfStartperiod!, with: DaysOfPeriod.cycleTime)
        ovulationDay =  getNewDate(from: dateOfStartperiod!, with: DaysOfPeriod.ovulation)
    }
    
    func makePeriodsArray(){
        if dateOfStartperiod == nil {
            return
        } else {
            durationOfMenstruation = makeDurationOfMenstruation(firstDay: dateOfStartperiod ?? Date())
            durationOfOvulation =  makeDurationOfOvulation(firstDay: dateOfStartperiod ?? Date())
            durationOfCycle =  makeDurationOfCycle(firstDay: dateOfStartperiod ?? Date())
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
        switch isSelected {
        case true :
            days =  countTheNumberOfDays(from: endOfSecondCycle, to: currentDate)
            circleView.configureWith(days: days)
        case false :
            days = countTheNumberOfDays(from: endOfCycle, to: currentDate)
            circleView.configureWith(days: days)
        }
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
        
        if startOfNext?.convertToMonthYearFormat() == newDate {
            return Color.pinkColor
        } else {
            if ovulationDay.convertToMonthYearFormat() == newDate {
                return Color.lightBlue
            } else {
                if durationOfMenstruation.contains(newDate){
                    return Color.pinkColor
                }
                return nil
            }
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
    
    func markPeriods(){
        guard var userInfo  = LocalStorageManager.getUserInfo().first else {return}
        if currentDate > Date() {
            presentAlert(title: "", message: "Невозможно выбрать дату", buttonTitle: "Ок")
        } else {
            isSelected =  true
            userInfo.dateOfNextPeriod =  currentDate
            startOfNext = userInfo.dateOfNextPeriod ?? Date()
            let endOfSecondMnstr =  getNewDate(from: startOfNext ?? Date(), with: DaysOfPeriod.durationOfMenstruation)
            duratonOfSecondMnsrt = makeDurationOfMenstruation(firstDay: startOfNext ?? Date())
            durationOfSecondOvulation =  makeDurationOfOvulation(firstDay: startOfNext ?? Date())
            durationOfSecondCycle =  makeDurationOfCycle(firstDay: startOfNext ?? Date())
            endOfSecondCycle =  getNewDate(from: startOfNext ?? Date(), with: DaysOfPeriod.cycleTime)
            ovulationSecondDay =  getNewDate(from: startOfNext ?? Date(), with: DaysOfPeriod.ovulation)
            days = countTheNumberOfDays(from: endOfSecondCycle, to: startOfNext!)
        }
    }
}


