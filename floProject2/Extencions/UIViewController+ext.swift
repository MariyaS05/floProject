//
//  UIViewController+ext.swift
//  floProject2
//
//  Created by Мария  on 3.01.23.
//

import UIKit
import SafariServices
import FSCalendar
fileprivate var containerView : UIView!

extension UIViewController {
    func presentSafariVC(with url : URL) {
        let safariVC =  SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .black
        present(safariVC, animated: true)
    }
    func showEmptyStateView(in view : UIView, button : UIButton){
        let containerView = EmptyStateView()
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    func dissmissView(){
        containerView.removeFromSuperview()
    }
    func presentAlert(title : String,message : String, buttonTitle : String){
        let alertVC = AlertViewController(alertTitle: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        self.present(alertVC, animated: true)
    }
    @objc func returnToSettings (){
        let vc = SettingsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func presentCalendar(){
        
        let calendarVC = OpenCalendarViewController()
        let navVC = UINavigationController(rootViewController: calendarVC)
        navVC.modalPresentationStyle = .fullScreen
        navVC.modalTransitionStyle = .crossDissolve
        self.present(navVC, animated: true)
    }
    func getNewDate(from date : Date, with day : DateComponents)->Date {
        let newDate = Calendar.current.date(byAdding: day, to: date)
        return newDate ?? Date()
    }
    func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
    func makeDurationOfMenstruation(firstDay : Date) -> [String] {
        var durOfMenstr : [String] = []
        let endOfMenstr =  getNewDate(from: firstDay, with: DaysOfPeriod.durationOfMenstruation)
        let durationOfMenstruation =  dates(from: firstDay, to: endOfMenstr)
        for i in durationOfMenstruation {
            let newDate  =  i.convertToMonthYearFormat()
            durOfMenstr.append(newDate)
        }
        return durOfMenstr
    }
    func makeDurationOfOvulation(firstDay : Date) -> [String] {
        var durOfOvul : [String] = []
        let startOfOvul = getNewDate(from: firstDay, with: DaysOfPeriod.startOfOvulation)
        let endOfOvulation =  getNewDate(from: startOfOvul, with: DaysOfPeriod.ovulationPeriod)
        let durationOfOvulation = dates(from: startOfOvul, to: endOfOvulation)
        for i in durationOfOvulation {
            let newDate  =  i.convertToMonthYearFormat()
            durOfOvul.append(newDate)
        }
        return durOfOvul
    }
    func makeDurationOfCycle(firstDay : Date) -> [String] {
        var durOfPeriod : [String] = []
        let endCycle = getNewDate(from: firstDay, with: DaysOfPeriod.cycleTime)
        let durationOfPeroiod  =  dates(from: firstDay, to: endCycle)
        for i in durationOfPeroiod {
            let newDate  =  i.convertToMonthYearFormat()
            durOfPeriod.append(newDate)
        }
        return durOfPeriod
    }
    func getOvulationDay(with firstDay: Date)->String{
        let ovulationDay =  getNewDate(from: firstDay, with: DaysOfPeriod.ovulation)
        return ovulationDay.convertToMonthYearFormat()
    }
    func createPeriod(from day : Date)->Period{
        let startDay = day
        let endOfMenstr =  getNewDate(from: startDay, with: DaysOfPeriod.durationOfMenstruation)
        let startOfOvul =  getNewDate(from: startDay, with: DaysOfPeriod.startOfOvulation)
        let endOfOvul = getNewDate(from: startOfOvul, with: DaysOfPeriod.ovulationPeriod)
        let endOfcycle =  getNewDate(from: startDay, with: DaysOfPeriod.cycleTime)
        let ovulDay =  getNewDate(from: startDay, with: DaysOfPeriod.ovulation)
        let durationOfMenstr = makeDurationOfMenstruation(firstDay: startDay)
        let durationOvulation  =  makeDurationOfOvulation(firstDay: startDay)
        let durationOfCycle =  makeDurationOfCycle(firstDay: startDay)
        let period =  Period(dateOfStartperiod: startDay, endOfMenstruation: endOfMenstr, startOfOvulation: startOfOvul, endOfOvulation: endOfOvul, endOfCycle: endOfcycle, ovulationDay: ovulDay,durationOfMenstruation: durationOfMenstr,durationOfOvulation: durationOvulation,durationOfCycle: durationOfCycle)
        return period
    }
    func countTheNumberOfDays(from nextDate : Date, to todayDate: Date)->Int{
        let units: Set<Calendar.Component> = [.day, .month, .year]
        let countOfDate =  Calendar.current.dateComponents( units, from: todayDate, to: nextDate)
        return countOfDate.day ?? 0
    }
}

