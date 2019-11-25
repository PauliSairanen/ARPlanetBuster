//
//  MainViewController.swift
//  ARDicee
//
//  Created by Pauli Sairanen on 11/19/19.
//  Copyright © 2019 Pauli Sairanen. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, SendDataBackToMainViewProtocol {

    var playerName: String = ""
    var list = PlayerScore.getScores()
    var gameHasEnded: Bool = false
    
    @IBOutlet weak var playerNameTextField: UITextField!
    @IBOutlet weak var scoreBoard: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting the delegate and data source for tableView
        self.scoreBoard.delegate = self
        self.scoreBoard.dataSource = self
        
        self.displayScores()
    }
    
    // Get data from another viewController
    func sendDataBackToMainViewController(myData: Bool) {
         self.gameHasEnded = myData
        
        print("Data was received")
        print(gameHasEnded)
        if gameHasEnded == true {
            DispatchQueue.main.async {
                self.updateDisplay()
            }
        }
    }
    
    
    // MARK: __ Seque functions __
    // Passing name from main view to game scene
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is GameViewController {
            let gvc = segue.destination as? GameViewController
            gvc?.playerNameInGame = playerName
            gvc?.delegate = self
        }
    }
    
    // MARK: __ Game related functions __
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
    
    func updateDisplay() {
        print("Update display called")
        list = PlayerScore.getScores()
        scoreBoard.reloadData()
        playerNameTextField.text = ""
    }
    
    // MARK: __ Display scores functions __
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (list?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Iterates through the array to fill the cells
        
        var stringToPass: String = ""
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
       
        if let scoreExists = (list?[indexPath.row].playerScore) {
            let score = scoreExists
            
            if let nameExists = (list?[indexPath.row].playerName) {
                let name = nameExists
                
                stringToPass = "\(name)         Score: \(score)"
            }
        }
    
        cell.textLabel?.text = stringToPass
        return (cell)
    }
    
}

