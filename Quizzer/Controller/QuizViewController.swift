//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class QuizViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var trueButton: UIButton!
    
    var audioPlayer: AVAudioPlayer?
    
    var quiz = Quiz()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNextQuestion()
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        let userAnswer: Bool = sender.currentTitle == "True" ? true : false
        
        let answeredCorrectly = quiz.checkAnswer(userAnswered: userAnswer)
        
        if answeredCorrectly {
            view.backgroundColor = UIColor.green
            playSound(fileName: "correct")
        }
        else {
            view.backgroundColor = UIColor.red
            playSound(fileName: "incorrect")
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { timer in
            self.showNextQuestion()
        }
        
    }
    
    func showNextQuestion() {
        
        view.backgroundColor = UIColor.systemBlue
        
        if quiz.quizComplete() {
//            let completeView = QuizCompleteViewController()
//            self.present(completeView, animated: true, completion: nil)
            
        }
        else {
            quiz.nextQuestion()
            questionLabel.text = quiz.getQuestion()
            progressBar.progress = quiz.getProgress()
        }
        
        
    }

    func playSound(fileName: String) {
        let file = Bundle.main.url(forResource: fileName, withExtension: "wav")
        audioPlayer = try! AVAudioPlayer(contentsOf: file!)
        audioPlayer!.play()
    }
    
}

