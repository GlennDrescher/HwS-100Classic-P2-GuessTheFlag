//
//  ViewController.swift
//  HwS-100Classic-P2-GuessTheFlag
//
//  Created by Glenn Drescher on 15/10/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var flag1: UIButton!
    @IBOutlet var flag2: UIButton!
    @IBOutlet var flag3: UIButton!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var answeredQuestionsLabel: UILabel!
    var flags: [UIButton] = []
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var answeredQuestions = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "uk", "us"]
        
        flags += [flag1, flag2, flag3]
        for flag in flags {
            flag.layer.borderWidth = 1
            flag.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        askQuestion()
    }
    
    @objc func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        
        var index = 0
        for flag in flags {
            flag.setImage(UIImage(named: countries[index]), for: .normal)
            index += 1
        }
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased()
    }
    
    @objc func resetGame(action: UIAlertAction! = nil) {
        score = 0
        answeredQuestions = 0
        scoreLabel.text = "Your score is \(score)"
        answeredQuestionsLabel.text = "\(answeredQuestions) answered Questions"
        askQuestion()
    }

    @IBAction func flagTapped(_ sender: UIButton) {
        var title: String
        var message: String
        
        if correctAnswer == sender.tag {
            score += 1
            title = "Correct"
            message = "Your score is \(score)"
            
        } else {
            score -= 1
            title = "Wrong"
            message = "That is the flag of \(countries[sender.tag].capitalized). Your score is \(score)"
            
        }
        answeredQuestions += 1
        scoreLabel.text = "Your score is \(score)"
        answeredQuestionsLabel.text = "\(answeredQuestions) answered Questions"

        if answeredQuestions >= 10 {
            let ac = UIAlertController(title: "Game over", message: "You have answered \(answeredQuestions) and got a score of \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart", style: .destructive, handler: resetGame))
            present(ac, animated: true)
            return
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
        
    }
    
}

