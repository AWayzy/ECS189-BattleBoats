//
//  SetShipsViewController.swift
//  BattleBoats
//
//  Created by Austin Way on 2/28/21.
//

import UIKit
import Firebase

class SetShipsViewController: UIViewController {
    
    //alignment : 35 on either side of board, center y is at - 110
    //view.bounds.minY + 110
    //boardView.bounds.height / 11
    
    let dbRef = Database.database().reference()
    
    //MARK: SETUP
    
    var is_host = 0
    var room_id = ""
    var cur_player = -69
//    var my_board = ""
    var opp_board = ""
    

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var roomIDLabel: UILabel!
    
    @IBOutlet weak var setShipsButton: UIButton!
    
    @IBOutlet weak var rotateShipsButton: UIButton!
    //    @IBOutlet weak var rotateShipsButton: UIButton!
    
    
    var myBoard: String = ""
    
    var countable = true
    
    var lastTouchedShip = Ship(name: "b", length: -1, orientation: "Q", x: 0, y: 0, cellSide: 0)
    
    var shipPics: [Ship] = []
    var cellArray: [CellUnit] = []
    
    var boardView = UIView()
    
    var boardView2 = UIView()
    
    var location = CGPoint(x: 0, y: 0)
    
    private var isDragging = false
    
    var isDone: Int = 0
    
    var touchedShip: Ship = Ship(name: "b", length: -1, orientation: "Q", x: 0, y: 0, cellSide: 0)
    
    var rotationNumber: Int = 1
    
    var theShips: [Ship] = []
    
    var oldLocation: CGPoint = CGPoint(x: 0,y: 0)
    
    var color1: UIColor = UIColor.clear
    
    var isSetting: Bool = false
    
    var cellSide: CGFloat = 0
    
    var didSetAllShips: Bool = false
    
    var cellIDNumber: Int = 0
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        roomIDLabel.text = room_id
//        view.backgroundColor = UIColor.white
        
        boardView = UIView(frame: CGRect(x: 35, y: (view.bounds.height * (0.4)) - ((view.bounds.width - 70)/2), width: view.bounds.width - 70, height: view.bounds.width - 70))
        
        view.addSubview(boardView)
        view.sendSubviewToBack(boardView)
        
        doneButton.isHidden = true
//        doneButton.backgroundColor = UIColor.green
//        doneButton.layer.borderColor = UIColor.green.cgColor
//        doneButton.layer.backgroundColor = UIColor.green.cgColor
        
        rotateShipsButton.isHidden = true
        
        setShipsButton.isUserInteractionEnabled = true
        
        let screenwidth = view.bounds.maxX - view.bounds.minX
        let screenheight = view.bounds.maxY - view.bounds.minY
        let yval = screenheight * (0.69)
        
        
        let bigBoat = Ship(name: "5", length: 5, orientation: "V",x: (screenwidth * 2 / 11) - (screenwidth / 11), y: yval, cellSide: boardView.bounds.height / 11)
        let battleBoat = Ship(name: "4", length: 4, orientation: "V",x: (screenwidth * 4 / 11) - (screenwidth / 11), y: yval, cellSide: boardView.bounds.height / 11)
        let speedBoat = Ship(name: "3", length: 3, orientation: "V",x: (screenwidth * 6 / 11) - (screenwidth / 11), y: yval, cellSide: boardView.bounds.height / 11)
        let underwaterBoat = Ship(name: "E", length: 3, orientation: "V",x: (screenwidth * 8 / 11) - (screenwidth / 11), y: yval, cellSide: boardView.bounds.height / 11)
        let littleBabyBoat = Ship(name: "2", length: 2, orientation: "V",x: (screenwidth * 10 / 11) - (screenwidth / 11), y: yval, cellSide: boardView.bounds.height / 11)
            
        shipPics = [bigBoat, battleBoat, speedBoat,underwaterBoat, littleBabyBoat]
        
        for boat in shipPics{
            view.addSubview(boat)
            boat.backgroundColor = UIColor.gray
        }

        
        
        let sides = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
        let nums = [1,2,3,4,5,6,7,8,9,10]
        
        cellSide = boardView.bounds.height / 11
        
