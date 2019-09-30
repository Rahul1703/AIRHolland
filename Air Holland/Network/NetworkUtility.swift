//
//  NetworkUtility.swift
//  Air Holland
//
//  Created by Rahul on 30/09/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import UIKit

enum EndPoints : String {
    case EventList = "dummy-response.json"
}

enum RequestMethod : String {
    case GET
    case POST
}

class NetworkUtility: NSObject {
    
    static func getData(endPoint: EndPoints, requestMethod: RequestMethod, parameters: [String : Any]? = nil, successBlock : ((_ eventList: [EventModel]) -> ())!, failure failureBlock : ((_ message: String) -> ())!) {
        
        let session = URLSession.shared
        let url = URL(string: APP_URL + endPoint.rawValue)!
        
        var request = URLRequest(url: url)
        request.httpMethod = requestMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            if error != nil {
                failureBlock("Some error occured.")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    failureBlock("Some error occured.")
                    return
            }
            
            guard let mime = response?.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            
            decodeDataToModel(data!, success: { (list) in
                successBlock(list)
            }) { (message) in
                failureBlock(message)
            }
        })
        
        task.resume()
    }
    
    static func decodeDataToModel(_ data: Data, success: @escaping (([EventModel]) -> ()), failure: ((String) -> ())?) {
        
        let result = try? JSONDecoder().decode([EventModel].self, from: data)
        
        DispatchQueue.main.async {
            
            // success
            if let result = result {
                success(result)
            }
            
            // unable to parse data.
            else if let failure = failure {
                failure("Error in Parsing")
            }
        }
    }
    
}
