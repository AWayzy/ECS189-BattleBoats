//
//  SetShipsViewController.swift
//  BattleBoats
//
//  Created by Austin Way on 2/28/21.
//

import UIKit
import Firebase

class SetShipsViewController: UIViewController {
    var is_host = 0
    var room_id = ""
    var cur_player = -69
    var my_board = ""
    var opp_board = ""
    
    let dbRef = Database.database().reference()
    
    @IBOutlet weak var boardView: UIView!
    
   /* @IBOutlet weak var lengthFiveShip: UIImageView!
    @IBOutlet weak var lengthFourShip: UIImageView!
    @IBOutlet weak var lengthThreeShip: UIImageView!
    @IBOutlet weak var otherLengthThreeShip: UIImageView!
    @IBOutlet weak var lengthTwoShip: UIImageView!
    @IBOutlet weak var doneButton: UIButton!*/
    
    @IBOutlet weak var setShipsButton: UIButton!
    
    //@IBOutlet weak var rotateShipsButton: UIButton!
    
    @IBOutlet weak var roomIDLabel: UILabel!
    
    @IBOutlet weak var doneButton: UIButton!
    
    var shipPics: [UIImageView] = []
    var cellArray: [CellUnit] = []
    var shipArray: [ShipUnit] = []
    var location = CGPoint(x: 0, y: 0)
    
    private var isDragging = false
    
    var isDone: Int = 0
    
    var touchedShip = UIImageView()
    
    var rotationNumber: Int = 1
    let shipSizes: [Int] = [5,4,3,3,2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomIDLabel.text = room_id
        
        /*shipPics = [lengthFiveShip, lengthFourShip, lengthThreeShip, otherLengthThreeShip, lengthTwoShip]
        
        for i in 0...4{
            shipPics[i].isUserInteractionEnabled = false
            shipPics[i].backgroundColor = UIColor.black
        }
        
        doneButton.isHidden = true
        doneButton.backgroundColor = UIColor.green
        doneButton.layer.borderColor = UIColor.green.cgColor
        doneButton.layer.backgroundColor = UIColor.green.cgColor
        
        rotateShipsButton.isHidden = true*/
        
        
        let sides = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
        let nums = [1,2,3,4,5,6,7,8,9,10]
        
        let cellSide = boardView.bounds.height / 11
        boardView.clipsToBounds = true
        /*lengthFiveShip.frame.size.height = cellSide * 5
        lengthFiveShip.frame.size.width = cellSide
        
        lengthFourShip.frame.size.height = cellSide * 4
        lengthFourShip.frame.size.width = cellSide
        
        lengthThreeShip.frame.size.height = cellSide * 3
        lengthThreeShip.frame.size.width = cellSide
        
        otherLengthThreeShip.frame.size.height = cellSide * 3
        otherLengthThreeShip.frame.size.width = cellSide
        
        lengthTwoShip.frame.size.height = cellSide * 2
        lengthTwoShip.frame.size.width = cellSide*/
        
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
        for cell in cellArray{
            cell.isHidden = true
        }
        
        shipArray = zip(shipSizes.indices, shipSizes).map{index, shipSize -> ShipUnit in
            let ship = ShipUnit(x: Int(cellSide * CGFloat(index+2)) , y: Int(self.view.bounds.maxY - self.boardView.bounds.maxY), sizeX: Int(cellSide), sizeY: Int(cellSide * CGFloat(shipSize)), color: UIColor.yellow, type: "ship")
            self.view.addSubview(ship)
            return ship
        }
        print(shipArray.count)
        
        
    }
   
   /* func setShips(){
        shipPics[isDone].isUserInteractionEnabled = false
        if isDone == 4{
            doneButton.isUserInteractionEnabled = false
            doneButton.isHidden = true
            return
        }
        else{
        shipPics[isDone + 1].isUserInteractionEnabled = true
        }
        self.isDone = self.isDone + 1
    }
    
    
    @IBAction func pressedDone() {
        setShips()
    }*/
    
    
    @IBAction func pressedSetShips() {
        let rumble = UIImpactFeedbackGenerator(style: .heavy)
        rumble.impactOccurred()
        //doneButton.isHidden = false
        setShipsButton.isHidden = true
       // rotateShipsButton.isHidden = false
      //  shipPics[0].isUserInteractionEnabled = true
        for cell in cellArray{
            cell.isHidden = false
        }
    }
    
