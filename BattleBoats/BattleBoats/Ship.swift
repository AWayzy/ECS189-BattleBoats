//
//  Ship.swift
//  BattleBoats
//
//  Created by Austin Way on 2/15/21.
//

import Foundation
import UIKit

class Ship: UIImageView{
    var name: String
    var length: Int
    var orientation: String
    var cellSide: CGFloat
    var height: CGFloat
    var width: CGFloat
    var x: CGFloat
    var y: CGFloat
    let originx: CGFloat
    let originy: CGFloat
    
    
    init(name: String, length: Int, orientation: String, x: CGFloat, y: CGFloat, cellSide: CGFloat){
        self.name = name
        self.length = length
        self.orientation = orientation
        self.cellSide = cellSide
        self.height = cellSide * CGFloat(length)
        self.width = cellSide
        self.x = x
        self.y = y
        self.originx = x
        self.originy = y
        super.init(frame: CGRect(x: x, y: y, width: cellSide, height: cellSide*CGFloat(length)))
        self.backgroundColor = UIColor.green
        self.isUserInteractionEnabled = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rotate90(){
        if self.orientation == "H"{
            self.orientation = "V"
        }
        else if self.orientation == "V"{
            self.orientation = "H"
        }
    }
    
}
