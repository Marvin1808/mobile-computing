//
//  ViewController.swift
//  NumberGuess
//
//  Created by Philiip Rockenschaub on 23.09.21.
//

import UIKit

class ViewController: UIViewController {

    var model = NumberGuessModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.model.target = Int.random(in: 0..<100)
        print(self.model.target)
        
    }
    
    @IBAction func onTouchUpInside(_ sender: UIButton) {
        
        self.model.guessCounter += 1
        
        if model.isValid(string: self.GuessTextField.text) {
            
            let guess: Int = Int(self.GuessTextField.text!)!
            
            self.model.addGuess(guess: guess)
            
            let compareResult = model.compare(to: guess)
        
            Emoji.image = self.model.getImage(tries: model.guessCounter)
            Emoji.isHidden = compareResult != 0
            self.StatusLabel.text = self.model.getText(compare: compareResult)
            
            
            GuessTextField.resignFirstResponder()
            
        }
        
        return;
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        //TODO: try!!!
        let guess: Int = Int(self.GuessTextField.text!)!
        let compareResult = model.compare(to: guess)
        return compareResult == 0
    }
    
    @IBAction func onTextChange(_ sender: UITextField) {
        
        self.GuessButton.isEnabled = model.isValid(string: sender.text)
        
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let tableViewController = segue.destination as? TableViewController
        
        if let tvc = tableViewController {
            tvc.model = model
        }
    }
    
    @IBOutlet weak var GuessButton: UIButton!
    @IBOutlet weak var StatusLabel: UILabel!
    @IBOutlet weak var GuessTextField: UITextField!
    @IBOutlet weak var Emoji: UIImageView!
}


    
