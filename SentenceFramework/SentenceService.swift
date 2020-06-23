//
//  SentenceService.swift
//  SentenceFramework
//
//  Created by Léane Seguin on 22/06/2020.
//  Copyright © 2020 Léane Seguin. All rights reserved.
//

import Foundation

public class SentenceService{
    
    //private let trumpURL =
    public var trumpMess : TrumpMess
    public var westMess : WestMess
    
    

    
    public init(){
        trumpMess = TrumpMess()
        westMess = WestMess()
    }
    
    private static func createQuoteRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: "https://api.whatdoestrumpthink.com/api/v1/quotes/random")!)
        request.httpMethod = "GET"

        return request
    }
    


    private func createSentenceFromData(data : Data) -> Mess {
        var driver : Mess!
        let decoder = JSONDecoder()
        do {
            driver = try decoder.decode(Mess.self, from: data)
        } catch {
            fatalError("Decodage Failed : \(error)") // Ajouter exception
        }
        return driver
    }
    
    
    public func getQuote( from : String ) -> String{
        if (from == TRUMP) {
            getTrumpSentence()
            return trumpMess.message
        } else {
            getWestSentence()
            return westMess.quote
        }
    }
    
    public func getTrumpSentence(){
        print("la")
        guard let url = URL(string: "https://api.whatdoestrumpthink.com/api/v1/quotes/random")
            else {
                print("error")
                return
        }
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print("error response")
                    return
            }
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                guard jsonResponse is [String: Any] else {
                    return
                }
                var sent : TrumpMess!
                let decoder = JSONDecoder()
                do {
                    sent = try decoder.decode(TrumpMess.self, from: dataResponse)
                } catch {
                    fatalError("Decodage Failed : \(error)") // Ajouter exception
                }
                self.trumpMess = sent
            } catch {
                print(error)
            }
            
        }
        task.resume()
        sleep(1)
    }
    
    
    public func getWestSentence(){
        print("la")
        guard let url = URL(string: "https://api.kanye.rest")
            else {
                print("error")
                return
        }
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print("error response")
                    return
            }
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                guard jsonResponse is [String: Any] else {
                    return
                }
                var sent : WestMess!
                let decoder = JSONDecoder()
                do {
                    sent = try decoder.decode(WestMess.self, from: dataResponse)
                } catch {
                    fatalError("Decodage Failed : \(error)") // Ajouter exception
                }
                self.westMess = sent
            } catch {
                print(error)
            }
            
        }
        task.resume()
        sleep(1)    }
}
