//
//  Constants.swift
//  GhostDrawingBoardApp
//
//  Created by Anjali Dennis on 2022-09-26.
//

import Foundation
import UIKit


enum Colors: Int, CaseIterable {
    case red = 1
    case green
    case blue
    
    func getColor() -> UIColor {
        switch self {
        case .red:
            return UIColor(named: "Red")!
        case .green:
            return UIColor(named: "Green")!
        case .blue:
            return UIColor(named: "Blue")!
        }
    }
}
