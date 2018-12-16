//
//  TodoListViewControllerTests.swift
//  AppHouseUnitTests
//
//  Created by Анна on 04/11/2018.
//  Copyright © 2018 Анна. All rights reserved.
//

import XCTest
@testable import AppHouse
/*
class TodoListViewControllerTests: XCTestCase {
    
    var todoListViewController: ViewController!
    let storage = UserDefaults.standard

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        todoListViewController = (storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController)
    }

    override func tearDown() {
        todoListViewController = nil
        storage.set(nil, forKey: "plans")
        storage.set(nil, forKey: "made")
        super.tearDown()
    }
    
    func testAddNewTaskSuccess1() {
        //prepare envirenment
        var plansArray = Array(todoListViewController.plansArray)
        plansArray.append("Task")
        //initiate event
        todoListViewController.addNewTask("Task")
        //check
        XCTAssertEqual(plansArray, todoListViewController.plansArray)
    }
    
    func testAddNewTaskFailure() {
        //prepare envirenment
        let plansArray = Array(todoListViewController.plansArray)
        //initiate event
        todoListViewController.addNewTask("")
        //check
        XCTAssertEqual(plansArray, todoListViewController.plansArray)
    }

    //MARK: Q   indexPath.row == nil
    func testMarkTaskAsDoneSuccess() {
        //prepare
        var plansArray = Array(todoListViewController.plansArray)
        let indexDoneTask = 0
        plansArray.remove(at: indexDoneTask)
        //event
        todoListViewController.markTaskAsDone(with: indexDoneTask)
        //check
        XCTAssertEqual(plansArray, todoListViewController.plansArray)
    }
    
    func testAddDoneTaskSuccess() {
        //prepere envirenment
        var madeArray = Array(todoListViewController.madeArray)
        madeArray.append("Done task")
        //event
         todoListViewController.addDoneTask(with: "Done task")
        //check
        XCTAssertEqual(madeArray, todoListViewController.madeArray)
    }
    
    func testAddDoneTaskFailure() {
        //prepare environment
        let madeArray = Array(todoListViewController.madeArray)
        //event
        todoListViewController.addDoneTask(with: "")
        //check
        XCTAssertEqual(madeArray, todoListViewController.madeArray)
    }
    
    func testDeleteDoneTasks() {
        //prepare environment
        var madeArray = Array(todoListViewController.madeArray)
        let indexDeleteTask = 0
        madeArray.remove(at: indexDeleteTask)
        //event
        todoListViewController.deleteDoneTasks(with: indexDeleteTask)
        //check
        XCTAssertEqual(madeArray, todoListViewController.madeArray)
    }
    
    func testSaveActionSuccess() {
        //prepare envirenment
        let plansArray = Array(todoListViewController.plansArray)
        let madeArray = Array(todoListViewController.madeArray)
        //initiate event
        todoListViewController.makeSave()
        //check
        XCTAssertEqual(plansArray, storage.array(forKey: "plans") as! [String])
        XCTAssertEqual(madeArray, storage.array(forKey: "made") as! [String])
    }
    
    //MARK: Q double test?
    func testSaveActionWithAddNewTaskSucces() {
        //prepare envirenment
        var plansArray = Array(todoListViewController.plansArray)
        plansArray.append("New task")
        //initiate event
        todoListViewController.addNewTask("New task")
        todoListViewController.makeSave()
        //check
        XCTAssertEqual(plansArray, storage.array(forKey: "plans") as! [String])
    }
    
    func testSaveEmptyArraysSuccess() {
        //prepare envirenment
        var plansArray = Array(todoListViewController.plansArray)
        var madeArray = Array(todoListViewController.madeArray)
        plansArray.removeAll()
        madeArray.removeAll()
        //initiate event
        todoListViewController.plansArray.removeAll()
        todoListViewController.madeArray.removeAll()
        todoListViewController.makeSave()
        //check
        XCTAssertEqual(plansArray, storage.array(forKey: "plans") as! [String])
        XCTAssertEqual(madeArray, storage.array(forKey: "made") as! [String])
    }
    
}

/*
 userdefolts.set(plansArray, forKey: "plans")
 userdefolts.set(madeArray, forKey: "made")
 
 -done
 ffunc addNewTask(_ text: String) {
 guard !text.isEmpty else {return}
 plansArray.append(text)
 }
 
 -done
 func markTaskAsDone(with index: Int) {
 plansArray.remove(at: index)
 }
 -done
 func deleteDoneTasks(with index: Int) {
 madeArray.remove(at: index)
 }
 
 -done
 func addDoneTask(with text: String) {
 madeArray.append(text)
 }
 
 
 func downloadSave() {
 self.setEditing(true, animated: true)
 if let plans = userDefaults.object(forKey: "plans") {
 plansArray = plans as! [String]
 }
 if let made = userDefaults.object(forKey: "made") {
 madeArray = made as! [String]
 }
 }
 */
*/
