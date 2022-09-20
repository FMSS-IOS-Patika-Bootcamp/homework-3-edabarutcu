//
//  ApiManager.swift
//  Homework3
//
//  Created by detaysoft on 19.09.2022.
//  Copyright © 2022 Eda Barutçu. All rights reserved.
//

import Foundation

class ApiManager {
    
    class func getApiResponse(urlPath: String, completionHandler: @escaping (Data?, Error?) -> Void ) {
        let urlSession = URLSession.shared
        guard let url = URL.init(string: urlPath) else { return }
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            
            if error != nil {
                completionHandler(nil, error)
            } else {
                completionHandler(data, nil)
            }
        }
        task.resume()
    }
}
