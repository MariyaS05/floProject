//
//  UIViewController+ext.swift
//  floProject2
//
//  Created by Мария  on 3.01.23.
//

import UIKit
import SafariServices

extension UIViewController {
    func presentSafariVC(with url : URL) {
        let safariVC =  SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .black
        present(safariVC, animated: true)
    }
}
