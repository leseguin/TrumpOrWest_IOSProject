//
//  Game.swift
//  TrumpOrWest
//
//  Created by Léane Seguin on 02/06/2020.
//  Copyright © 2020 Léane Seguin. All rights reserved.
//

import Foundation

public struct Game {
    public var numberOfSentence : Int
    public var point : Int
    public var sentences : [Sentence]
    

    
    public init() {
        numberOfSentence = 0
        sentences = []
        point = 0
    }
    
    public mutating func initGame(){
        var i = 0
        while i < numberOfSentence {
            var sent = Sentence()
            sent.setSentence()
            sentences.append(sent)
            i += 1
        }
    }
    

}
