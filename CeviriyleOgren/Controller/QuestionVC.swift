//
//  QuestionVC.swift
//  CeviriyleOgren
//
//  Created by Emir Kartal on 4.12.2017.
//  Copyright © 2017 Emir Kartal. All rights reserved.
//

import UIKit
import AVFoundation

class QuestionVC: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerView: UIView!
    @IBOutlet weak var numOfQuesLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    var qId = Int()
    var alamofireElement = AlamofireData()
    var questionArr = [String]()
    var answerArr = [String]()
    var wordArr = [String]()
    var resultArr = [String]()
    var questionSeq = 0
    var wordNum = 0
    var wordCheck = String()
    var backButtonControl = Bool()
    var correctAnswerSeq = 0
    var fiveTimesInRow = 0
    var score = 0
    var changeLanguage = Bool()
    var resultDictionary = [String:Array<Any>]()
    var qSound : AVPlayer!
    var soundArr = [String]()
    var fromWriteVC = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        if fromWriteVC == false {
             changeLanguage ? alamofireElement.getQuestion(qId: qId, fromLang: 1, toLang: 2) : alamofireElement.getQuestion(qId: qId, fromLang: 2, toLang: 1)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        
        if fromWriteVC == false {
            questionArr = alamofireElement.model.questionArr
            answerArr = alamofireElement.model.answerArr
            soundArr = alamofireElement.model.soundArr
        }
        questionLabel.text = questionArr[questionSeq]
        numOfQuesLabel.text = "\(questionSeq + 1)/\(answerArr.count)"
        calculateScore()
        createAnswers()
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        
        deleteButtons()
        questionSeq -= 1
        
        if questionSeq < 0
        {
            alert(header: "Oops!!", text: "You cannot go back anymore", buttonHeader: "I see")
            questionSeq += 1
            createAnswers()
            return
        } else {
            resultArr.removeLast()
        }
        if backButtonControl {
            correctAnswerSeq -= 1
            fiveTimesInRow -= 1
        }
        
        calculateScore()
        wordNum = 0
        answerLabel.text = ""
        wordCheck = ""
        questionLabel.text = questionArr[questionSeq]
        UIView.transition(with: answerView, duration: 0.4, options: [.transitionFlipFromBottom], animations: {
            self.createAnswers()
        })
        numOfQuesLabel.text = "\(questionSeq + 1)/\(answerArr.count)"
    }
    
    @IBAction func resetBtnClicked(_ sender: Any) {
        deleteButtons()
        wordNum = 0
        answerLabel.text = ""
        wordCheck = ""
        createAnswers()
    }
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        
        if questionSeq + 1 == questionArr.count{
            resultArr.append(answerLabel.text!)
            let alert = UIAlertController(title: "Lecture Is Over", message: "You finished the lecture", preferredStyle: UIAlertControllerStyle.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: { (ok) in
                self.resultDictionary = ["Questions" : self.questionArr , "Answers" : self.answerArr, "Results" : self.resultArr]
                self.performSegue(withIdentifier: "toResultVC", sender: self.resultDictionary)
            })
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if answerArr[questionSeq] == answerLabel.text {
            deleteButtons()
            correctAnswerSeq  += 1
            backButtonControl = true
            fiveTimesInRow += 1
        }else {
            backButtonControl = false
            deleteButtons()
            fiveTimesInRow = 0
        }
        
        if fiveTimesInRow % 5 == 0 && fiveTimesInRow != 0 {
            alert(header: "Woww", text: "Five times in a row", buttonHeader: "Kipps;)")
            fiveTimesInRow = 0
        }
        
        questionSeq += 1
        numOfQuesLabel.text = "\(questionSeq + 1)/\(answerArr.count)"
        wordNum = 0
        resultArr.append(answerLabel.text!)
        answerLabel.text = ""
        wordCheck = ""
        questionLabel.text = questionArr[questionSeq]
        UIView.transition(with: answerView, duration: 0.4, options: [.transitionFlipFromTop], animations: {
            self.createAnswers()
        })
        calculateScore()
    }
    @IBAction func writeButtonClicked(_ sender: Any) {
        
        let dicToWriteVC = ["QuestionNumber": questionSeq, "QuestionArray" : questionArr, "AnswerArray" : answerArr, "ResultArray" : resultArr, "Score" : score, "ScoreLabel" : scoreLabel.text!, "CorrectAnswerCount" : correctAnswerSeq] as [String : Any]
        performSegue(withIdentifier: "toWriteVC", sender: dicToWriteVC)
        deleteButtons()
    }
    
    @IBAction func soundBtnClicked(_ sender: Any) {
        
        let url = URL(string: "http://ceviriyleogren.bankokuponlar.org\(soundArr[questionSeq])")
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        qSound = AVPlayer(playerItem: playerItem)
        print(url!)
        qSound.play()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func btnPressed (sender: UIButton) {
        
        if wordNum == 0 {
            wordCheck = sender.currentTitle!
            answerLabel.text = wordCheck
            buttonBackgroundChangeByStatus(btn: sender, status: true)
            wordNum += 1
        }else {
            wordCheck = "\(wordCheck) \(sender.currentTitle!)"
            answerLabel.text = wordCheck
            buttonBackgroundChangeByStatus(btn: sender, status: true)
            wordNum += 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResultVC" {
            if let VC = segue.destination as? ResultVC {
                VC.resultDictionary = sender as! [String:Array<String>]
            }
        }
        
        if segue.identifier == "toWriteVC" {
            if let VC = segue.destination as? WriteVC {
                VC.dicFromQuestionVC = sender as! [String:Any]
            }
        }
    }
    
    func createButton (word : String, x : Double , y : Double) {
        
        let originalString: String = word
        let myString: NSString = originalString as NSString
        let sizeWord: CGSize = myString.size(withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18.0)])
        
        let buttonWidth = Double(sizeWord.width) > 80 ? Double(sizeWord.width) + 6 : 80
        let button = UIButton(frame: CGRect(x: x, y: y, width: buttonWidth, height: 30))
        
        button.backgroundColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red:0.83, green:0.83, blue:0.83, alpha:1.0).cgColor
        button.setTitle(word, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(btnPressed), for: .touchUpInside)
        self.answerView.addSubview(button)
        
    }
    
    func buttonBackgroundChangeByStatus(btn : UIButton, status : Bool) {
       
        //playSound(status: true)
        
        UIView.animate(withDuration: 0.5, animations: {
            btn.layer.backgroundColor = UIColor.green.cgColor
        }, completion: {(finished:Bool) in
            btn.isHidden = true
        })
        
    }
    
    func createAnswers() {
        
        let xWidth = answerView.frame.width
        let yHeight = answerView.frame.height
        let sentence = answerArr[questionSeq]
        var x = Double(xWidth / 20)
        var y = Double(yHeight / 20)
        
        wordArr = sentence.components(separatedBy: " ")
        wordArr.shuffle()
        
        for word in wordArr {
            createButton(word: word, x: x , y: y)
            x += Double(xWidth / 3)
            
            if x > Double(xWidth){
                x = Double(xWidth / 20)
                y += Double(yHeight / 8)
            }
        }
    }
    
    func deleteButtons () {
        let subviews = answerView.subviews
        
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
    func calculateScore() {
        score = correctAnswerSeq * 5
        scoreLabel.text = "Score : \(score)"
    }
    
    func alert(header: String, text: String, buttonHeader: String) {
        let alert = UIAlertController(title: header, message: text, preferredStyle: UIAlertControllerStyle.alert)
        let okButton = UIAlertAction(title: buttonHeader, style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
extension Array
{
    mutating func shuffle()
    {
        for _ in 0..<10
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
}
}

