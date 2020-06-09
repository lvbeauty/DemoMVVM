//
//  NetworkManager.swift
//  Service_Demo
//
//  Created by Tong Yi on 5/28/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import UIKit

class Service
{
    static let shared = Service()
    static var dataSource = [Items]()
    
    private init() {}
    
    private let url = URL(string: "https://www.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1")
   
    func fatchData(completeHandler: @escaping ([Items]?) -> Void)
    {
        guard let url = url else { return }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url)
        {(data, response, error) in
            if error != nil
            {
                print(error!.localizedDescription)
            }
            else
            {
                let httpResponse = response as! HTTPURLResponse
                print("response status code: \(httpResponse.statusCode)")
                
                guard let data = data else { return }
                
                do
                {
                    let json = try JSONDecoder().decode(Flickr.self, from: data)
                    completeHandler(json.items)
                }
                catch
                {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
