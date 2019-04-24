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
        testRepository.save()
        //check
        XCTAssertEqual(count + 1, testRepository.plansCount())
        XCTAssertTrue((storage.setValuePlans as! [String]).contains("New task"))
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
    
    func testDeleteTask() {
        //prepare
        let countPlans = testRepository.plansCount()
        let countMade = testRepository.madeCount()
        //event
        testRepository.deleteFunction(section: 0, index: 0)
        testRepository.deleteFunction(section: 1, index: 0)
        //check
        XCTAssertEqual(countPlans - 1, testRepository.plansCount())
        XCTAssertEqual(countMade - 1, testRepository.madeCount())
    }
    
    func testMarkDoneFromPlans() {
        //prepere
        let sectionPlans = 0
        let indexPlans = 0
        let task = testRepository.getTaskPlansArray(index: indexPlans)
        let countPlans = testRepository.plansCount()
        let countMade = testRepository.madeCount()
        //event
        testRepository.markDoneFunction(section: sectionPlans, index: indexPlans)
        testRepository.save()
        //check
        XCTAssertEqual(countPlans - 1, testRepository.plansCount())
        XCTAssertEqual(countMade + 1, testRepository.madeCount())
        XCTAssertTrue((storage.setValueMade as! [String]).contains(task))
    }
    
    func testMarkDoneFromMade(){
        //prepere
        let sectionMade = 1
        let indexMade = 0
        let task = testRepository.getTaskMadeArray(index: indexMade)
        let countPlans = testRepository.plansCount()
        let countMade = testRepository.madeCount()
        //event
        testRepository.markDoneFunction(section: sectionMade, index: indexMade)
        testRepository.save()
        //check
        XCTAssertEqual(countMade - 1, testRepository.madeCount())
        XCTAssertEqual(countPlans + 1, testRepository.plansCount())
        XCTAssertTrue((storage.setValuePlans as! [String]).contains(task))
        
    }
}

