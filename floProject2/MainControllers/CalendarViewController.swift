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
    var userInfo =  LocalStorageManager.getUserInfo().last?.period.last
    var period =  LocalStorageManager.getUserInfo().last?.period

    var circleView =  CircleDaysOfPeriodView()
    var datesView =  DatesView()
    var currentDate = Date()
    var days : Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        configureCalendar()
        days = countTheNumberOfDays(from: userInfo?.endOfCycle ?? Date(), to: currentDate)
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
        datesView.configureDate(for: datesView.dateNextMnstrLabel, with: userInfo?.endOfCycle ?? Date())
        
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
}
extension CalendarViewController : FSCalendarDataSource, FSCalendarDelegate,FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        currentDate = date
        period?.forEach({ period in
            days =  countTheNumberOfDays(from: period.endOfCycle, to: currentDate)
            circleView.configureWith(days: days)
        })
        return true
    }
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendar.frame.size.height = bounds.height
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        var color : UIColor? =  nil
        let newDate  =  date.convertToMonthYearFormat()
        if newDate == Date().convertToMonthYearFormat() {
            return Color.pinkColor
        }
        period?.forEach({ period in
            if period.endOfCycle.convertToMonthYearFormat() == newDate {
                color = Color.pinkColor
            } else {
                if period.ovulationDay.convertToMonthYearFormat() ==  newDate {
                    color =  Color.lightBlue
                } else {
                    if period.durationOfMenstruation.contains(newDate){
                        color = Color.pinkColor
                    }
                }
            }
        })
        return color
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        var color : UIColor = .black
        let newDate  =  date.convertToMonthYearFormat()
        if newDate == Date().convertToMonthYearFormat() {
            return .white
        }
        period?.forEach { period in
            if period.ovulationDay.convertToMonthYearFormat() == newDate {
                color =  .white
            } else {
                if period.durationOfMenstruation.contains(newDate){
                    color = .white
                } else {
                    if period.durationOfOvulation.contains(newDate){
                        color = Color.lightBlue
                    }
                }
            }
        }
        return color
    }
}
extension CalendarViewController : CalendarViewControllerDelegate {
    
    func markPeriods(){
        guard LocalStorageManager.getUserInfo().first != nil else {return}
        if currentDate > Date() {
            presentAlert(title: "", message: "Невозможно выбрать дату", buttonTitle: "Ок")
        } else {
            let newPeriod =  createPeriod(from: currentDate)
            period?.append(newPeriod)
            days = countTheNumberOfDays(from: newPeriod.endOfCycle, to: Date())
            circleView.configureWith(days: days)
            datesView.configureDate(for: datesView.dateLastMnstrLabel, with: newPeriod.dateOfStartperiod)
            datesView.configureDate(for: datesView.dateNextMnstrLabel, with: newPeriod.endOfCycle)
        }
    }
}


