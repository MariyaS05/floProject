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
//        containerView =  nil
    }
    func presentAlert(title : String,message : String, buttonTitle : String){
        DispatchQueue.main.async {
            let alertVC = AlertViewController(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    @objc func returnToSettings (){
        let vc = SettingsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func presentCalendar(scope: FSCalendarScope,scroll: FSCalendarScrollDirection){
        
        let calendarVC = OpenCalendarViewController(calendarScope: scope, scrollDirection: scroll)
            let navVC = UINavigationController(rootViewController: calendarVC)
            navVC.modalPresentationStyle = .fullScreen
            navVC.modalTransitionStyle = .crossDissolve
            self.present(navVC, animated: true)
        }
    func getNewDate(from date : Date, with day : DateComponents)->Date {
        let newDate = Calendar.current.date(byAdding: day, to: date)
        return newDate ?? Date()
    }
            
    }

