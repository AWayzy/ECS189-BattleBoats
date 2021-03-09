//
//  GameViewController.swift
//  BattleBoats
//
//  Created by Austin Way on 2/12/21.
//

import UIKit
import Firebase

// From latest branch.
// TODO: Show my board when it's opp's turn, opp's board when it's my turn.
// TODO: Update board strings as well as local boards.
// TODO: Return retval (oppMove) after delay, to allow DB read to kick in.
// TODO: Waiting for other player to join.

var my_5_count = 5
var my_4_count = 4
var my_3_count = 3
var my_E_count = 3
var my_2_count = 2
var opp_5_count = 5
var opp_4_count = 4
var opp_3_count = 3
var opp_E_count = 3
var opp_2_count = 2

//var my_5_count = 0
//var my_4_count = 0
//var my_3_count = 0
//var my_E_count = 1
//var my_2_count = 0
//var opp_5_count = 0
//var opp_4_count = 0
//var opp_3_count = 0
//var opp_E_count = 1
//var opp_2_count = 0

class GameViewController: UIViewController {
    var is_host = 0
    var room_id = ""
    var cur_player = -69
    var my_board = ""
    var opp_board = ""
    var move = -100
    var winner = -1
    
    // illegalMoves array
    
    let dbRef = Database.database().reference()
    
    @IBOutlet weak var makeMoveButton: UIButton!
    @IBOutlet weak var waitingLabel: UILabel!
    
    var theGame = Game()
    
    var cellArray: [CellUnit] = []
        
    @IBOutlet weak var boardView: UIView!
    
    @IBOutlet weak var roomIdLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomIdLabel.text = room_id
//        var board_rep = "543E2xxxxx543E2xxxxx543Exxxxxx54xxxxxxx5xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        
        print(cur_player)
        
        if (cur_player < 0) {
            self.waitingLabel.text = "Wait"
            self.makeMoveButton.isEnabled = false
        } else if (self.is_host != cur_player) {
            self.waitingLabel.text = "Your Turn"
            self.makeMoveButton.isEnabled = true
            self.myTurnFlow() //begin turn flow
        } else {
            self.waitingLabel.text = "Not Your Turn"
            self.makeMoveButton.isEnabled = false
        }
        
        
        
        dbRef.child(room_id).child("turn").observe(.childChanged, with: { (snapshot) -> Void in
            
            let cur_player = snapshot.value as? Int
            print("Current")
            print(cur_player)
            
            if (self.cur_player == -1 && (cur_player ?? 0) == 0) {
                if (self.is_host == 0) {
                    self.dbRef.child(self.room_id).child("board_0").getData { (error, snapshot) in
                        if let error = error {
                            print("Error getting data \(error)")
                        } else if snapshot.exists() {
                            self.opp_board = ((snapshot.value) as? String) ?? ""
                            print("not host: opp board after wait")
                            print(self.opp_board)
                        } else {
                            print("No data available")
                        }
                    }
                } else {
                    self.dbRef.child(self.room_id).child("board_1").getData { (error, snapshot) in
                        if let error = error {
                            print("Error getting data \(error)")
                        } else if snapshot.exists() {
                            self.opp_board = ((snapshot.value) as? String) ?? ""
                            print("host: opp board after wait")
                            print(self.opp_board)
                        } else {
                            print("No data available")
                        }
                    }
                }
            }
            
            if ((cur_player ?? 0) < 0) {
                self.waitingLabel.text = "Wait"
            } else if (self.is_host != cur_player) {
                // getData("move")
                self.waitingLabel.text = "Your Turn"
                self.makeMoveButton.isEnabled = true
                self.myTurnFlow() //begin turn flow
            } else {
                self.waitingLabel.text = "Not Your Turn"
                self.makeMoveButton.isEnabled = false
            }
          
        })
        
        let player1setBoard = theGame.player1.setBoard
        let player1shootBoard = theGame.player1.shootingBoard
        let player2setBoard = theGame.player2.setBoard
        let player2shootBoard = theGame.player2.shootingBoard
        
        
        let sides = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
        let nums = [1,2,3,4,5,6,7,8,9,10]
        
        let cellSide = boardView.bounds.height / 11
        
