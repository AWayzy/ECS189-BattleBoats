//
//  SetShipsViewController.swift
//  BattleBoats
//
//  Created by Austin Way on 2/28/21.
//

import UIKit

class SetShipsViewController: UIViewController {
    
    
    @IBOutlet weak var boardView: UIView!
    
    @IBOutlet weak var lengthFiveShip: UIImageView!
    @IBOutlet weak var lengthFourShip: UIImageView!
    @IBOutlet weak var lengthThreeShip: UIImageView!
    @IBOutlet weak var otherLengthThreeShip: UIImageView!
    @IBOutlet weak var lengthTwoShip: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var setShipsButton: UIButton!
    
    @IBOutlet weak var rotateShipsButton: UIButton!
    
    
    var shipPics: [UIImageView] = []
    var cellArray: [CellUnit] = []
    
    var location = CGPoint(x: 0, y: 0)
    
    private var isDragging = false
    
    var isDone: Int = 0
    
    var touchedShip = UIImageView()
    
    var rotationNumber: Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shipPics = [lengthFiveShip, lengthFourShip, lengthThreeShip, otherLengthThreeShip, lengthTwoShip]
        
        for i in 0...4{
            shipPics[i].isUserInteractionEnabled = false
            shipPics[i].backgroundColor = UIColor.black
        }
        
        doneButton.isHidden = true
        doneButton.backgroundColor = UIColor.green
        doneButton.layer.borderColor = UIColor.green.cgColor
        doneButton.layer.backgroundColor = UIColor.green.cgColor
        
        rotateShipsButton.isHidden = true
        
        
        let sides = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
        let nums = [1,2,3,4,5,6,7,8,9,10]
        
        let cellSide = boardView.bounds.height / 11
        
        lengthFiveShip.frame.size.height = cellSide * 5
        lengthFiveShip.frame.size.width = cellSide
        
        lengthFourShip.frame.size.height = cellSide * 4
        lengthFourShip.frame.size.width = cellSide
        
        lengthThreeShip.frame.size.height = cellSide * 3
        lengthThreeShip.frame.size.width = cellSide
        
        otherLengthThreeShip.frame.size.height = cellSide * 3
        otherLengthThreeShip.frame.size.width = cellSide
        
        lengthTwoShip.frame.size.height = cellSide * 2
        lengthTwoShip.frame.size.width = cellSide
        
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
            return
        }
        else{
        shipPics[isDone + 1].isUserInteractionEnabled = true
        }
        self.isDone = self.isDone + 1
    }
    
    
    @IBAction func pressedDone() {
        setShips()
    }
    
    
    @IBAction func pressedSetShips() {
        doneButton.isHidden = false
        setShipsButton.isHidden = true
        rotateShipsButton.isHidden = false
        shipPics[0].isUserInteractionEnabled = true
        for cell in cellArray{
            cell.isHidden = false
        }
    }
    
    
    @IBAction func pressedRotateShips() {
        shipPics[isDone].transform = CGAffineTransform(rotationAngle: (CGFloat.pi/2)*CGFloat(rotationNumber))
        rotationNumber = rotationNumber + 1
    }
    
}


extension SetShipsViewController {
    
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
    
}


//    let bigBoat = Ship(name: "Big Long Boat", length: 5, orientation: "none", startPoint: [-1000,-1000])
//    let battleBoat = Ship(name: "Battle Boat", length: 4, orientation: "none", startPoint: [-1000,-1000])
//    let speedBoat = Ship(name: "Speed Boat", length: 3, orientation: "none", startPoint: [-1000,-1000])
//    let underwaterBoat = Ship(name: "Under Water Boat", length: 3, orientation: "none", startPoint: [-1000,-1000])
//    let littleBabyBoat = Ship(name: "Little Baby Boat", length: 2, orientation: "none", startPoint: [-1000,-1000])
    
//    let _ = [bigBoat, battleBoat, speedBoat,underwaterBoat, littleBabyBoat]
