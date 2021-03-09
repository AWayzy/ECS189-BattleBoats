//
//  EndgameViewController.swift
//  BattleBoats
//
//  Created by Dhruva on 3/8/21.
//

import UIKit

class EndgameViewController: UIViewController {
    var win = -1

    @IBOutlet weak var WinLossLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (win == 1) {
            WinLossLabel.text = "YOU WON"
        }

        // Do any additional setup after loading the view.
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
