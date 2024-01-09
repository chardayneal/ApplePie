//
//  ViewController.swift
//  Apple Pie
//
//  Created by Charday Neal on 1/9/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var treeImageView: UIImageView!

    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    //list of words
    var listOfWords = ["buccaneer", "beautiful", "cauliflower", "desperate", "glorious", "fragile", "helicopter", "insidious", "luxury", "microwave", "nightclub", "pajama", "puzzling", "scratch", "syndrome", "unworthy", "jackpot", "bandwagon", "absurd", "compotent"]
    
    let incorrectMovesAllowed = 7
    
    //keep track of wins and losses
    var totalWins = 0 {
        didSet {playNewRound()}
    }
    var totalLosses = 0 {
        didSet{playNewRound()}
    }
    
    var currentGame: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playNewRound()
    }
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        
        currentGame.playerGuessed(letter: letter)
        
        updateGameState()
    }
    
    
    func playNewRound() {
        if !listOfWords.isEmpty {
            listOfWords = listOfWords.shuffled()
            
            let newWord = listOfWords.removeFirst()
            
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        
        
        correctWordLabel.text = wordWithSpacing
        
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    
}

