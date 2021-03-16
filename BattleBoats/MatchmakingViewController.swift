//
//  MatchmakingViewController.swift
//  BattleBoats
//
//  Created by Dhruva on 3/5/21.
//

import UIKit
import Firebase

class MatchmakingViewController: UIViewController {
    var is_host = 0
    var room_id_number = 0
    var room_id = ""
    
    let dbRef = Database.database().reference()

    @IBOutlet weak var prompt: UILabel!
    
    @IBOutlet weak var subtext: UILabel!
    
    @IBOutlet weak var phoneEntry: UITextField!
    
    @IBOutlet weak var beginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
                overrideUserInterfaceStyle = .light
        }
        
    
        
        if (is_host == 1) {
            
            beginButton.isEnabled = false
            
            dbRef.child("num_games").getData { (error, snapshot) in
                if let error = error {
                    print("Error getting data \(error)")
                } else if snapshot.exists() {
                    var new_game = snapshot.value as? Int
                    new_game? += 1
                    self.room_id_number = new_game ?? 0
                    self.room_id = String(new_game ?? 0)
                    print("Bairn Bairn")
                    print(self.room_id)
                    
                    DispatchQueue.main.async {
                        self.phoneEntry.text = self.room_id
                        self.beginButton.isEnabled = true
                    }
                } else {
                    print("No data available")
                }
            }
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                self.phoneEntry.text = self.room_id
//                self.beginButton.isEnabled = true
//            }
            
        } else {
            prompt.text = "Find a game!"
            subtext.text = "Ask your host for the room ID code."
            phoneEntry.isUserInteractionEnabled = true
            phoneEntry.becomeFirstResponder()
        }
        
        
        
    }
    
    func presentSetupView(is_host: Int, room_id: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let setShipsViewController = storyboard.instantiateViewController(withIdentifier: "setShipsViewController") as? SetShipsViewController else {
            assertionFailure("couldn't find vc")
            
            return
        }
        
        setShipsViewController.modalPresentationStyle = .fullScreen
        setShipsViewController.is_host = is_host
        setShipsViewController.room_id = room_id
        
        self.present(setShipsViewController, animated: true, completion: nil)
    }

    @IBAction func clickBegin(_ sender: Any) {
        if (is_host == 0) {
            var num_errors = 0
            if (phoneEntry.text == "") {
                num_errors = 1
            } else {
                let session = dbRef.child(phoneEntry.text ?? "-1")
                session.getData { (error, snapshot) in
                    if let error = error {
                        print("Error getting data \(error)")
                    } else if snapshot.exists() {
                        session.child("num_players").getData { (error, snapshot) in
                            if let error = error {
                                print("Error getting data \(error)")
                            } else if snapshot.exists() {
                                var new_player = snapshot.value as? Int
                                if (new_player == 2) {
                                    num_errors = 1
                                }
                                new_player? += 1
                                
                                if (num_errors > 0) {
                                    DispatchQueue.main.async {
                                        self.phoneEntry.text = ""
                                        self.subtext.textColor = UIColor.red
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                            self.subtext.textColor = UIColor.white
                                        }
                                    }
                                } else {
                                    DispatchQueue.main.async {
                                        self.room_id = self.phoneEntry.text ?? ""
                                        self.dbRef.child(self.room_id).child("num_players").setValue(2) { error, dbRef in
                                            self.presentSetupView(is_host: 0, room_id: self.room_id)
                                        }
                                    }
                                }
                            } else {
                                print("No data available")
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            num_errors = 1
                            self.phoneEntry.text = ""
                            self.subtext.textColor = UIColor.red
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.subtext.textColor = UIColor.white
                            }
                        }
                    }
                }
            }
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                if (num_errors > 0) {
//                    self.phoneEntry.text = ""
//                    self.subtext.textColor = UIColor.red
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                        self.subtext.textColor = nil
//                    }
//                } else {
//                    self.room_id = self.phoneEntry.text ?? ""
//                    self.dbRef.child(self.room_id).child("num_players").setValue(2)
//                    self.presentSetupView(is_host: 0, room_id: self.room_id)
//                }
//            }
        } else {
            let turn = ["cur_player": -2]
            let game_updates = ["game_over": 0, "last_move": -1, "num_players": 1, "turn": turn] as [String : Any]
            
            
            
//            dbRef.child("num_games").setValue(room_id_number)
//            dbRef.child(room_id).child("turn").child("cur_player").setValue(-2)
//            dbRef.child(room_id).child("last_move").setValue(-1)
//            dbRef.child(room_id).child("num_players").setValue(1)
//            dbRef.child(room_id).child("game_over").setValue(0)
            
            dbRef.updateChildValues(["num_games": room_id_number, room_id: game_updates]) { error, dbRef in
                self.presentSetupView(is_host: 1, room_id: self.room_id)
            }
        }
    }
}
