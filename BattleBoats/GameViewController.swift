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
//var my_5_count = 5
//var my_4_count = 4
//var my_3_count = 3
//var my_E_count = 3
//var my_2_count = 2
//var opp_5_count = 5
//var opp_4_count = 4
//var opp_3_count = 3
//var opp_E_count = 3
//var opp_2_count = 2



class GameViewController: UIViewController {
    
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
    
    var is_host = 0
    var room_id = ""
    var cur_player = -69
    var my_board = ""
    var opp_board = ""
    var move = -100
    var winner = -1
    var didCreateOppBoard: Bool = false
    var ship = Ship(name: "5", length: 5, orientation: "V",x: (0.0 * 2 / 11) - (0.0 / 11), y: 0.0, cellSide: 0.0 / 11)
    
    var not_both_in = true

    
    var myBoardView = UIView()
    var boardView = UIView()
    var boardView2 = UIView()
    var oppBoardView = UIView()
    var oppCellArray: [CellUnit] = []
    var oppCellIDNumber = 0
    var myCells: [CellUnit] = []
    var cellIDNumber = 0
    let color1 = UIColor(red: 0, green: 94, blue: 184, alpha: 1.0)
    var col = 0.0
    var row = 0.0
    
    
    let fakeship = Ship(name: "b", length: -1, orientation: "Q", x: 0, y: 0, cellSide: 0)
    var wasHit = false
    var wasHitAt: Int = -1
    var shipWasHit = Ship(name: "b", length: -1, orientation: "Q", x: 0, y: 0, cellSide: 0)
    var wasMissed = false
    var wasMissedAt: Int = -1
    var shipWasMissed = Ship(name: "b", length: -1, orientation: "Q", x: 0, y: 0, cellSide: 0)
    
    var isGameOver: Bool = false
    
    var tappedCell: Int = -100
    
    let dbRef = Database.database().reference()
    
    @IBOutlet weak var makeMoveButton: UIButton!
    @IBOutlet weak var waitingLabel: UILabel!
    
    
    @IBOutlet weak var hitOrMissLabel: UILabel!
    //    var hitOrMissLabel = UILabel()
    var textToDisplay = ""
    
    
    
    var cellArray: [CellUnit] = []
        
    
    @IBOutlet weak var roomIdLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if #available(iOS 13.0, *) {
                overrideUserInterfaceStyle = .light
        }
    
        
        myBoardView = UIView(frame: CGRect(x: 35, y: (view.bounds.height * (0.4)) - ((view.bounds.width - 70)/2), width: view.bounds.width - 70, height: view.bounds.width - 70))
        
//        makeMoveButton.frame = CGRect(x: view.bounds.width / 6, y: myBoardView.frame.maxY + 70, width: view.bounds.width * (2/3), height: view.bounds.width * (1/3))
//        makeMoveButton.backgroundColor = UIColor.gray
//        makeMoveButton.setTitleColor(UIColor.red, for: .normal)
//        makeMoveButton.setTitle("FIRE!", for: .normal)
//        makeMoveButton.titleLabel?.adjustsFontForContentSizeCategory = true
//        makeMoveButton.titleLabel?.adjustsFontSizeToFitWidth = true
//        makeMoveButton.titleLabel?.font = UIFont(name:"Lucida Grande", size: 70.0)
        makeMoveButton.isHidden = true
        
//        hitOrMissLabel.frame = CGRect(x: view.bounds.width / 6, y: myBoardView.frame.maxY + 70, width: view.bounds.width * (2/3), height: view.bounds.width * (1/3))
//        hitOrMissLabel.text = ""
        hitOrMissLabel.isHidden = true
