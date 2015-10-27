//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var letterInput: UITextField!
    
    @IBOutlet var guessedLabel: UILabel!
    
    @IBOutlet var newgameButton: UIButton!
    
    @IBOutlet var guessButton: UIButton!
    
    
    @IBOutlet var startoverButton: UIButton!
    
    var hangman = Hangman()
    
    var imageName : String = "imgs/hangman"
    
    var numTry : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initView()
        guessButton.addTarget(self, action: "guess", forControlEvents:.TouchUpInside)
        newgameButton.addTarget(self, action: "newGame", forControlEvents: .TouchUpInside)
        startoverButton.addTarget(self, action: "startOver", forControlEvents: .TouchUpInside)
    }
    
    
    func initView() {
        let image = UIImage(named: "imgs/hangman1.gif")
        imageView.image = image
        hangman.start()
        NSLog(hangman.answer!)
        letterInput.text = ""
        guessedLabel.text = hangman.guesses()
        guessedLabel.textColor = UIColor.redColor()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func guess() {
        var letter : String = letterInput.text!
        if (letter.characters.count == 1) {
            var guessResult : Bool = hangman.guessLetter(letter)
            if (guessResult) {
                if (hangman.knownString == hangman.answer) {
                    let alert = UIAlertView()
                    alert.title = "You got it"
                    alert.message = "The answer is " + hangman.answer!
                    alert.addButtonWithTitle("Great")
                    initView()
                    alert.show()
                    return
                }
                

            } else {
                numTry++
                if (numTry == 8) {
                    let alert = UIAlertView()
                    alert.title = "You lost"
                    alert.message = "The answer is " + hangman.answer!
                    alert.addButtonWithTitle("Alright")
                    initView()
                    alert.show()
                    
                    return
                }
                updateImage()
            }
            
            guessedLabel.text = hangman.guesses()
        }
        letterInput.text = ""
    }
    
    func updateImage() {
        let image = UIImage(named: imageName + String(numTry) + ".gif")
        imageView.image = image
    }
    
    func newGame() {
        hangman = Hangman()
        numTry = 1
        initView()
    }
    
    func startOver() {
        let image = UIImage(named: "imgs/hangman1.gif")
        imageView.image = image
        letterInput.text = ""
        var answer = hangman.answer
        hangman = Hangman()
        hangman.start()
        hangman.answer = answer
        guessedLabel.text = hangman.guesses()
        guessedLabel.textColor = UIColor.redColor()
    }
}

