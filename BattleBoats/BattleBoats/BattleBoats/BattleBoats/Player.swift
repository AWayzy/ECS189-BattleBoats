//
//  Player.swift
//  BattleBoats
//
//  Created by Austin Way on 2/12/21.
//

import Foundation


class Player{
    var ID: Int
    
    init(givenID: Int){
        self.ID = givenID
    }
    
    var shootingBoard = Board(type: "none")
    var setBoard = Board(type: "none")


}
