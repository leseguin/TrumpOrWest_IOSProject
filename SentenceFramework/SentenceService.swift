//
//  SentenceService.swift
//  SentenceFramework
//
//  Created by Léane Seguin on 22/06/2020.
//  Copyright © 2020 Léane Seguin. All rights reserved.
//

import Foundation

public class SentenceService{
    
    public var trumpMess : TrumpMess
    public var westMess : WestMess
    
    enum ErreurModerator: Error {
        case badURL
        case errorResponse
        case badJsonResponse
        case failedToDecodeJSON
        case failedTask
    }

    
    public init(){
        trumpMess = TrumpMess()
        westMess = WestMess()
    }
    
    
    public func getQuote( from : String ) -> String{
        if (from == TRUMP) {
            getTrumpSentence() { result in
                switch result{
                    case .failure(let error):
                        print(error.localizedDescription)
                        return
                    case .success(let str):
                        print(str)
                }
            }
            return trumpMess.message
        } else {
            getWestSentence() { result in
                switch result{
                    case .failure(let error):
                        print(error.localizedDescription)
                        return
                    case .success(let str):
                        print(str)
                }
            }
            return westMess.quote
        }
    }
    
    func getTrumpSentence( completion: @escaping (Result<Int, ErreurModerator>) -> Void){
        guard let url = URL(string: "https://api.whatdoestrumpthink.com/api/v1/quotes/random")
            else {
                return completion(.failure(.badURL))
        }
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    return completion(.failure(.errorResponse))
            }
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                guard jsonResponse is [String: Any] else {
                    return completion(.failure(.badJsonResponse))
                }
                var sent : TrumpMess!
                let decoder = JSONDecoder()
                do {
                    sent = try decoder.decode(TrumpMess.self, from: dataResponse)
                } catch {
                    return completion(.failure(.failedToDecodeJSON))
                }
                self.trumpMess = sent
            } catch {
                return completion(.failure(.failedTask))
            }
            
        }
        task.resume()
        sleep(1)
    }
    

    
    func getWestSentence(  completion: @escaping (Result<Int, ErreurModerator>) -> Void){
        guard let url = URL(string: "https://api.kanye.rest") //
            else {
                return completion(.failure(.badURL))
        }
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    return completion(.failure(.errorResponse))
            }
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                guard jsonResponse is [String: Any] else {
                    return completion(.failure(.badJsonResponse))
                }
                var sent : WestMess!
                let decoder = JSONDecoder()
                do {
                    sent = try decoder.decode(WestMess.self, from: dataResponse)
                } catch {
                    //fatalError("Decodage Failed : \(error)") // Ajouter exception
                    return completion(.failure(.failedToDecodeJSON))
                }
                self.westMess = sent
            } catch {
                return completion(.failure(.failedTask))
            }
            
        }
        task.resume()
        sleep(1)    }
}