        let color1 = UIColor(red: 0, green: 94, blue: 184, alpha: 1.0)

        
        for row in stride(from: 0, to: Int(boardView.bounds.height - cellSide), by: Int.Stride(cellSide)) {
            for col in stride(from: 0, to: Int(boardView.bounds.height - cellSide), by: Int.Stride(cellSide)){
                print(Float(row))
                print(Float(col))
                var bothelse = 0
                if(Float(row) == 0.0){
                    let txtField: UITextField = UITextField(frame: CGRect(x: CGFloat(col) + cellSide, y: CGFloat(row), width: cellSide, height: cellSide))
                    for i in 0...9{
                        if(col == Int(cellSide) * i){
                            txtField.text = sides[i]
                        }
                    }
                    txtField.textAlignment = .center
                    txtField.backgroundColor = UIColor.clear
                    txtField.isUserInteractionEnabled = false
                    self.boardView.addSubview(txtField)
                }
                else{
                    bothelse = bothelse + 1
                }
                if(Float(col) == 0.0){
                    let txtField: UITextField = UITextField(frame: CGRect(x: CGFloat(col), y: CGFloat(CGFloat(row) + cellSide), width: cellSide, height: cellSide))
                    for i in 0...9{
                        if(row == Int(cellSide) * i){
                            txtField.text = String(nums[i])
                        }
                    }
                    txtField.textAlignment = .center
                    txtField.backgroundColor = UIColor.clear
                    txtField.isUserInteractionEnabled = false
                    self.boardView.addSubview(txtField)
                }
                else{
                    bothelse = bothelse + 1
                }
                if bothelse == 2{
                    let cellUnit = CellUnit(x: col, y: row , sizeX: Int(cellSide), sizeY: Int(cellSide), color: color1, type: "cell")
                    self.boardView.addSubview(cellUnit)
                    self.cellArray.append(cellUnit)
                }
            }
        }
        
        //self.updateBoardView()
        //self.runGame()
        
        // Do any additional setup after loading the view.
    }
    
