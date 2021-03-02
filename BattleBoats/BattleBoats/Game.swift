//
//  Game.swift
//  BattleBoats
//
//  Created by Austin Way on 2/15/21.
//

import Foundation


class Game {
    var player1 = Player(givenID: 1)
    var player2 = Player(givenID: 2)
    // gametype will take either localpvp, localbot or pvp as type.
    var gametype: String = ""
    
    init(type: String = "None"){
        self.gametype = type
        
        let player1setboard = Board(type: "Set")
        let player1shootboard = Board(type: "Shoot")
        let player2setboard = Board(type: "Set")
        let player2shootboard = Board(type: "Shoot")
        
        player1.setBoard = player1setboard
        player1.shootingBoard = player1shootboard
        
        player2.setBoard = player2setboard
        player2.shootingBoard = player2shootboard
    
//        let _ = Ship(name: "Ship 1", length: 3, orientation: "h", startPoint: [0,0], cellSide: 0.0)
//        let _ = Ship(name: "Ship 2", length: 3, orientation: "h", startPoint: [0,0], cellSide: 0.0)
//        let _ = Ship(name: "Ship 3", length: 4, orientation: "h", startPoint: [0,0], cellSide: 0.0)
//        let _ = Ship(name: "Ship 4", length: 4, orientation: "h", startPoint: [0,0], cellSide: 0.0)
//        let _ = Ship(name: "Ship 5", length: 5, orientation: "h", startPoint: [0,0], cellSide: 0.0)
        
        
    }
    
    func fire(player: Player){
        if player.ID == 1{
            //fire stuff here
            
            var fired_at: [Int] = [1,1]
            player1.shootingBoard.board[fired_at[1]][fired_at[2]].celltype = .Hit
        }
    }
    
    
}
