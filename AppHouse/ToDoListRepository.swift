//
//  ToDoListRepository.swift
//  AppHouse
//
//  Created by Анна on 11/11/2018.
//  Copyright © 2018 Анна. All rights reserved.
//

import Foundation


class ToDoListRepository {
    
    private var plansArray: [String]
    private var madeArray: [String]
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        plansArray = userDefaults.array(forKey: "plans") as? [String] ?? []
        madeArray = userDefaults.array(forKey: "made") as? [String] ?? []
    }
    
    // MARK: Save function
    func save() {
        userDefaults.set(plansArray, forKey: "plans")
        userDefaults.set(madeArray, forKey: "made")
    }
    
    func plansCount() -> Int {
        return plansArray.count
    }
    
    func madeCount() -> Int {
        return madeArray.count
    }
    
    func madeArrayIsEmpty() -> Bool {
        return madeArray.isEmpty
    }
    
    func plansArrayIsEmpty() -> Bool {
        return plansArray.isEmpty
    }
    
    // MARK: Remove arrays
    func removePlansArray() {
        plansArray.removeAll()
    }
    
    func removeMadeArray() {
        madeArray.removeAll()
    }
    
    // MARK: Edit tasks
    func editTask(index: Int, _ text: String) {
        guard !text.isEmpty else {return}
        plansArray[index] = text
    }

    // MARK: Get tasks
    func getTaskPlansArray(index: Int) -> String {
        return plansArray[index]
    }
    
    func getTaskMadeArray(index: Int) -> String {
        return madeArray[index]
    }
    
    // MARK: Add tasks
    func addNewTask(_ text: String) {
        guard !text.isEmpty else {return}
        plansArray.append(text)
    }
    
   func addDoneTask(_ text: String) {
        guard !text.isEmpty else {return}
        madeArray.append(text)
   }
    
    func returnDoneTasks() {
        for element in madeArray {
            addNewTask(element)
        }
        removeMadeArray()
    }

    func markDoneFunction(section: Int, index: Int) {
        if section == 0 {
            let temporaryValye = plansArray[index]
            plansArray.remove(at: index)
            addDoneTask(temporaryValye)
        } else {
            let temporaryValue = madeArray[index]
            madeArray.remove(at: index)
            addNewTask(temporaryValue)
        }
    }
        
    func deleteFunction(section: Int, index: Int) {
            if section == 0 {
                plansArray.remove(at: index)
            } else {
                madeArray.remove(at: index)
            }
        }
    }

