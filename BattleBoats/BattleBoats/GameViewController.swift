//
//  GameViewController.swift
//  BattleBoats
//
//  Created by Austin Way on 2/12/21.
//

import UIKit

class GameViewController: UIViewController {
    
    var theGame = Game()
    var missSquare: UIView!
    var hitSquare: UIView!
    var emptySquare: UIView!
    var shipSquare: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let player1setBoard = theGame.player1.setBoard
        let player1shootBoard = theGame.player1.shootingBoard
        let player2setBoard = theGame.player2.setBoard
        let player2shootBoard = theGame.player2.shootingBoard
        
        emptySquare = UIView(frame: CGRect(x: 0.0 , y: 0.0, width: 0, height: 0))
        emptySquare.backgroundColor = UIColor.gray
        
        hitSquare = UIView(frame: CGRect(x: 0.0 , y: 0.0, width: 0, height: 0))
        hitSquare.backgroundColor = UIColor.red
        
        missSquare = UIView(frame: CGRect(x: 0.0 , y: 0.0, width: 0, height: 0))
        missSquare.backgroundColor = UIColor.white
        
        self.updateBoardView()
        self.runGame()
        
        // Do any additional setup after loading the view.
    }
    
    func updateBoardView(){
        
        // write some sort of iteration here that will iteratively read the correct board and update the view controller accordingly. still doing research on how to properly detect screen sizes and everything, but this is likely how we will create most of the board
        
        missSquare = UIView(frame: CGRect(x:0.0, y:0.0, width: 100, height: 100))
        missSquare.backgroundColor = UIColor.black
        view.addSubview(missSquare)
        return
    }
    
    func runGame(){
        return
    }


}

