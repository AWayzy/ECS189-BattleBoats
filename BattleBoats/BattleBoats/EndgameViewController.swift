//
//  EndgameViewController.swift
//  BattleBoats
//
//  Created by Dhruva on 3/8/21.
//

import UIKit
import Firebase

class EndgameViewController: UIViewController {
    var dbRef = Database.database().reference()
    var win = -1
    var room_id = ""

    @IBOutlet weak var WinLossLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (win == 1) {
            WinLossLabel.text = "YOU WON"
        }
        
        self.dbRef.child(self.room_id).child("game_over").getData { (error, snapshot) in
            if let error = error
            {
                print("error getting data \(error)")
            }
            else if snapshot.exists()
            {
                var num_players_notified = snapshot.value as? Int
                if (num_players_notified == 2) {
                    self.dbRef.child(self.room_id).child("turn").removeAllObservers()
                }
                
            }
            else
            {
                print("no data available")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
