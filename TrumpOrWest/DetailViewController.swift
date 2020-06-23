//
//  DetailViewController.swift
//  TrumpOrWest
//
//  Created by Léane Seguin on 02/06/2020.
//  Copyright © 2020 Léane Seguin. All rights reserved.
//

import UIKit
import SentenceFramework

class DetailViewController: UIViewController {

    public var game : Game = Game()
    private var point = 0
    private var currSentence : Sentence = Sentence()
    private var currentQuestion = 1
    public var numberOfQuestion : Int = 0
    
    private var customView: UIView!

    
    @IBOutlet weak var progressOutlet: UIProgressView!
    
    @IBOutlet weak var scoreOutlet: UILabel!
    
    @IBOutlet weak var sentenceToFind: UILabel!

    @IBAction func trumpAction(_ sender: UIButton) {
        isThis(speaker: TRUMP)
    }

    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "The quote download failed.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func westAction(_ sender: UIButton) {
        isThis(speaker: WEST)
    }
    
    private func isThis(speaker : String){
        if(speaker == currSentence.speaker) {
            itsAWin()
        } else {
            itsALose()
        }
    }


    private func itsAWin(){
        print("Well done")
        point += 1
        scoreOutlet.text = String(point)
        getSentence()
        let ratio = Float(currentQuestion) / Float(numberOfQuestion)
        currentQuestion += 1
        progressOutlet.progress = ratio
    }
    
    private func itsALose(){
        print("To baaad")
        point -= 1
        sentenceToFind.text = "-1"
        scoreOutlet.text = String(point)
        getSentence()
        
        let ratio = Float(currentQuestion) / Float(numberOfQuestion)
        progressOutlet.progress = ratio
        currentQuestion += 1
    }
    
    private func getSentence(){
        if(game.sentences.count > 0) {
            currSentence = game.sentences.remove(at: 0)
            print(game.sentences.count)
            sentenceToFind.text = currSentence.message
        } else {
            print("Game Over")
            gameOver()
           // popupOutlet.isHidden = false
        }
    }
    
    private func gameOver(){
        game.point = point
        disableButton()
        
        if(point < 0){
            sentenceToFind.text = "hum .. yep .. " + String(point) + "points. Too smart ..."
        } else if(point == game.numberOfSentence){
            sentenceToFind.text = "You killed it ! " + String(point) + "points. Well played buddy !"
        } else {
            sentenceToFind.text =  String(point) + "points. You can do better"
        }
        
        
    }
    
    @IBOutlet weak var buttonStack: UIStackView!
    
    private func disableButton(){
        buttonStack.isHidden = true
    }
    
    private func showButtons(){
        buttonStack.isHidden = false
        
    }
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    func putActivityIndicator() {
        indicator.startAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreOutlet.text = String(point)
        game.numberOfSentence = numberOfQuestion
        
        let ratio = Float(point) / Float(numberOfQuestion)
        progressOutlet.progress = ratio
        
        print("init")
        putActivityIndicator()
        disableButton()
        sentenceToFind.text = "Looking for stupidity"
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) { [weak self] in
            
            self?.game.initGame()
            print("end init")
            
            hideActivityIndicator()
            self?.self.getSentence()
            self?.showButtons()
        }
        
        func hideActivityIndicator() {
            indicator.stopAnimating()
        }
        




        
        //let customViewFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 200)
       // customView = UIView(frame: customViewFrame)

//        view.addSubview(customView)

//        customView.isHidden = true
        
        //customView.addSubview()
        //Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
