//
//  WriteVC.swift
//  CeviriyleOgren
//
//  Created by Emir Kartal on 30.12.2017.
//  Copyright © 2017 Emir Kartal. All rights reserved.
//

import UIKit

class WriteVC: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var numOfQuestion: UILabel!
    
    var dicFromQuestionVC = [String : Any]()
    var questionSeq = 0
    var questionArray = [String]()
    var answerArray = [String]()
    var resultArray = [String]()
    var score = Int()
    var correctAnswerSeq = Int()
    var backButtonControl = Bool()
    var resultDictionary = [String:Array<Any>]()
    var fiveTimesInRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // change the code of back button in navigation bar. dont forget coredata
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(WriteVC.backBtnClicked))
        self.navigationItem.leftBarButtonItem = backButton
        
        questionSeq = dicFromQuestionVC["QuestionNumber"] as! Int
        questionArray = dicFromQuestionVC["QuestionArray"] as! Array<String>
        answerArray = dicFromQuestionVC["AnswerArray"] as! Array<String>
        resultArray = dicFromQuestionVC["ResultArray"] as! Array<String>
        questionLabel.text = questionArray[questionSeq]
        scoreLabel.text = dicFromQuestionVC["ScoreLabel"] as? String
        score = dicFromQuestionVC["Score"] as! Int
        correctAnswerSeq = dicFromQuestionVC["CorrectAnswerCount"] as! Int
        numOfQuestion.text = "\(questionSeq + 1)/\(answerArray.count)"
        
    }
    @objc func backBtnClicked () {
        
        //self.navigationController?.popViewController(animated: true)
        performSegue(withIdentifier: "toQuestionView", sender: nil)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        if questionSeq + 1 == questionArray.count{
            resultArray.append(answerTextField.text!)
            let alert = UIAlertController(title: "Lecture Is Over", message: "You finished the lecture", preferredStyle: UIAlertControllerStyle.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: { (ok) in
                self.resultDictionary = ["Questions" : self.questionArray , "Answers" : self.answerArray, "Results" : self.resultArray]
                self.performSegue(withIdentifier: "toResultView", sender: self.resultDictionary)
            })
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        var answer : String = answerArray[questionSeq].lowercased()
        answer.remove(at: answer.index(before: answer.endIndex))
        
        
        if answer == answerTextField.text?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) || answerArray[questionSeq].lowercased() == answerTextField.text?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) {
            
            correctAnswerSeq  += 1
            backButtonControl = true
            fiveTimesInRow += 1
        }else {
            backButtonControl = false
            fiveTimesInRow = 0
        }
        
        if fiveTimesInRow % 5 == 0 && fiveTimesInRow != 0 {
            alert(header: "Woww", text: "Five times in a row", buttonHeader: "Kipps;)")
            fiveTimesInRow = 0
        }
        
        questionSeq += 1
        numOfQuestion.text = "\(questionSeq + 1)/\(answerArray.count)"
        resultArray.append(answerTextField.text!)
        answerTextField.text = ""
        questionLabel.text = questionArray[questionSeq]
        calculateScore()
        
    }
    @IBAction func resetButtonClicked(_ sender: Any) {
        answerTextField.text = ""
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
        questionSeq -= 1
        
        if questionSeq < 0
        {
            alert(header: "Oops!!", text: "You cannot go back anymore", buttonHeader: "I see")
            questionSeq += 1
            return
        } else {
            resultArray.removeLast()
        }
        if backButtonControl {
            correctAnswerSeq -= 1
            fiveTimesInRow -= 1
        }
        
        calculateScore()
        answerTextField.text = ""
        questionLabel.text = questionArray[questionSeq]
        numOfQuestion.text = "\(questionSeq + 1)/\(answerArray.count)"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResultView" {
            if let VC = segue.destination as? ResultVC {
                VC.resultDictionary = sender as! [String:Array<String>]
            }
        }
        
        if segue.identifier == "toQuestionView" {
            if let VC = segue.destination as? QuestionVC {
                VC.questionSeq = questionSeq
                VC.questionArr = questionArray
                VC.answerArr = answerArray
                VC.resultArr = resultArray
                VC.score = score
                //VC.scoreLabel.text! = scoreLabel.text!
                VC.correctAnswerSeq = correctAnswerSeq
                VC.fromWriteVC = true
            }
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
}
