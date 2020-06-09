//
//  MyViewModel.swift
//  Service_Demo
//
//  Created by Tong Yi on 5/29/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import UIKit

//MARK: app data through the View Model
//var viewModel: MyViewModel = MyViewModel(dataSource: dataModel)

class MyViewModel
{
    private static var dataSource = [Items]()
    private static let service = Service.shared
    
//    init(dataSource: [Items]) {
//        self.dataSource = dataSource
//    }
    
    public static func getNumberOfItem() -> Int
    {
        return dataSource.count
    }
    
    public static func getImageTitle(item: Int) -> String
    {
        return dataSource[item].title
    }
    
    public static func getImageAuthor(item: Int) -> String
    {
        return dataSource[item].author
    }
    
    static func setupData(completionHandler: @escaping () -> Void)
    {
        service.fatchData { (data) in
            guard let data = data else { return }
            self.dataSource = data
            completionHandler()
        }
    }
    
    static func loadImage(item: Int, handler: (UIImage?) -> ())
    {
        
        guard let imageUrl = self.dataSource[item].media.imageURL else { return }
        
        do
        {
            let data = try Data(contentsOf: imageUrl)
            guard let image = UIImage(data: data) else { return }
                handler(image)
        }
        catch
        {
            print(error.localizedDescription)
        }
        
    }
    
    
}
