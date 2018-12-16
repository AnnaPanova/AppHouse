//
//  ToDoListRepositoryTest.swift
//  AppHouseUnitTests
//
//  Created by Анна on 11/11/2018.
//  Copyright © 2018 Анна. All rights reserved.
//

import XCTest
@testable import AppHouse

class MyDefaults : UserDefaults {
    
    var setPlansWasCalled = 0
    var setMadeWasCalled = 0
    var setValuePlans: Any?
    var setValueMade: Any?

    override func set(_ value: Any?, forKey defaultName: String) {
        if defaultName == "plans" {
        setPlansWasCalled += 1
            setValuePlans = value
        } else {
            setMadeWasCalled += 1
            setValueMade = value
        }
}

}
class ToDoListRepositoryTest: XCTestCase {

    var testRepository: ToDoListRepository!
    var storage: MyDefaults!
    
    override func setUp() {
        super.setUp()
        storage = MyDefaults()
        testRepository = ToDoListRepository(userDefaults: storage)
    }

    override func tearDown() {
        storage = nil
        testRepository = nil
        super.tearDown()
    }

    func testSaveSuccess() {
        //event
        testRepository.save()
        //chek
        XCTAssertEqual(storage.setPlansWasCalled, 1)
        XCTAssertEqual(storage.setMadeWasCalled, 1)
    }
    
    func testDownloadSuccess() {
        //prepare
        let plansCount = testRepository.plansCount()
        let madeCount = testRepository.madeCount()
        //event
        testRepository.removePlansArray()
        testRepository.removeMadeArray()
        //check
        XCTAssertEqual(plansCount, (storage.array(forKey: "plans") as! [String]).count)
        XCTAssertEqual(madeCount, (storage.array(forKey: "made") as! [String]).count)
    }
    
    func testAddNewTaskSuccess() {
        //prepare
        let count = testRepository.plansCount()
        //event
        testRepository.addNewTask("New task")
        //check
        XCTAssertEqual(count + 1, testRepository.plansCount())
    }
    
    func testAddNewTaskFail() {
        //prepare
        let count = testRepository.plansCount()
        //event
        testRepository.addNewTask("")
        //check
        XCTAssertEqual(count, testRepository.plansCount())
    }
    
    func testEditTaskSuccess() {
        //event
        testRepository.editTask(index: 0, "Edit task")
        testRepository.save()
        //check
        XCTAssertTrue((storage.setValuePlans as! [String]).contains("Edit task"))
    }
    
    func testEditTaskFail() {
    //prepare
    testRepository.save()
    let someArray = storage.setValuePlans as! [String]
    //event
    testRepository.editTask(index: 0, "")
    testRepository.save()
    //check
    XCTAssertEqual(someArray, storage.setValuePlans as! [String])
    }
    

}

