//
//  MainViewController.swift
//  ARDicee
//
//  Created by Pauli Sairanen on 11/19/19.
//  Copyright © 2019 Pauli Sairanen. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    
    var playerName: String = ""
    
    @IBOutlet weak var playerNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.displayScores()

    }
    
    // Passing name from main view to game scene
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ViewController
        {
            let vc = segue.destination as? ViewController
            vc?.playerNameInGame = playerName
        }
    }
    
    @IBAction func startGameButton(_ sender: Any) {
        if (playerNameTextField.text?.isEmpty == true) {
            let alert = UIAlertController(title: "Did you give a name??", message: "You need to give your name! 😡", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else {
            playerName = playerNameTextField.text!
            performSegue(withIdentifier: "SequeToGame", sender: self)
        }
    }
    
    func displayScores() {
        let arrayOfScores = PlayerScore.getScores()
         for element in arrayOfScores! {
             print("PlayerName: \(element.playerName) Player score: \(element.playerScore)")
         }
    }
    
    
 
    
}
