//
//  Sentence.swift
//  SentenceFramework
//
//  Created by Léane Seguin on 02/06/2020.
//  Copyright © 2020 Léane Seguin. All rights reserved.
//

import Foundation

public let speakers = [TRUMP, WEST]
public let TRUMP = "TRUMP"
public let WEST = "WEST"

private var sentService = SentenceService()

public struct Sentence{
    public var speaker : String
    public var message : String
    
    init(){
        speaker = speakers.randomElement()!
        message = ""
    }
    
    init(sent : Mess){
        speaker = speakers.randomElement()!
        self.message = sent.message
    }
    
    
    public mutating func setSent(mess : Mess){
        self.message = mess.message
    }
    
    public mutating func setSentence(){
        switch speaker {
        case TRUMP:
            message = sentService.getQuote(from: self.speaker)
        default:
            message = sentService.getQuote(from: self.speaker)
        }
    }
}
