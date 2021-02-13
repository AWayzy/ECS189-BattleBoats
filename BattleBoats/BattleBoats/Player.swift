//
//  Player.swift
//  BattleBoats
//
//  Created by Austin Way on 2/12/21.
//

import Foundation


class Player{
    var ID: Int
    var ownBoard: Board
    var otherBoard: Board
    
    
    init(givenID: Int, ownBoard: Board, otherBoard: Board){
        self.ID = givenID
        self.ownBoard = ownBoard
        self.otherBoard = otherBoard
    }
    
}
