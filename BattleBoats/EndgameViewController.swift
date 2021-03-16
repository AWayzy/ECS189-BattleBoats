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
    @IBOutlet weak var restartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
                overrideUserInterfaceStyle = .light
        }
        
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
    
    
    @IBAction func backHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let titleViewController = storyboard.instantiateViewController(withIdentifier: "titleViewController") as? TitleViewController else {
            assertionFailure("couldn't find vc")
            
            return
        }
        
        // New navigation controller to redirect back to login page.
        let navigation_controller = UINavigationController(rootViewController: titleViewController)
        // Styling consistent with prior navigation controller.
//        navigationController?.navigationBar.isTranslucent = true
//        navigationController?.navigationBar.prefersLargeTitles = true
        navigation_controller.navigationBar.barTintColor = UIColor.darkGray
        navigation_controller.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigation_controller.modalPresentationStyle = .fullScreen
        self.present(navigation_controller, animated: true, completion: nil)
    }
    
}
