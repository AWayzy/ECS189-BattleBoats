//
//  Board.swift
//  BattleBoats
//
//  Created by Austin Way on 2/12/21.
//

import Foundation


class Board{
    let rows = 8
    let cols = 8
    var board = [[Cell]]()
    var boardtype: String
    
    init(type: String){
        self.boardtype = type
        for _ in 1...8{
            var row = [Cell]()
            for _ in 1...8{
                let col = Cell(celltype: .Empty)
                row.append(col)
            }
            self.board.append(row)
        }
        
    }
    
    func updateBoards(){
        return
    }
    
    
    
    
    
    func isHidden(poop: Bool){
        if poop == true{
            //do sumn
            return
        }
        else{
            //do sumn else
            return
        }
    }
    
}