    @IBAction func finishSetup() {
        
        // TODO: Parse this from the actual board.
        self.my_board = "543E2xxxxx543E2xxxxx543Exxxxxx54xxxxxxxx5xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        
        dbRef.child(room_id).child("turn").child("cur_player").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            } else if snapshot.exists() {
                var ready_player = snapshot.value as? Int
                ready_player? += 1
                self.cur_player = ready_player ?? -69
                print(self.cur_player)
                
                if (self.cur_player == 0) {
                    if (self.is_host == 0) {
                        self.dbRef.child(self.room_id).child("board_0").getData { (error, snapshot) in
                            if let error = error {
                                print("Error getting data \(error)")
                            } else if snapshot.exists() {
                                self.opp_board = ((snapshot.value) as? String) ?? ""
                                print("not host: opp board onload")
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
                                print("not host: opp board onload")
                                print(self.opp_board)
                            } else {
                                print("No data available")
                            }
                        }
                    }
                }
                
                if (self.is_host == 0) {
                    self.dbRef.child(self.room_id).child("board_1").setValue(self.my_board)
                } else {
                    self.dbRef.child(self.room_id).child("board_0").setValue(self.my_board)
                }
                self.dbRef.child(self.room_id).child("turn").child("cur_player").setValue(ready_player)
            } else {
                print("No data available")
            }
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let gameViewController = storyboard.instantiateViewController(withIdentifier: "gameViewController") as? GameViewController else {
            assertionFailure("couldn't find vc")
            
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            gameViewController.modalPresentationStyle = .fullScreen
            gameViewController.is_host = self.is_host
            gameViewController.room_id = self.room_id
            gameViewController.cur_player = self.cur_player
            gameViewController.my_board = self.my_board
            gameViewController.opp_board = self.opp_board
            // gameViewController.my_board_rep = my_board_rep
            
            // TODO: Take the user to either the Game screen or a waiting page, depending on who won the setup race. Determine this by whether both boards have populated in the DB or not.
        
            self.present(gameViewController, animated: true, completion: nil)
        }
    }
    
   /* @IBAction func pressedRotateShips() {
        shipPics[isDone].transform = CGAffineTransform(rotationAngle: (CGFloat.pi/2)*CGFloat(rotationNumber))
        rotationNumber = rotationNumber + 1
    }*/
    
}


/*extension SetShipsViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{
            return
        }
        touchedShip = UIImageView()
        touchedShip.isUserInteractionEnabled = false
        touchedShip.backgroundColor = UIColor.clear
        
        for ship in shipPics{
            var location = touch.location(in: ship)
            if ship.bounds.contains(location){
                touchedShip = ship
                if touchedShip.isUserInteractionEnabled == false{
                    continue
                }
                else{
                location = touch.location(in: view)
                isDragging = true
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDragging, let touch = touches.first else{
            return
        }
        
        let location = touch.location(in: view)
        touchedShip.frame.origin.x = location.x - (touchedShip.frame.size.width / 2)
        touchedShip.frame.origin.y = location.y - (touchedShip.frame.size.height / 2)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        isDragging = false
        
    }
    
    
    
}*/


//    let bigBoat = Ship(name: "Big Long Boat", length: 5, orientation: "none", startPoint: [-1000,-1000])
//    let battleBoat = Ship(name: "Battle Boat", length: 4, orientation: "none", startPoint: [-1000,-1000])
//    let speedBoat = Ship(name: "Speed Boat", length: 3, orientation: "none", startPoint: [-1000,-1000])
//    let underwaterBoat = Ship(name: "Under Water Boat", length: 3, orientation: "none", startPoint: [-1000,-1000])
//    let littleBabyBoat = Ship(name: "Little Baby Boat", length: 2, orientation: "none", startPoint: [-1000,-1000])
    
//    let _ = [bigBoat, battleBoat, speedBoat,underwaterBoat, littleBabyBoat]
