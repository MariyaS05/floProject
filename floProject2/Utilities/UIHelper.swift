//
//  UIHelper.swift
//  floProject2
//
//  Created by Мария  on 5.01.23.
//

import UIKit
struct UIHelper {
    static func createTwoColumnFlowLayout(in view: UIView)->UICollectionViewFlowLayout{
        let width = view.bounds.width
        let padding: CGFloat = 10
        let minimumItemSpasing : CGFloat = 10
        let availableWidth =  width - (padding*2 ) - (minimumItemSpasing)
        let itemWidth = availableWidth/2
        
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        return flowLayout
    }
}

