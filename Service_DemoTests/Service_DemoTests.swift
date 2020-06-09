//
//  Service_DemoTests.swift
//  Service_DemoTests
//
//  Created by Tong Yi on 6/1/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import XCTest
@testable import Service_Demo

class Service_DemoTests: XCTestCase
{
    var MyCollectionVC: MyCollectionViewController?
    
    override func setUp()
    {
        super.setUp()
    }
    
    override class func tearDown()
    {
        super.tearDown()
    }
    
    func testModel()
    {
        let flicker = Flickr(items: [Items(title: "This is a test", author: "Tong", media: Media(imageURL: URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/crab-nebula-mosaic.jpg")))])
        XCTAssertEqual(flicker.items[0].title, "This is a test")
        XCTAssertEqual(flicker.items[0].author, "Tong", "Failed")
        XCTAssertNotNil(flicker.items[0].media.imageURL)
    }
    
    func testSingleton()
    {
        var service1 = Service.shared
        var service2 = Service.shared
        XCTAssertEqual(UnsafeRawPointer(&service1), UnsafeRawPointer(&service2))
    }
    
    func testAPI()
    {
        Service.shared.fatchData { (data) in
            XCTAssertNotNil(data)
            guard let data = data else { return }
            XCTAssertGreaterThan(data.count, 0)
        }
    }
    
    func testController()
    {
        let vc = MyCollectionViewController()
        XCTAssertNotNil(vc.refreshControl)
    }
    
    func testViewModel()
    {
        let count = MyViewModel.getNumberOfItem()
        MyViewModel.setupData
        {
            XCTAssertNotEqual(count, MyViewModel.getNumberOfItem())
            XCTAssert(MyViewModel.getImageTitle(item: 1) != "")
            XCTAssertTrue(MyViewModel.getImageAuthor(item: 4) != "")
            MyViewModel.loadImage(item: 5) { (image) in
                XCTAssertFalse(image != nil, ".........Load image failed.......")
            }
            print("......test for escaping closure.......")
        }
    }
    
    


    func testPerformanceExample() throws
    {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
            testModel()
        }
    }

}