//        hitOrMissLabel.adjustsFontSizeToFitWidth = true
//        hitOrMissLabel.minimumScaleFactor = 2.0
//        hitOrMissLabel.font = UIFont(name: "Helvetica", size: 15.0)
//
//
//        view.addSubview(hitOrMissLabel)
        
        
        view.addSubview(myBoardView)
        view.sendSubviewToBack(myBoardView)
        
        for view1 in boardView.subviews{
            myBoardView.addSubview(view1)
        }
        
        for cell in myCells{
            if cell.contains.count > 0 {
                let cellUnit = CellUnit(x: cell.col, y: cell.row , size: Int(cell.cellSide), color: UIColor.gray, type: "cell", ID: cellIDNumber)
                cellUnit.layer.borderColor = UIColor.gray.cgColor
                cellUnit.setNeedsDisplay()
                self.myBoardView.addSubview(cellUnit)
                self.cellArray.append(cellUnit)
                self.cellIDNumber += 1
            } else {
                let cellUnit = CellUnit(x: cell.col, y: cell.row , size: Int(cell.cellSide), color: color1, type: "cell", ID: cellIDNumber)
                self.myBoardView.addSubview(cellUnit)
                self.cellArray.append(cellUnit)
                self.cellIDNumber += 1
            }
        }
    
        

        roomIdLabel.text = room_id
        
        print(cur_player)
        
        if (cur_player < 0) {
            self.waitingLabel.text = "Waiting"
            self.makeMoveButton.isEnabled = false
            self.oppBoardView.isHidden = true;
            self.myBoardView.isHidden = false;
        } else if (self.is_host != cur_player) {
            self.not_both_in = false
            self.waitingLabel.text = "Your Play"
            if opp_board != "" {
                self.createOppBoard()
            }
            self.makeMoveButton.isEnabled = true
            self.oppBoardView.isHidden = false;
            self.myBoardView.isHidden = true;
        } else {
            self.not_both_in = false
            self.waitingLabel.text = "Their Play"
            self.makeMoveButton.isEnabled = false
            self.oppBoardView.isHidden = true;
            self.myBoardView.isHidden = false;
        }
        
        
        //MARK: Observing the Change
        dbRef.child(room_id).child("turn").observe(.childChanged, with: { (snapshot) -> Void in
            
            let cur_player = snapshot.value as? Int
            print("Current")
            print(cur_player)
            print("NOT BOTH IN?")
            print(self.not_both_in)
            
            //MARK: Initial Setup
//            if (self.cur_player == -1 && (cur_player ?? 0) == 0) {
//                if (self.is_host == 0) {
//                    self.dbRef.child(self.room_id).child("board_0").getData { (error, snapshot) in
//                        if let error = error {
//                            print("Error getting data \(error)")
//                        } else if snapshot.exists() {
//                            if self.opp_board == ""{
//                                self.opp_board = ((snapshot.value) as? String) ?? ""
//                                print("not host: opp board after wait")
//                                print(self.opp_board)
//                            }
//                        } else {
//                            print("No data available")
//                        }
//                    }
//                } else {
//                    self.dbRef.child(self.room_id).child("board_1").getData { (error, snapshot) in
//                        if let error = error {
//                            print("Error getting data \(error)")
//                        } else if snapshot.exists() {
//                            if self.opp_board == ""{
//                                self.opp_board = ((snapshot.value) as? String) ?? ""
//                                print("host: opp board after wait")
//                                print(self.opp_board)
//                            }
//                        } else {
//                            print("No data available")
//                        }
//                    }
//                }
//            }
            self.initialSetup(cur_player: cur_player) {
                print("GOT TO CLOSURE")
                print(cur_player)
                if self.didCreateOppBoard == true{}
                else{
                self.createOppBoard()
                }
            
            //MARK: Turn Logic
            if (self.not_both_in && self.cur_player == -1 && (cur_player ?? 0) == 0) {
                self.not_both_in = false
                if (self.is_host == 1) {
                    self.waitingLabel.text = "Your Play"
                    self.makeMoveButton.isEnabled = true
                    self.oppBoardView.isHidden = false;
                    self.myBoardView.isHidden = true;
                    self.view.bringSubviewToFront(self.oppBoardView)
                    self.hitOrMissLabel.isHidden = true
                } else {
                    self.hitOrMissLabel.isHidden = true
                    self.waitingLabel.text = "Their Play"
                    self.makeMoveButton.isEnabled = false
                    self.oppBoardView.isHidden = true;
                    self.myBoardView.isHidden = false;
                    self.view.bringSubviewToFront(self.myBoardView)
                }
            }
            else if ((cur_player ?? 0) < 0) {
                self.waitingLabel.text = "Waiting"
                self.oppBoardView.isHidden = true;
                self.myBoardView.isHidden = false;
                self.view.bringSubviewToFront(self.myBoardView)
            }
            //MARK: My Turn
            if ((cur_player ?? 0) >= 0 && self.is_host != cur_player) {
                print("I kno dey askin where da bag at")
//                self.not_both_in = false
                self.startTurnFlow {
                    if self.wasHit{
                        let shipname = self.getFullName(name: self.shipWasHit.name)
                        let cell = self.myCells[self.wasHitAt]
                        self.myBoardView.sendSubviewToBack(cell)
                        let newcell = CellUnit(x: cell.col, y: cell.row, size: Int(cell.cellSide), color: UIColor.orange, type: "cell", ID: cell.IDNum)
                        newcell.hasBeenHit = true
                        newcell.isUserInteractionEnabled = false
                        self.myBoardView.addSubview(newcell)
                        self.myBoardView.bringSubviewToFront(newcell)
                        let snap = UIImpactFeedbackGenerator(style: .heavy)
                        snap.impactOccurred()
                        
                        if self.shipWasHit.name == "5"{
                            if self.my_5_count == 0{
                                self.hitOrMissLabel.text = "They Sunk Your \(shipname)!"
                                self.hitOrMissLabel.isHidden = false
                            }
                            else{
                                self.hitOrMissLabel.text = "They Hit Your \(shipname)!"
                                self.hitOrMissLabel.isHidden = false
                            }
                        }
                        else if self.shipWasHit.name == "4"{
                            if self.my_4_count == 0{
                                self.hitOrMissLabel.text = "They Sunk Your \(shipname)!"
                                self.hitOrMissLabel.isHidden = false
                            }
                            else{
                                self.hitOrMissLabel.text = "They Hit Your \(shipname)!"
                                self.hitOrMissLabel.isHidden = false
                            }
                        }
                        else if self.shipWasHit.name == "2"{
                            if self.my_2_count == 0{
                                self.hitOrMissLabel.text = "They Sunk Your \(shipname)!"
                                self.hitOrMissLabel.isHidden = false
                            }
                            else{
                                self.hitOrMissLabel.text = "They Hit Your \(shipname)!"
                                self.hitOrMissLabel.isHidden = false
                            }
                        }
                        else if self.shipWasHit.name == "3"{
                            if self.my_3_count == 0{
                                self.hitOrMissLabel.text = "They Sunk Your \(shipname)!"
                                self.hitOrMissLabel.isHidden = false
                            }
                            else{
                                self.hitOrMissLabel.text = "They Hit Your \(shipname)!"
                                self.hitOrMissLabel.isHidden = false
                            }
                        }
                        else if self.shipWasHit.name == "E"{
                            if self.my_E_count == 0{
                                self.hitOrMissLabel.text = "They Sunk Your \(shipname)!"
                                self.hitOrMissLabel.isHidden = false
                            }
                            else{
                                self.hitOrMissLabel.text = "They Hit Your \(shipname)!"
                                self.hitOrMissLabel.isHidden = false
                            }
                        }
                        
                        self.wasHit = false
                        self.wasHitAt = -1
                        self.shipWasHit = self.fakeship
                    }
                    else if self.wasMissed{
                        let cell = self.myCells[self.wasMissedAt]
                        self.myBoardView.sendSubviewToBack(cell)
                        let newcell = CellUnit(x: cell.col, y: cell.row, size: Int(cell.cellSide), color: UIColor.black, type: "cell", ID: cell.IDNum)
                        newcell.hasBeenHit = true
                        newcell.isUserInteractionEnabled = false
                        self.myBoardView.addSubview(newcell)
                        self.myBoardView.bringSubviewToFront(newcell)
                        let snap = UIImpactFeedbackGenerator(style: .light)
                        snap.impactOccurred()
                        
                        self.hitOrMissLabel.text = "They Missed!"
                        self.hitOrMissLabel.isHidden = false
                        self.wasMissed = false
                        self.wasMissedAt = -1
                        
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    self.waitingLabel.text = "Your Play"
                    self.makeMoveButton.isEnabled = true
                    self.oppBoardView.isHidden = false;
                    self.myBoardView.isHidden = true;
                    self.view.bringSubviewToFront(self.oppBoardView)
                    self.hitOrMissLabel.isHidden = true
                }
                
            }
            //MARK: Their Turn
            else if (cur_player ?? 0) >= 0{
//                self.not_both_in = false
//                self.hitOrMissLabel.text = self.textToDisplay
//                self.hitOrMissLabel.isHidden = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        self.hitOrMissLabel.isHidden = true
                        self.waitingLabel.text = "Their Play"
                        self.makeMoveButton.isEnabled = false
                        self.oppBoardView.isHidden = true;
                        self.myBoardView.isHidden = false;
                        self.view.bringSubviewToFront(self.myBoardView)
                        }
                    }
                }
            
        })
    }
    
    func getFullName(name: String) -> String{
        if name == "5"{
            return("Carrier")
        }
        else if name == "4"{
            return "Battleship"
        }
        else if name == "3"{
            return "Submarine"
        }
        else if name == "E"{
            return "SpeedBoat"
        }
        else if name == "2"{
            return "Patrol Boat"
        }
        
        
        return ""
    }
    
    
    func createOppBoard(){
        oppBoardView = UIView(frame: CGRect(x: 35, y: (view.bounds.height * (0.4)) - ((view.bounds.width - 70)/2), width: view.bounds.width - 70, height: view.bounds.width - 70))
        view.addSubview(oppBoardView)
        view.sendSubviewToBack(oppBoardView)

        for view1 in boardView2.subviews{
            oppBoardView.addSubview(view1)
        }

        for i in 0...myCells.count - 1{
            let cellUnit = CellUnit(x: myCells[i].col, y: myCells[i].row , size: Int(myCells[i].cellSide), color: color1, type: "cell", ID: oppCellIDNumber)
            self.oppBoardView.addSubview(cellUnit)
            self.oppBoardView.bringSubviewToFront(cellUnit)
            self.oppCellArray.append(cellUnit)
            self.oppCellIDNumber += 1
            if opp_board[opp_board.index(opp_board.startIndex, offsetBy: i)] != "x" {
                cellUnit.contains.append(self.ship)
            }

        oppBoardView.isHidden = true
        
        }
        
        self.didCreateOppBoard = true
    }
    
    func changeView(){
        if myBoardView.isHidden{
            myBoardView.isHidden = false
            view.bringSubviewToFront(myBoardView)
            view.sendSubviewToBack(oppBoardView)
        }
        else{
            myBoardView.isHidden = true
            view.bringSubviewToFront(oppBoardView)
            view.sendSubviewToBack(myBoardView)
        }
        if oppBoardView.isHidden{
            oppBoardView.isHidden = false
            view.bringSubviewToFront(oppBoardView)
            view.sendSubviewToBack(myBoardView)
        }
        else{
            oppBoardView.isHidden = true
            view.bringSubviewToFront(myBoardView)
            view.sendSubviewToBack(oppBoardView)
        }
    }
    
    
    
    //MARK: turn flow
    
    func startTurnFlow(completionHandler: @escaping () -> Void){
        var oppMove = -100
        self.dbRef.child(self.room_id).child("last_move").getData { (error, snapshot) in
            if let error = error{
                print("error")
            }
            else if snapshot.exists(){
                oppMove = ((snapshot.value) as? Int) ?? -100
                print("oppmove: \(oppMove)")
                if oppMove != -100 && oppMove != -1{
                    self.processOppMove(oppMove)
                }
                
                if (self.my_2_count == 0 && self.my_3_count == 0 && self.my_E_count == 0 && self.my_4_count == 0 && self.my_5_count == 0){
                    self.isGameOver = true
                    self.winner = self.is_host
                    DispatchQueue.main.async {
                        self.resignTurn()
                        self.gameOver(winner: self.winner)
                    }
                    
                    //self.gameOver(winner: self.winner)
                    
                } else {
                    DispatchQueue.main.async {
                        completionHandler()
                    }
                }
            }
            else{
                print()
            }
        
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            if self.isGameOver {
//                self.resignTurn()
//                self.gameOver(winner: self.winner)
//            }
//        }
    }
    
    
    func endTurnFlow(completionHandler: @escaping () -> Void){
        var myMove = -100
        self.dbRef.child(self.room_id).child("last_move").getData { (error, snapshot) in
            if let error = error{
                print("error")
            }
            else if snapshot.exists(){
                myMove = ((snapshot.value) as? Int) ?? -100
                print("myMove: \(myMove)")
                if myMove != -100 && myMove != -1{
//                if myMove != -100 {
                    self.processMyMove(myMove)
                }
                
                if (self.opp_2_count == 0 && self.opp_3_count == 0 && self.opp_E_count == 0 && self.opp_4_count == 0 && self.opp_5_count == 0){
                    self.isGameOver = true
                    if self.is_host == 0{
                        self.winner = 1
                    }
                    else if self.is_host == 1{
                        self.winner = 0
                    }
                    // self.gameOver(winner: self.winner)
                    DispatchQueue.main.async {
                        self.resignTurn()
                        self.gameOver(winner: self.winner)
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        completionHandler()
                    }
                }
            }
            else{
                print()
            }
        
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            if self.isGameOver {
//                self.resignTurn()
//                self.gameOver(winner: self.winner)
//            }
//        }
        
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
    
    func getMyMove() -> Int{
        let temp = tappedCell
        self.tappedCell = -100
        return temp
    }

    
    func processOppMove(_ move: Int){
        let checkMove = self.my_board[self.my_board.index(my_board.startIndex, offsetBy: move)]
        if checkMove != "x"{
            //hit!
            self.wasHit = true
            self.wasHitAt = move
            self.shipWasHit = fakeship
            self.shipWasHit.name = "\(checkMove)"
            
            if checkMove == "E"{
                
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
            self.wasMissed = true
            self.wasMissedAt = move
            self.shipWasMissed = fakeship
            self.shipWasMissed.name = "\(checkMove)"
            print("miss")
            //Update board string
            //mark an x on the board where opp missed
        }
    }
    
    func processMyMove(_ move: Int){
        print("TASTES LIKE MY MOVE")
        let checkMove = self.opp_board[self.opp_board.index(opp_board.startIndex, offsetBy: move)]
        print(checkMove)
        if checkMove != "x"{
            //hit!
            if checkMove == "E"{
                opp_E_count -= 1
                if (opp_E_count == 0)
                {
                    self.textToDisplay = "You Sunk Their \(self.getFullName(name: String(checkMove)))!"
                    
                    print("sunk ship E")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH SUNK
                }
                else
                {
                    self.textToDisplay = "You Hit!"
                    
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
                    self.textToDisplay = "You Sunk Their \(self.getFullName(name: String(checkMove)))!"
                    
                    print   ("sunk ship 3")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH SUNK
                }
                else
                {
                    self.textToDisplay = "You Hit!"
                
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
                    self.textToDisplay = "You Sunk Their \(self.getFullName(name: String(checkMove)))!"

                    print("sunk ship 2")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH SUNK
                }
                else
                {
                    self.textToDisplay = "You Hit!"
                    
                    print("hit ship 2")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH HIT
                }
            }
            else if checkMove == "4"{
                
                opp_4_count -= 1
                
                if (opp_4_count == 0)
                {
                    self.textToDisplay = "You Sunk Their \(self.getFullName(name: String(checkMove)))!"
                    
                    print("sunk ship 4")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH SUNK
                }
                else
                {
                    self.textToDisplay = "You Hit!"
                    
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
                    self.textToDisplay = "You Sunk Their \(self.getFullName(name: String(checkMove)))!"
                
                    print("sunk ship 5")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH SUNK
                }
                else
                {
                    self.textToDisplay = "You Hit!"
                    
                    print("hit ship 5")
                    //Update board string
                    //GRAPHICALLY UPDATE BOARD WITH HIT
                }
            }
        }
        else //did not hit
        {
            self.textToDisplay = "You Missed!"
            
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
        if self.tappedCell != -100{
            oppCellArray[self.tappedCell].firedAt()
            self.makeMoveButton.isHidden = true
            
            let turn = ["cur_player": is_host]
            let gameUpdates = ["turn": turn, "last_move": self.tappedCell] as [String : Any]
            
//            dbRef.child(room_id).child("last_move").setValue(self.tappedCell)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
//                self.endTurnFlow()
//
//            }
//            dbRef.child(room_id).child("turn").child("cur_player").setValue(is_host)

            dbRef.child(room_id).updateChildValues(gameUpdates) { error, dbRef in
//                DispatchQueue.main.async {
                    self.endTurnFlow() {
                        self.hitOrMissLabel.text = self.textToDisplay
                        self.hitOrMissLabel.isHidden = false
                    }
//                }
            }

        }
    }
    
    func updateBoardView(){
        
        // write some sort of iteration here that will iteratively read the correct board and update the view controller accordingly. still doing research on how to properly detect screen sizes and everything, but this is likely how we will create most of the board
    
        return
    
    }
    
    func runGame(){
        return
    }
    
    func initialSetup(cur_player: Int?, completionHandler: @escaping () -> Void) {
        print("GOT TO INITIAL SETUP!")
        
        var board_n = ""
        if (self.is_host == 0) {
            board_n = "board_0"
        } else {
            board_n = "board_1"
        }
        
        if (self.not_both_in && self.cur_player == -1 && (cur_player ?? 0) == 0) {
//            self.not_both_in = false
            print("Join to Your")
            self.dbRef.child(self.room_id).child(board_n).getData { (error, snapshot) in
                if let error = error {
                    print("Error getting data \(error)")
                } else if snapshot.exists() {
                    if self.opp_board == "" {
                        self.opp_board = ((snapshot.value) as? String) ?? ""
                        print("not host: opp board after wait")
                        print(self.opp_board)
                        DispatchQueue.main.async {
                            completionHandler()
                        }
                    }
                } else {
                    print("No data available")
                }
            }
        } else {
            print("GOT TO ELSE 859")
            DispatchQueue.main.async {
                completionHandler()
            }
            
        }
    }


}


extension GameViewController {
    
    //MARK: TouchesBegan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{
            return
        }
        
        if self.isGameOver{
            return
        }
        if oppBoardView.isHidden{
            return
        }
        else if myBoardView.isHidden == false{
            return
        }
        if !oppBoardView.bounds.contains(touch.location(in: oppBoardView)){
            makeMoveButton.isHidden = true
            return
        }
        for cell in oppCellArray{
            if cell.bounds.contains(touch.location(in: cell)){
                if cell.hasBeenHit == true{
                    self.tappedCell = -100
                    return
                }
                cell.tapped = true
                cell.makeTapped()
                tappedCell = cell.IDNum
                makeMoveButton.isHidden = false
            }
            else{
                if cell.hasBeenHit{
                    continue
                }
                else{
                    if tappedCell == cell.IDNum{
                        tappedCell = -100
                        makeMoveButton.isHidden = true
                    }
                    cell.tapped = false
                    cell.undoTapped()
                }
            }
            
        }
        
        
        
        
    }
}
