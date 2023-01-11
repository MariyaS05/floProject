//
//  UIViewController+ext.swift
//  floProject2
//
//  Created by Мария  on 3.01.23.
//

import UIKit
import SafariServices
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
}
