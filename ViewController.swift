//
//  ViewController.swift
//  Concentration
//
//  Created by MacOS on 27.09.2020.
//  Copyright © 2020 DenDeveloper. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    lazy var game = Concentration(numberOfPairsOfCards: cardButtons.count )
        
    
    
    var flipCount = 0 {
        didSet { // наблюдатель свойства
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
        
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Карта не обнаружена")
        }
        
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 0) : #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            }
        }
    }
    var emojiChoice = ["💩", "🤪", "🤮", "🙀", "😈", "😷", "👀","🧠","☀️","🤬","🙈","🍾"]
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoice.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoice.count)))
                emoji[card.identifier] = emojiChoice.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
}
               
    
    


