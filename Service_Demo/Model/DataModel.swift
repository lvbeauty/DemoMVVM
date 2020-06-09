//
//  DataModel.swift
//  Service_Demo
//
//  Created by Tong Yi on 5/28/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import Foundation

struct Items: Decodable
{
    var title: String
    var author: String
    var media: Media
    
    init(title: String, author: String, media: Media)
    {
        self.title = title
        self.author = author
        self.media = media
    }
}

struct Media: Decodable
{
    var imageURL: URL?
    enum CodingKeys: String, CodingKey
    {
        case imageURL = "m"
    }
}

struct Flickr: Decodable
{
    var items: [Items]
}

//MARK: - Model data
//var dataModel = [Items]()
