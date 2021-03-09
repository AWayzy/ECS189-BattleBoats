//
//  Ship.swift
//  BattleBoats
//
//  Created by Austin Way on 2/15/21.
//

import Foundation

class Ship{
    var name: String
    var length: Int
    var orientation: String
    var startPoint: [Int]
    var endPoint: [Int]
    
    init(name: String, length: Int, orientation: String, startPoint: [Int]){
        
        self.name = name
        self.length = length
        self.orientation = orientation
        self.startPoint = startPoint
        self.endPoint = [0]
//        if orientation == "h"{
//            self.endPoint = [startPoint[1] + length, startPoint[2]]
//        }
//        else if orientation == "v"{
//            self.endPoint = [startPoint[1], startPoint[2] + length]
//        }
 //       else{
 //           self.endPoint = [1000,1000]
 //       }
        
    }
    
}
