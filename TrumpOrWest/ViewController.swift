//
//  ViewController.swift
//  TrumpOrWest
//
//  Created by Léane Seguin on 02/06/2020.
//  Copyright © 2020 Léane Seguin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var numberQuest : Int = 5
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        numberOfQuest.text = "5"
    }
    @IBOutlet weak var numberOfQuest: UITextField!
    
    @IBAction func stepperNumberQuest(_ sender: UIStepper) {
        numberOfQuest.text = String(sender.value)
        numberQuest = Int(sender.value)
    }
    @IBAction func playButton(_ sender: UIButton) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        //var game = Game(numberOfQuestion: numberQuest)
        myVC.numberOfQuestion = numberQuest
        navigationController?.pushViewController(myVC, animated: true)
    }
    
    /*
    @IBAction func playButton(_ sender: UIButton) {
        let vc = DetailViewController()
        vc.numberOfQuestion = numberQuest
        print("ici")
        navigationController?.pushViewController(vc, animated: true)
        print("ici2")
    }
 
 */
}