        color1 = UIColor(red: 0, green: 94, blue: 184, alpha: 1.0)

        
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
                    txtField.textColor = UIColor.black
                    let txtField2: UITextField = UITextField(frame: CGRect(x: CGFloat(col) + cellSide, y: CGFloat(row), width: cellSide, height: cellSide))
                    for i in 0...9{
                        if(col == Int(cellSide) * i){
                            txtField2.text = sides[i]
                        }
                    }
                    txtField2.textAlignment = .center
                    txtField2.backgroundColor = UIColor.clear
                    txtField2.isUserInteractionEnabled = false
                    txtField2.textColor = UIColor.black
                    self.boardView.addSubview(txtField)
                    self.boardView2.addSubview(txtField2)
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
                    txtField.textColor = UIColor.black
                    let txtField2: UITextField = UITextField(frame: CGRect(x: CGFloat(col), y: CGFloat(CGFloat(row) + cellSide), width: cellSide, height: cellSide))
                    for i in 0...9{
                        if(row == Int(cellSide) * i){
                            txtField2.text = String(nums[i])
                        }
                    }
                    txtField2.textAlignment = .center
                    txtField2.backgroundColor = UIColor.clear
                    txtField2.isUserInteractionEnabled = false
                    txtField2.textColor = UIColor.black
                    self.boardView.addSubview(txtField)
                    self.boardView2.addSubview(txtField2)
                }
                else{
                    bothelse = bothelse + 1
                }
                if bothelse == 2{
                    let cellUnit = CellUnit(x: col, y: row , size: Int(cellSide), color: color1, type: "cell", ID: self.cellIDNumber)
                    let cellUnit2 = CellUnit(x: col, y: row , size: Int(cellSide), color: color1, type: "cell", ID: self.cellIDNumber)
                    self.boardView.addSubview(cellUnit)
                    self.boardView2.addSubview(cellUnit2)
                    self.cellArray.append(cellUnit)
                    self.cellIDNumber += 1
                }
            }
        
        }
        for cell in cellArray{
            cell.isHidden = true
        }
    }
    
    func printBoardRep(){
        var board_rep_array = Array(repeating: Array(repeating: "x", count: 10), count: 10)
        var cacount = 0
        for i in 0...cellArray.count - 1{
            let cell = cellArray[i]
            if cell.contains != []{
                myBoard.append(cell.contains[0].name)
                board_rep_array[i/10][i%10] = cell.contains[0].name
            }
            else{
                myBoard.append("x")
                board_rep_array[i/10][i%10] = "x"
            }
        }
        print("Board Rep Array")
        for i in 0...9{
                print(board_rep_array[i])
            }
            print("\n")
        }
    
    
    func setAllCellsBackBlue(){
        for i in 0...cellArray.count - 1{
            cellArray[i].backgroundColor = color1
            cellArray[i].setNeedsDisplay()
        }
    }
    
    //MARK: SetShips
    
    
    
    @IBAction func pressedDone(_ sender: Any) {
        var cacount = 0
        for i in 0...cellArray.count - 1{
            if cellArray[i].contains != []{
                cacount += 1
            }
        }
        if cacount != 17{
            for ship in shipPics{
                if ship.orientation == "H"{
                    self.lastTouchedShip = ship
                    self.pressedRotateShips(self)
                }
                ship.frame.origin.x = ship.originx
                ship.frame.origin.y = ship.originy
                ship.backgroundColor = UIColor.gray
                ship.alpha = 1.0
                ship.setIsInBounds(isIn: false)
            }
            doneButton.isUserInteractionEnabled = false
            doneButton.alpha = 0.25
            
            for i in 0...cellArray.count - 1{
                if cellArray[i].contains != []{
                    cellArray[i].contains = []
                    cellArray[i].isCenterCell = false
                    cellArray[i].color = color1
                    cellArray[i].setNeedsDisplay()
                }
            }
            return
        }
        for ship in shipPics{
            if ship.isInBounds == false{
                return
            }
        }
        
        
        printBoardRep()
        
        dbRef.child(room_id).child("turn").child("cur_player").getData { (error, snapshot) in
                if let error = error {
                    print("Error getting data \(error)")
                } else if snapshot.exists() {
                    var ready_player = snapshot.value as? Int
                    ready_player? += 1
                    self.cur_player = ready_player ?? -69
                    print(self.cur_player)
                    
                    var board_n = ""
                    if (self.is_host == 0) {
                        board_n = "board_1"
                    } else {
                        board_n = "board_0"
                    }
                    
                    let turn = ["cur_player": ready_player]
                    let game_updates = [board_n: self.myBoard, "turn": turn] as [String : Any]
                    
                    if (self.cur_player == 0) {
                        if (self.is_host == 0) {
                            self.dbRef.child(self.room_id).child("board_0").getData { (error, snapshot) in
                                if let error = error {
                                    print("Error getting data \(error)")
                                } else if snapshot.exists() {
                                    self.opp_board = ((snapshot.value) as? String) ?? ""
                                    print("not host: opp board onload")
                                    print(self.opp_board)
                                    
                                    self.dbRef.child(self.room_id).updateChildValues(game_updates) { error, dbRef in
                                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                        guard let gameViewController = storyboard.instantiateViewController(withIdentifier: "gameViewController") as? GameViewController else {
                                            assertionFailure("couldn't find vc")
                                            
                                            return
                                        }
                                        
                                        gameViewController.modalPresentationStyle = .fullScreen
                                        gameViewController.is_host = self.is_host
                                        gameViewController.room_id = self.room_id
                                        gameViewController.cur_player = self.cur_player
                                        gameViewController.my_board = self.myBoard
                                        gameViewController.boardView = self.boardView
                                        gameViewController.boardView2 = self.boardView2
                                        gameViewController.opp_board = self.opp_board
                                        gameViewController.myCells = self.cellArray
                                        // gameViewController.my_board_rep = my_board_rep
                                        
                                        // TODO: Take the user to either the Game screen or a waiting page, depending on who won the setup race. Determine this by whether both boards have populated in the DB or not.
                                    
                                        self.present(gameViewController, animated: true, completion: nil)
                                    }
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
                                    
                                    self.dbRef.child(self.room_id).updateChildValues(game_updates) { error, dbRef in
                                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                        guard let gameViewController = storyboard.instantiateViewController(withIdentifier: "gameViewController") as? GameViewController else {
                                            assertionFailure("couldn't find vc")
                                            
                                            return
                                        }
                                        
                                        gameViewController.modalPresentationStyle = .fullScreen
                                        gameViewController.is_host = self.is_host
                                        gameViewController.room_id = self.room_id
                                        gameViewController.cur_player = self.cur_player
                                        gameViewController.my_board = self.myBoard
                                        gameViewController.boardView = self.boardView
                                        gameViewController.boardView2 = self.boardView2
                                        gameViewController.opp_board = self.opp_board
                                        gameViewController.myCells = self.cellArray
                                        // gameViewController.my_board_rep = my_board_rep
                                        
                                        // TODO: Take the user to either the Game screen or a waiting page, depending on who won the setup race. Determine this by whether both boards have populated in the DB or not.
                                    
                                        self.present(gameViewController, animated: true, completion: nil)
                                    }
                                } else {
                                    print("No data available")
                                }
                            }
                        }
                    } else {
                        self.dbRef.child(self.room_id).updateChildValues(game_updates) { error, dbRef in
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            guard let gameViewController = storyboard.instantiateViewController(withIdentifier: "gameViewController") as? GameViewController else {
                                assertionFailure("couldn't find vc")
                                
                                return
                            }
                            
                            gameViewController.modalPresentationStyle = .fullScreen
                            gameViewController.is_host = self.is_host
                            gameViewController.room_id = self.room_id
                            gameViewController.cur_player = self.cur_player
                            gameViewController.my_board = self.myBoard
                            gameViewController.boardView = self.boardView
                            gameViewController.boardView2 = self.boardView2
                            gameViewController.opp_board = self.opp_board
                            gameViewController.myCells = self.cellArray
                            // gameViewController.my_board_rep = my_board_rep
                            
                            // TODO: Take the user to either the Game screen or a waiting page, depending on who won the setup race. Determine this by whether both boards have populated in the DB or not.
                        
                            self.present(gameViewController, animated: true, completion: nil)
                        }
                    }
                    

                } else {
                    print("No data available")
                }
            }
    }
    
    
    @IBAction func pressedSetShips(_ sender: Any) {
        let snap = UIImpactFeedbackGenerator(style: .medium)
        snap.impactOccurred()
        doneButton.isHidden = false
        doneButton.alpha = 0.25
        doneButton.isUserInteractionEnabled = false
        setShipsButton.isHidden = true
        rotateShipsButton.isHidden = false
        isSetting = true
        
        for ship in shipPics{
            ship.isUserInteractionEnabled = true
        }
        for cell in cellArray{
            cell.isHidden = false
        }
    }
    
    
    
    @IBAction func pressedRotateShips(_ sender: Any) {
        let snap = UIImpactFeedbackGenerator(style: .medium)
        snap.impactOccurred()
        
        self.lastTouchedShip.transform = CGAffineTransform(rotationAngle: (CGFloat.pi/2)*CGFloat(lastTouchedShip.rotationNumber))
        lastTouchedShip.rotationNumber = lastTouchedShip.rotationNumber + 1
        self.lastTouchedShip.rotate90()
        for i in 0...cellArray.count - 1{
            if cellArray[i].contains == [lastTouchedShip]{
                cellArray[i].contains = []
            }
            cellArray[i].color = color1
            cellArray[i].alpha = 1.0
            cellArray[i].setNeedsDisplay()
        }
    }
    
    
}


