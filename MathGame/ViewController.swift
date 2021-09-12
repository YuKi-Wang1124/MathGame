//
//  ViewController.swift
//  MathGame
//
//  Created by 王昱淇 on 2021/9/11.
//

import UIKit

class ViewController: UIViewController {
 
    @IBOutlet var playerAButtons: [UIButton]!
    @IBOutlet var playerBButtons: [UIButton]!
    @IBOutlet var playerAQuestionLabels: [UILabel]!
    @IBOutlet var playerBQuestionLabels: [UILabel]!
    @IBOutlet weak var playerAScoreLabel: UILabel!
    @IBOutlet weak var playerBScoreLabel: UILabel!
    @IBOutlet weak var playerAQuestionNumberLabel: UILabel!
    @IBOutlet weak var playerBQuestionNumberLabel: UILabel!
    @IBOutlet var operationSymbolImageView: [UIImageView]!
    
    let playerAimageView = UIImageView(frame: CGRect(x: 0, y: 28, width: 414, height: 400))
    let playerBimageView = UIImageView(frame: CGRect(x: 0, y: 465, width: 414, height: 400))
    var playerAscore = 0
    var playerBscore = 0
    var questionindex = 1
    var operationSymbolImageNames = ["plus","minus","multiply","divide"]
    let index = Int.random(in: 0...3)
    var number = 0
    var number1 = 0
    var answerArray = [String]()
    var questionNumberArray = [String]()
    var answer = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transformPlayer()
        changeQuestion()
    }
    
    // transform player direction
    func transformPlayer(){
        for i in 0...1 {
            playerAQuestionLabels[i].transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        for i in 0...3 {
            playerAButtons[i].transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        playerAScoreLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        playerAQuestionNumberLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    
    
    // change question and option
    func changeQuestion() {
        for i in 0...1 {
            operationSymbolImageView[i].image = UIImage(systemName: operationSymbolImageNames[index])
            operationSymbolImageView[i].tintColor = .black
        }
        if operationSymbolImageView[0].image == UIImage(systemName: "plus") {
            number = Int.random(in: 0...99)
            number1 = Int.random(in: 0...9)
            answer = number + number1
            answerArray = ["\(answer)", "\(answer + 2)", "\(answer + 10)", "\(answer + 3)"]
        } else if operationSymbolImageView[0].image == UIImage(systemName: "minus") {
            number = Int.random(in: 10...99)
            number1 = Int.random(in: 1...9)
            answer = number - number1
            answerArray = ["\(answer)", "\(answer + 5)", "\(answer + 10)", "\(answer + 3)"]
            answer = number - number1
        } else if operationSymbolImageView[0].image == UIImage(systemName: "multiply") {
            number = Int.random(in: 0...99)
            number1 = Int.random(in: 0...9)
            answerArray = ["\(number * number1)",
                               "\(number * number1 + 1)",
                               "\(number * number1 + 10)",
                               "\(number * number1 + 2)"]
        } else if operationSymbolImageView[0].image == UIImage(systemName: "divide") {
            number1 = Int.random(in: 1...9)
            number = Int.random(in: 1...99) * number1
            answer = number / number1
            answerArray = ["\(answer)", "\(answer + 1)", "\(answer + 10)", "\(answer + 2)"]
        }
        answerArray.shuffle()
        questionNumberArray = ["\(number)", "\(number1)"]
        for i in 0...1 {
            playerAQuestionLabels[i].text = questionNumberArray[i]
            playerBQuestionLabels[i].text = questionNumberArray[i]
        }
        for i in 0...3 {
            playerAButtons[i].setTitle(answerArray[i], for: .normal)
            playerBButtons[i].setTitle(answerArray[i], for: .normal)
      }
        playerAScoreLabel.text = "score \(playerAscore)"
        playerBScoreLabel.text = "score \(playerBscore)"
        playerAQuestionNumberLabel.text = "\(questionindex) / 10"
        playerBQuestionNumberLabel.text = "\(questionindex) / 10"
    }
    
    
    
    @IBAction func checkPlayerAAnswer(_ sender: UIButton) {
        if sender.currentTitle == String(answer) {
            playerAscore += 10
            questionindex += 1
            changeQuestion()
        }
        if questionindex == 11 {
            showPicture()
        }
    }
    
    @IBAction func checkPlayerBAnswer(_ sender: UIButton) {
        if sender.currentTitle == String(answer) {
            playerBscore += 10
            questionindex += 1
            changeQuestion()
        }
        if questionindex == 11 {
            showPicture()
        }
    }
    
    func showPicture() {
        playerAimageView.isHidden = false
        playerBimageView.isHidden = false
        
        let winImage = UIImage(named: "youWin")
        let loseImage = UIImage(named: "youLose")
        let tieImage = UIImage(named: "tie")
        
        playerAimageView.contentMode = .scaleToFill
        playerAimageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        playerBimageView.contentMode = .scaleToFill
        
        view.addSubview(playerAimageView)
        view.addSubview(playerBimageView)
        if questionindex == 11 {
            if playerAscore > playerBscore {
                playerAimageView.image = winImage
                playerBimageView.image = loseImage
            } else if playerAscore < playerBscore {
                playerAimageView.image = loseImage
                playerBimageView.image = winImage
            } else {
                playerAimageView.image = tieImage
                playerBimageView.image = tieImage
                playerAQuestionNumberLabel.text = "10 / 10"
                playerBQuestionNumberLabel.text = "10 / 10"
            }
        }
    }
       
    @IBAction func replay(_ sender: Any) {
        playerAimageView.isHidden = true
        playerBimageView.isHidden = true
        
        playerAscore = 0
        playerBscore = 0
        questionindex = 1
        
        changeQuestion()
    }
}
