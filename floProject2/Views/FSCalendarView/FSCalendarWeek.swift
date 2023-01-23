//
//  FSCalendarWeek.swift
//  floProject2
//
//  Created by Мария  on 20.01.23.
//

import UIKit
import FSCalendar

class FSCalendarWeek: FSCalendar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    init(calendarScope : FSCalendarScope, scrollDirection : FSCalendarScrollDirection){
        super.init(frame: .zero)
        self.scope =  calendarScope
        self.scrollDirection =  scrollDirection
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(){
        translatesAutoresizingMaskIntoConstraints =  false
        firstWeekday =  2
        appearance.selectionColor = Color.blue
        appearance.todayColor = Color.pinkColor
        placeholderType = FSCalendarPlaceholderType.none
        appearance.titleFont = UIFont.systemFont(ofSize: 18)
        appearance.headerTitleAlignment = .center
        appearance.headerMinimumDissolvedAlpha = 0.0
        appearance.headerTitleColor = .black
        appearance.weekdayTextColor = .systemGray2
        appearance.weekdayFont = .systemFont(ofSize: 14, weight: .medium)
    }
    
}