//    func testObserve() {
//        dbRef.child("cur_player").observe(.value) { snapshot in
//            print(snapshot.value)
//        }
//    }
    
    // game flow
    func myTurnFlow()
    {
        var oppMove = -100
        self.dbRef.child(self.room_id).child("last_move").getData { (error, snapshot) in
            if let error = error
            {
                print("error getting data \(error)")
            }
            else if snapshot.exists()
            {
                //set the return value to be the last_move in the database
                self.move = ((snapshot.value) as? Int) ?? -100
                oppMove = self.move
                
                print("oppMove: \(oppMove)")
                if oppMove != -1 //if oppMove is negative one, this is the very first move of the game
                {
                    self.processOppMove(oppMove) //only processing oppMove when it's a legit move, not a sentinel
                }
                
                //check if all my ships have been sunk
                if (my_2_count == 0 && my_3_count == 0 && my_E_count == 0 && my_4_count == 0 && my_5_count == 0)
                {
                    self.winner = self.is_host
                    // self.gameOver(winner: self.is_host)
                    
//                    if (self.is_host == 1) {
//                        self.gameOver(winner: 1)
//                    } else {
//                        self.gameOver(winner: 0)
//                    }
                    return
                } else {
                // Repeat this until valid move
                    let myMove = self.getMyMove()
                    self.processMyMove(myMove)
                    self.sendMyMoveToDb(myMove)
                    
                    if ((opp_2_count == 0 && opp_3_count == 0 && opp_E_count == 0 && opp_4_count == 0 && opp_5_count == 0)) {
                        
                        if (self.is_host == 1) {
                            self.winner = 0
                            // self.gameOver(winner: 0)
                        } else {
                            self.winner = 1
                            // self.gameOver(winner: 1)
                        }
                    }
                }
            }
            else
            {
                print("no data available")
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if (self.winner != -1) {
                self.resignTurn()
                self.gameOver(winner: self.winner)
            }
        }
    }
    
    func gameOver(winner: Int) {
        // End game in DB
        self.dbRef.child(self.room_id).child("game_over").getData { (error, snapshot) in
            if let error = error
            {
                print("error getting data \(error)")
            }
            else if snapshot.exists()
            {
                var num_players_notified = snapshot.value as? Int
                num_players_notified? += 1
                self.dbRef.child(self.room_id).child("game_over").setValue(num_players_notified)
                //set the return value to be the last_move in the database
                
            }
            else
            {
                print("no data available")
            }
        }
        
        // Transition
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let endgameViewController = storyboard.instantiateViewController(withIdentifier: "endgameViewController") as? EndgameViewController else {
            assertionFailure("couldn't find vc")
            
            return
        }
        
        endgameViewController.modalPresentationStyle = .fullScreen
        endgameViewController.room_id = self.room_id
        if (winner != is_host) {
            endgameViewController.win = 1
        } else {
            endgameViewController.win = 0
        }
        
        self.present(endgameViewController, animated: true, completion: nil)
    }
    
    func getMyMove() -> Int
    {
        //replace 50 with the move the user presses
        return 0
    }
    
    // opponent move should be retrieved from the db
//    func getOppMove() -> Int
//    {
//        var retval = -100
//        self.dbRef.child(self.room_id).child("last_move").getData { (error, snapshot) in
//            if let error = error
//            {
//                print("error getting data \(error)")
//            }
//            else if snapshot.exists()
//            {
//                //set the return value to be the last_move in the database
//                self.move = ((snapshot.value) as? Int) ?? -100
//                retval = self.move
//            }
//            else
//            {
//                print("no data available")
//            }
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//            // return retval
//        }
//    }
    
    func processOppMove(_ move: Int)
    {
        let checkMove = self.my_board[self.my_board.index(my_board.startIndex, offsetBy: move)]
        if checkMove != "x"
        {
            //hit!
            if checkMove == "E"
            {
                
                my_E_count -= 1
                if (my_E_count == 0)
                {
                    print("sunk my ship E")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH SUNK
                }
                else
                {
                    print("hit my ship E")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH HIT
                }
            }
            else if checkMove == "3"
            {
                
                my_3_count -= 1
                if (my_3_count == 0)
                {
                    print("sunk my ship 3")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH SUNK
                }
                else
                {
                    print("hit my ship 3")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH HIT
                }
            }
            else if checkMove == "2"
            {
                
                my_2_count -= 1
                if (my_2_count == 0)
                {
                    print("sunk my ship 2")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH SUNK
                }
                else
                {
                    print("hit my ship 2")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH HIT
                }
            }
            else if checkMove == "4"
            {
                my_4_count -= 1
                if (my_4_count == 0)
                {
                    print("sunk my ship 4")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH SUNK
                }
                else
                {
                    print("hit my ship 4")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH HIT
                }
            }
            else if checkMove == "5"
            {
                my_5_count -= 1
                if (my_5_count == 0)
                {
                    print("sunk my ship 5")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH SUNK
                }
                else
                {
                    print("hit my ship 5")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH HIT
                }
            }
        }
        else //did not hit
        {
            print("miss")
            //Update board string
            //mark an x on the board where opp missed
        }
    }
    
    func processMyMove(_ move: Int)
    {
        let checkMove = self.opp_board[self.opp_board.index(opp_board.startIndex, offsetBy: move)]
        if checkMove != "x"
        {
            //hit!
            if checkMove == "E"
            {
                opp_E_count -= 1
                if (opp_E_count == 0)
                {
                    print("sunk ship E")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH SUNK
                }
                else
                {
                    print("hit ship E")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH HIT
                }
            }
            else if checkMove == "3"
            {
                opp_3_count -= 1
                if (opp_3_count == 0)
                {
                    print("sunk ship 3")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH SUNK
                }
                else
                {
                    print("hit ship 3")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH HIT
                }
            }
            else if checkMove == "2"
            {
                opp_2_count -= 1
                if (opp_2_count == 0)
                {
                    print("sunk ship 2")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH SUNK
                }
                else
                {
                    print("hit ship 2")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH HIT
                }
            }
            else if checkMove == "4"
            {
                opp_4_count -= 1
                if (opp_4_count == 0)
                {
                    print("sunk ship 4")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH SUNK
                }
                else
                {
                    print("hit ship 4")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH HIT
                }
            }
            else if checkMove == "5"
            {
                opp_5_count -= 1
                if (opp_5_count == 0)
                {
                    print("sunk ship 5")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH SUNK
                }
                else
                {
                    print("hit ship 5")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH HIT
                }
            }
        }
        else //did not hit
        {
            print("miss")
            //Update board string
            //mark an x on the board where I missed
        }
    }
    
    func sendMyMoveToDb(_ move:Int)
    {
        dbRef.child(room_id).child("last_move").setValue(move)
    }
    
    func resignTurn()
    {
        dbRef.child(room_id).child("turn").child("cur_player").setValue(is_host)
    }
    
    @IBAction func attack(_ sender: Any) {
        dbRef.child(room_id).child("turn").child("cur_player").setValue(is_host)
    }
    
    func updateBoardView(){
        
        // write some sort of iteration here that will iteratively read the correct board and update the view controller accordingly. still doing research on how to properly detect screen sizes and everything, but this is likely how we will create most of the board
    
        return
    
    }
    
    func runGame(){
        return
    }


}

