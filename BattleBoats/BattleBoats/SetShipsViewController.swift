//
//  SetShipsViewController.swift
//  BattleBoats
//
//  Created by Austin Way on 2/28/21.
//

import UIKit

class SetShipsViewController: UIViewController {
    
    @IBOutlet weak var boardView: UIView!
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var setShipsButton: UIButton!
    
    @IBOutlet weak var rotateShipsButton: UIButton!
    
    
    var shipPics: [Ship] = []
    var cellArray: [CellUnit] = []
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton.isHidden = true
        doneButton.backgroundColor = UIColor.green
        doneButton.layer.borderColor = UIColor.green.cgColor
        doneButton.layer.backgroundColor = UIColor.green.cgColor
        
        rotateShipsButton.isHidden = true
        
        setShipsButton.isUserInteractionEnabled = true
        
        let screenwidth = view.bounds.maxX - view.bounds.minX
        let screenheight = view.bounds.maxY - view.bounds.minY
        let yval = screenheight * (0.69)
        
        
        let bigBoat = Ship(name: "Big Long Boat", length: 5, orientation: "V",x: (screenwidth * 2 / 11) - (screenwidth / 11), y: yval, cellSide: boardView.bounds.height / 11)
        let battleBoat = Ship(name: "Battle Boat", length: 4, orientation: "V",x: (screenwidth * 4 / 11) - (screenwidth / 11), y: yval, cellSide: boardView.bounds.height / 11)
        let speedBoat = Ship(name: "Speed Boat", length: 3, orientation: "V",x: (screenwidth * 6 / 11) - (screenwidth / 11), y: yval, cellSide: boardView.bounds.height / 11)
        let underwaterBoat = Ship(name: "Under Water Boat", length: 3, orientation: "V",x: (screenwidth * 8 / 11) - (screenwidth / 11), y: yval, cellSide: boardView.bounds.height / 11)
        let littleBabyBoat = Ship(name: "Little Baby Boat", length: 2, orientation: "V",x: (screenwidth * 10 / 11) - (screenwidth / 11), y: yval, cellSide: boardView.bounds.height / 11)
            
        shipPics = [bigBoat, battleBoat, speedBoat,underwaterBoat, littleBabyBoat]
        
        for boat in shipPics{
            view.addSubview(boat)
           // view.isUserInteractionEnabled = false
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
                    let cellUnit = CellUnit(x: col, y: row , size: Int(cellSide), color: color1, type: "cell")
                    self.boardView.addSubview(cellUnit)
                    self.cellArray.append(cellUnit)
                }
            }
        
        }
        for cell in cellArray{
            cell.isHidden = true
        }
    }
    
    
    
    func setShips(){
        shipPics[isDone].isUserInteractionEnabled = false
        if isDone == 4{
            doneButton.isUserInteractionEnabled = false
            doneButton.isHidden = true
            isSetting = false
            return
        }
        else{
        shipPics[isDone + 1].isUserInteractionEnabled = true
        }
        self.isDone = self.isDone + 1
    }
    
    
    @IBAction func pressedDone() {
        setShips()
        rotationNumber = 1
        for i in 0...cellArray.count - 1{
            cellArray[i].color = color1
            cellArray[i].alpha = 1.0
            cellArray[i].setNeedsDisplay()
        }
    }
    
    
    @IBAction func pressedSetShips() {
        doneButton.isHidden = false
        setShipsButton.isHidden = true
        rotateShipsButton.isHidden = false
        shipPics[0].isUserInteractionEnabled = true
        isSetting = true
        for cell in cellArray{
            cell.isHidden = false
        }
    }
    
    
    @IBAction func pressedRotateShips() {
        shipPics[isDone].transform = CGAffineTransform(rotationAngle: (CGFloat.pi/2)*CGFloat(rotationNumber))
        rotationNumber = rotationNumber + 1
        shipPics[isDone].rotate90()
        for i in 0...cellArray.count - 1{
            cellArray[i].color = color1
            cellArray[i].alpha = 1.0
            cellArray[i].setNeedsDisplay()
        }
    }
    
}


extension SetShipsViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{
            return
        }
        if isSetting == false{
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
        
        for i in 0...cellArray.count - 1{
            let currentCell = cellArray[i]
            currentCell.color = color1
            currentCell.alpha = 1.0
            currentCell.setNeedsDisplay()
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
        var length = touchedShip.length / 2
        if touchedShip.length % 2 == 1{
            length = (touchedShip.length - 1) / 2
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
                        touchedShip.alpha = 1.0
                        touchedShip.backgroundColor = UIColor.green
                        let arrays_to_change = cellArray[(i - length)...(i + length)]
                        for item in arrays_to_change{
                            item.color = UIColor.yellow
                            item.setNeedsDisplay()
                        }
                        for i in 0...cellArray.count - 1{
                            let cell = cellArray[i]
                            if cell.color != UIColor.yellow && cell.row == currentCell.row{
                                cell.color = UIColor.yellow
                                cell.alpha = 0.25
                                cell.setNeedsDisplay()
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
                        touchedShip.backgroundColor = UIColor.green
                        for x in 0...(cellArray.count - 1){
                            let cell = cellArray[x]
                            if cell.col == currentCell.col{
                                if cell.row > (currentCell.row - Int(cellSide * 3)) && cell.row < (currentCell.row + Int(cellSide * 3)){
                                    cell.color = UIColor.yellow
                                    cell.setNeedsDisplay()
                                }else{
                                    cell.color = UIColor.yellow
                                    cell.alpha = 0.25
                                }
                        }
                    }
                        return
                }
            }
        }
            else{
                currentCell.color = color1
                currentCell.alpha = 1.0
                currentCell.setNeedsDisplay()
            }
        }
        
        if !isInBounds{
            touchedShip.backgroundColor = UIColor.red
            touchedShip.alpha = 0.5
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{
            return
        }
        
        if touchedShip.backgroundColor == UIColor.red{
            touchedShip.frame.origin.x = touchedShip.originx
            touchedShip.frame.origin.y = touchedShip.originy
            touchedShip.backgroundColor = UIColor.green
            touchedShip.alpha = 1.0
            for i in 0...cellArray.count - 1{
                cellArray[i].color = color1
                cellArray[i].setNeedsDisplay()
            }
            isDragging = false
            return
        }
        
        else if touchedShip.backgroundColor == UIColor.green{
            for i in 1...cellArray.count - 1{
                let cell = cellArray[i]
//                if touchedShip.orientation == "V"{
//                    if cell.bounds.contains(touch.location(in: cell)){
//                        touchedShip.frame.origin.x = cell.frame.maxX
//                        touchedShip.frame.origin.y = cell.frame.minY
//
//
//                    }
//                }
//                else if touchedShip.orientation == "H"{
//                    if cell.bounds.contains(touch.location(in: cell)){
//                        touchedShip.center = cell.center
//                    }
//                }
                if touchedShip.orientation == "H"{
                    if cell.bounds.contains(touch.location(in: cell)){
                        touchedShip.frame.origin.x = cell.frame.origin.x - cellSide + (cellSide / 10)
                        touchedShip.frame.origin.y = cell.frame.origin.y + (5 * cellSide) + (cellSide / 10) + (cellSide / 5)

                    }

                }
                else if touchedShip.orientation == "V"{
                    if cell.bounds.contains(touch.location(in: cell)){
                        touchedShip.frame.origin.x = cell.frame.origin.x + cellSide + (cellSide / 9)
                        touchedShip.frame.origin.y = cell.frame.origin.y + (3 * cellSide) + (cellSide / 3)

                    }

                }
            }
        }
        
        isDragging = false
        
    }
    
}

