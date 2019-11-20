//
//  PlayerScore.swift
//  ARDicee
//
//  Created by Pauli Sairanen on 11/20/19.
//  Copyright © 2019 Pauli Sairanen. All rights reserved.
//

import Foundation

class PlayerScore: Codable {
    var playerName : String = ""
    var playerScore : Int = 0
    
    init(name: String, score: Int){
        self.playerName = name
        self.playerScore = score
    }
    
    public static func saveScore(name: String, score: Int) {
        var arrayOfScores = [PlayerScore]()
        arrayOfScores.append(PlayerScore(name: name, score: score))
        let scoreArray = try! JSONEncoder().encode(arrayOfScores)
        UserDefaults.standard.set(scoreArray, forKey: "Score array")
    }
    
    public static func getScores() -> [PlayerScore]? {
        var arrayToReturn : [PlayerScore] = []
        
        // If array exists, return it
        if  let dataFromStorage = UserDefaults.standard.data(forKey: "Score array") {
            let playerScoreArray = try! JSONDecoder().decode([PlayerScore].self, from: dataFromStorage)
            
            // Sort the array descending (From largets to smallest)
            var sortedScoreArray = playerScoreArray.sorted(by: { $0.playerScore > $1.playerScore })
            
            // If array has more than 5 members, remove the last one
            if  sortedScoreArray.count > 5 {
                sortedScoreArray.removeLast()
            }
            // Return the sorted array
            arrayToReturn = sortedScoreArray
        }
        // If no array exits, create it
        else {
            var arrayOfScores = [PlayerScore]()
            let scoreArray = try! JSONEncoder().encode(arrayOfScores)
            UserDefaults.standard.set(scoreArray, forKey: "Score array")
            getScores()
        }
        return arrayToReturn
    }
}
