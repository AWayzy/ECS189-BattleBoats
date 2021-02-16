//
//  Cell.swift
//  BattleBoats
//
//  Created by Austin Way on 2/15/21.
//

import Foundation


class Cell{
    let fill: String = "none"
    let isHidden: Bool = false
    var celltype: celltype
    
    
    enum celltype{
        case initialNone
        case Hit
        case HitShip
        case Miss
        case SafeShip
        case Empty
    }
    
    init(celltype: celltype = .initialNone){
        self.celltype = celltype
    }
    
    
}
