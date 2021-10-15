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
    var flags: [UIButton] = []
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    
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

    @IBAction func flagTapped(_ sender: UIButton) {
        var title: String
        
        if correctAnswer == sender.tag {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
        
    }
    
}

