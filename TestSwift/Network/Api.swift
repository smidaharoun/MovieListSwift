//
//  Api.swift
//  TestSwift
//
//  Created by ODC on 2/8/18.
//  Copyright © 2018 sonic. All rights reserved.
//

import Foundation

class Api {
    static func getMovies(completionHandler: @escaping ([Movie]?, Error?) -> Void) {
        let url = URL(string: "http://www.mocky.io/v2/5915cf73100000470575966f")
        let task = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let data = try jsonDecoder.decode([Movie].self, from: data).sorted(by: { (lhs, rhs) -> Bool in
                        rhs.year ?? 0 > lhs.year ?? 0
                    })
                    completionHandler(data, nil)
                } catch let error as NSError {
                    completionHandler(nil, error)
                }
            } else if let error = error {
                completionHandler(nil, error)
            }
        })
        task.resume()
    }
}
