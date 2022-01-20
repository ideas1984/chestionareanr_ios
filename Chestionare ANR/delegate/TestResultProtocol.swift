//
//  TestResultDelegate.swift
//  Chestionare ANR
//
//  Created by Marius Tanasoiu on 1/15/21.
//  Copyright © 2021 NavyMasters. All rights reserved.
//

protocol TestResultProtocol: AnyObject {
    func testFinished(withResult result: TestResult, andGoodAnswers goodAnswers: Int);
}

