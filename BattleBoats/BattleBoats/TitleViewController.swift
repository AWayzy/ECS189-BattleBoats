//
//  TitleViewController.swift
//  BattleBoats
//
//  Created by Austin Way on 2/28/21.
//

import UIKit

class TitleViewController: UIViewController {
    
    
    @IBOutlet weak var StartGameButton: UIButton!
    @IBOutlet weak var JoinGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()    
    }
    
    func openMatchmaker(is_host: Int, room_id: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let matchmakingViewController = storyboard.instantiateViewController(withIdentifier: "matchmakingViewController") as? MatchmakingViewController else {
            assertionFailure("couldn't find vc")
            
            return
        }
        matchmakingViewController.is_host = is_host
        matchmakingViewController.room_id = room_id
        
        self.navigationController?.pushViewController(matchmakingViewController, animated: true)
    }
    
    
    @IBAction func pressedStartGame() {
        openMatchmaker(is_host: 1, room_id: "")
    }
    
    
    @IBAction func pressedJoinGame() {
        openMatchmaker(is_host: 0, room_id: "")
    }
    
}