extension SetShipsViewController {
    
    //MARK: TouchesBegan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{
            return
        }
        self.isDragging = false
        
        if isSetting == false{
            touchedShip = Ship(name: "b", length: -1, orientation: "Q", x: 0, y: 0, cellSide: 0)
            return
        }
        touchedShip = Ship(name: "b", length: -1, orientation: "Q", x: 0, y: 0, cellSide: 0)
        touchedShip.isUserInteractionEnabled = false
        touchedShip.backgroundColor = UIColor.clear
        
        for ship in shipPics{
            var location = touch.location(in: ship)
            if ship.bounds.contains(location){
                oldLocation = ship.center
                touchedShip = ship
                if touchedShip.isUserInteractionEnabled == false{
                    touchedShip = Ship(name: "b", length: -1, orientation: "Q", x: 0, y: 0, cellSide: 0)
                    return
                }
                else{
                    location = touch.location(in: view)
                    isDragging = true
                }
            }
        }
        
        if touchedShip.name == "b"{
            return
        }
        
        
        for i in 0...cellArray.count - 1{
            if cellArray[i].contains == [touchedShip]{
                cellArray[i].contains = []
            }
        }
        self.lastTouchedShip = touchedShip
    }
    
    //MARK: TouchesMoved
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDragging, let touch = touches.first else{
            return
        }
        if isDragging == false || isSetting == false{
            touchedShip = Ship(name: "b", length: -1, orientation: "Q", x: 0, y: 0, cellSide: 0)
            return
        }
        
        for ship in shipPics{
            var location = touch.location(in: ship)
            if ship.bounds.contains(location){
                oldLocation = ship.center
                touchedShip = ship
                if touchedShip.isUserInteractionEnabled == false{
                    touchedShip = Ship(name: "b", length: -1, orientation: "Q", x: 0, y: 0, cellSide: 0)
                    return
                }
                else{
                    location = touch.location(in: view)
                    isDragging = true
                }
            }
        }
        
        if touchedShip.name == "b"{
            return
        }
        
        if touchedShip != lastTouchedShip{
            touchedShip = lastTouchedShip
        }
        
        var isFull = false
        for i in 0...cellArray.count - 1{
            let currentCell = cellArray[i]
            currentCell.color = color1
            currentCell.alpha = 1.0
            currentCell.setNeedsDisplay()
            if currentCell.contains == [touchedShip]{
                currentCell.contains = []
            }
            else if currentCell.bounds.contains(touch.location(in: currentCell)){
                if currentCell.contains != []{
                    isFull = true
                    touchedShip.alpha = 0.5
                    touchedShip.backgroundColor = UIColor.red
                }
            }
        }
        
        if isFull == false{
            touchedShip.alpha = 1.0
            touchedShip.backgroundColor = UIColor.gray
        }
        
        var isInBounds = true
        
        if boardView.bounds.contains(touch.location(in: view)){
            isInBounds = true
            
        }else{
            isInBounds = false
        }
        let location = touch.location(in: view)
        
        touchedShip.frame.origin.x = location.x - (touchedShip.frame.size.width / 2)
        touchedShip.frame.origin.y = location.y - (touchedShip.frame.size.height / 2)
        
        var length = 0
        if touchedShip.length % 2 == 1{
            length = (touchedShip.length - 1) / 2
        }
        else if touchedShip.length % 2 == 0{
            length = touchedShip.length / 2
        }
        
        var isAny = false
        for ship in shipPics{
            if ship.frame.contains(location){
                isAny = true
                touchedShip.backgroundColor = UIColor.red
                touchedShip.alpha = 0.5
            }
            else{
                if isAny == false{
                    touchedShip.backgroundColor = UIColor.gray
                    touchedShip.alpha = 1.0
                }
            }
        }
        if isAny == false{
            touchedShip.backgroundColor = UIColor.gray
            touchedShip.alpha = 1.0
        }
        
        for i in 0...cellArray.count - 1{
            
            let currentCell = cellArray[i]
            currentCell.color = UIColor.yellow
            currentCell.setNeedsDisplay()
            let location = touch.location(in: currentCell)
            if currentCell.bounds.contains(location){
                isInBounds = true
                if touchedShip.orientation == "H"{
                    if Float(currentCell.col) < Float(cellSide) * Float(length) || Float(currentCell.col) > Float(cellSide) * Float(10 - length){
                        touchedShip.alpha = 0.5
                        touchedShip.backgroundColor = UIColor.red
                    }
                    else{
                        if touchedShip.length % 2 == 0{
                            let lengthFront = length
                            let lengthBack = length - 1
                            touchedShip.alpha = 1.0
                            touchedShip.backgroundColor = UIColor.gray
                            let arrays_to_change = cellArray[(i - lengthFront)...(i + lengthBack)]
                            for item in arrays_to_change{
                                item.color = UIColor.yellow
                                item.setNeedsDisplay()
                            }
                        }
                        else{
                            touchedShip.alpha = 1.0
                            touchedShip.backgroundColor = UIColor.gray
                            let arrays_to_change = cellArray[(i - length)...(i + length)]
                            for item in arrays_to_change{
                                item.color = UIColor.yellow
                                item.setNeedsDisplay()
                            }
                        }
                    return
                    }
                }
                else if touchedShip.orientation == "V"{
                    if Float(currentCell.row) < (Float(cellSide) * Float(length)) || Float(currentCell.row) > (Float(cellSide) * Float(10 - length)){
                        touchedShip.alpha = 0.5
                        touchedShip.backgroundColor = UIColor.red
                    }
                    else{
                        touchedShip.alpha = 1.0
                        touchedShip.backgroundColor = UIColor.gray
                        for x in 0...(cellArray.count - 1){
                            let cell = cellArray[x]
                            if cell.col == currentCell.col{
                                if touchedShip.length % 2 == 0{
                                    if cell.row >= (currentCell.row - Int(cellSide) * length) && cell.row < (currentCell.row + Int(cellSide) * length){
                                        cell.color = UIColor.yellow
                                        cell.setNeedsDisplay()
                                    }
                                }else{
                                    if cell.row >= (currentCell.row - Int(cellSide) * length) && cell.row <= (currentCell.row + Int(cellSide) * length){
                                        cell.color = UIColor.yellow
                                        cell.setNeedsDisplay()
                                        }
                            }
                    }
                }
            }
                    return
        }
    } else{
        currentCell.color = color1
        currentCell.alpha = 1.0
        currentCell.setNeedsDisplay()
        }
    }
        
        if !isInBounds{
            doneButton.alpha = 0.25
            doneButton.isUserInteractionEnabled = false
            touchedShip.isInBounds = false
            touchedShip.backgroundColor = UIColor.red
            touchedShip.alpha = 0.5
        }
        
        self.lastTouchedShip = touchedShip

        
    }
    
    
    //MARK: TouchesEnded
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for i in 0...cellArray.count - 1{
            cellArray[i].backgroundColor = color1
            cellArray[i].setNeedsDisplay()
            if cellArray[i].contains == [touchedShip]{
                cellArray[i].contains = []
            }
        }
        guard let touch = touches.first else{
            return
        }
        
        for ship in shipPics{
            var location = touch.location(in: ship)
            if ship.bounds.contains(location){
                oldLocation = ship.center
                touchedShip = ship
                if touchedShip.isUserInteractionEnabled == false{
                    touchedShip = Ship(name: "b", length: -1, orientation: "Q", x: 0, y: 0, cellSide: 0)
                    return
                }
                else{
                location = touch.location(in: view)
                isDragging = true
                }
            }
        }
        if touchedShip.name == "b"{
            return
        }
        
        
        if touchedShip.backgroundColor == UIColor.red{
            countable = false
            if touchedShip.orientation == "H"{
                self.pressedRotateShips(self)
            }
            for i in 0...cellArray.count - 1{
                if cellArray[i].contains == [touchedShip]{
                    cellArray[i].contains = []
                }
            }
            touchedShip.frame.origin.x = touchedShip.originx
            touchedShip.frame.origin.y = touchedShip.originy
            touchedShip.backgroundColor = UIColor.gray
            touchedShip.alpha = 1.0
            touchedShip.setIsInBounds(isIn: false)
            for i in 0...cellArray.count - 1{
                cellArray[i].color = color1
                cellArray[i].setNeedsDisplay()
            }
            isDragging = false
            return
        }
        
        else if touchedShip.backgroundColor == UIColor.gray{
            for i in 0...cellArray.count - 1{
                if cellArray[i].contains == [touchedShip]{
                    cellArray[i].contains = []
                }
            }
            let snap = UIImpactFeedbackGenerator(style: .medium)
            snap.impactOccurred()
            countable = true
            touchedShip.setIsInBounds(isIn: true)
            var length = 0
            if touchedShip.length % 2 == 1{
                length = (touchedShip.length - 1) / 2
            }
            else if touchedShip.length % 2 == 0{
                length = touchedShip.length / 2
            }
            
            var doAnyCellsContain = false
            
            for i in 0...cellArray.count - 1{
                let cell = cellArray[i]
                cell.backgroundColor = color1
                cell.setNeedsDisplay()
                if touchedShip.orientation == "V"{
                    if cell.bounds.contains(touch.location(in: cell)){
                        cell.isCenterCell = true
                        if cell.contains != []{
                            doAnyCellsContain = true
                            touchedShip.backgroundColor = UIColor.red
                            touchedShip.alpha = 0.5
                        }

                        if touchedShip.length % 2 == 0{
                            let shipTop = length
                            let shipBottom = length - 1
                            for x in 1...shipTop{
                                if cellArray[i - (10*x)].contains != []{
                                    doAnyCellsContain = true
                                    touchedShip.backgroundColor = UIColor.red
                                    touchedShip.alpha = 0.5
                                }
                                cellArray[i - (10*x)].contains.append(touchedShip)
                            }
                            if shipBottom == 0{
                            }
                            else{
                                for x in 1...shipBottom{
                                    if cellArray[i + (10*x)].contains != []{
                                        doAnyCellsContain = true
                                        touchedShip.backgroundColor = UIColor.red
                                        touchedShip.alpha = 0.5
                                    }
                                    cellArray[i + (10*x)].contains.append(touchedShip)
                                }
                            }
                        }
                        // ODD SHIP VERTICAL
                        else{
                            for x in 1...length{
                                if cellArray[i - (10*x)].contains != []{
                                    doAnyCellsContain = true
                                    touchedShip.backgroundColor = UIColor.red
                                    touchedShip.alpha = 0.5
                                }
                                if cellArray[i + (10*x)].contains != []{
                                    doAnyCellsContain = true
                                    touchedShip.backgroundColor = UIColor.red
                                    touchedShip.alpha = 0.5
                                }
                                cellArray[i - (10*x)].contains.append(touchedShip)
                                cellArray[i + (10*x)].contains.append(touchedShip)
                            }
                        }
                        
                        cell.contains.append(touchedShip)
                        
                        if doAnyCellsContain == true{
                            for i in 0...cellArray.count - 1{
                                if cellArray[i].contains == [touchedShip]{
                                    cellArray[i].contains = []
                                }
                            }
                            
                            touchedShip.frame.origin.x = touchedShip.originx
                            touchedShip.frame.origin.y = touchedShip.originy
                            touchedShip.backgroundColor = UIColor.gray
                            touchedShip.alpha = 1.0
                            touchedShip.setIsInBounds(isIn: false)
                            
                            for i in 0...cellArray.count - 1{
                                cellArray[i].color = color1
                                cellArray[i].setNeedsDisplay()
                            }
                            isDragging = false
                            return
                        }
                        
                        let frame = view.convert(cell.frame, from: boardView)
                        touchedShip.frame.origin.x = frame.minX
                        touchedShip.frame.origin.y = frame.minY - (CGFloat(length) * cellSide)
                        
                        return
                    }
                    
                    else{
                        cell.isCenterCell = false
                        if cell.contains == [touchedShip]{
                            cell.contains = []
                        }
                        
                    }
                }
                else if touchedShip.orientation == "H"{
                    if cell.bounds.contains(touch.location(in: cell)){
                        cell.isCenterCell = true
                        if cell.contains != []{
                            doAnyCellsContain = true
                            touchedShip.backgroundColor = UIColor.red
                            touchedShip.alpha = 0.5
                        }
            
                        if touchedShip.length % 2 == 0{
                            let shipLeft = length
                            let shipRight = length - 1
                            for x in 1...shipLeft{
                                if cellArray[i - x].contains != []{
                                    doAnyCellsContain = true
                                    touchedShip.backgroundColor = UIColor.red
                                    touchedShip.alpha = 0.5
                                }
                                cellArray[i - x].contains.append(touchedShip)
                            }
                            if shipRight == 0{}
                            else{
                                for x in 1...shipRight{
                                    if cellArray[i + x].contains != []{
                                        doAnyCellsContain = true
                                        touchedShip.backgroundColor = UIColor.red
                                        touchedShip.alpha = 0.5
                                    }
                                    cellArray[i + x].contains.append(touchedShip)
                                }
                            }
                        }
                        // ODD SHIP VERTICAL
                        else{
                            for x in 1...length{
                                if cellArray[i - x].contains != []{
                                    doAnyCellsContain = true
                                    touchedShip.backgroundColor = UIColor.red
                                    touchedShip.alpha = 0.5
                                }
                                if cellArray[i + x].contains != []{
                                    doAnyCellsContain = true
                                    touchedShip.backgroundColor = UIColor.red
                                    touchedShip.alpha = 0.5
                                }
                                cellArray[i - x].contains.append(touchedShip)
                                cellArray[i + x].contains.append(touchedShip)
                            }
                        }
                        
                        cell.contains.append(touchedShip)
                        
                        if doAnyCellsContain == true{
                            for i in 0...cellArray.count - 1{
                                if cellArray[i].contains == [touchedShip]{
                                    cellArray[i].contains = []
                                }
                            }
                            
                            self.pressedRotateShips(self)
                            touchedShip.frame.origin.x = touchedShip.originx
                            touchedShip.frame.origin.y = touchedShip.originy
                            touchedShip.backgroundColor = UIColor.gray
                            touchedShip.alpha = 1.0
                            touchedShip.setIsInBounds(isIn: false)

                            
                            for i in 0...cellArray.count - 1{
                                cellArray[i].color = color1
                                cellArray[i].setNeedsDisplay()
                            }
                            isDragging = false
                            return
                        }
                        
                        let frame = view.convert(cell.frame, from: boardView)
                        touchedShip.frame.origin.x = frame.minX - (CGFloat(length) * cellSide)
                        touchedShip.frame.origin.y = frame.minY
                        

                        return
                    }
                    else{
                        cell.isCenterCell = false
                        if cell.contains == [touchedShip]{
                            cell.contains = []
                        }
                    }
                }
                if countable == false{return}
                var counter = 0
                for ship in shipPics{
                    if ship.isInBounds == true{
                        counter += 1
                    }
                }
                if counter == 5{
                    doneButton.alpha = 1.0
                    doneButton.isUserInteractionEnabled = true
                }
                else{
                    doneButton.alpha = 0.25
                    doneButton.isUserInteractionEnabled = false
                }
            }
            
            if countable == false{
                doneButton.alpha = 0.25
                doneButton.isUserInteractionEnabled = false
            }
            
        }
        
        isDragging = false
        self.setAllCellsBackBlue()
        
        self.lastTouchedShip = touchedShip

        
    }
}

