//
//  QuestionModel.swift
//  Sudoku
//
//  Created by Mac on 3/12/2018.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class QuestionModel: NSObject {

    
    
    
    
    
    func readEasyQuestion() -> Array<Array<String>> {
        var myStringasArray = Array<String>()
        var questionArr = Array<Array<String>>()
        
        for i in 150...199 {
            
            let resuorcesPath = "sudoku_blancks_25_\(i)"
            
            if let txtFile = Bundle.main.path(forResource: resuorcesPath, ofType: "txt")
            {
                let txtData = NSData(contentsOfFile: txtFile)// 读取数据，UTF-8格式的NSData
                let txtString = (NSString(data: txtData! as Data, encoding: String.Encoding.utf8.rawValue))! as String
                let str = txtString.replacingOccurrences(of: "\n", with: "")
                let str1 = str.replacingOccurrences(of: "[", with: "")
                var str2 = str1.replacingOccurrences(of: "]", with: ",")
                
                str2.removeLast()
                
                myStringasArray = str2.components(separatedBy: ",")
                questionArr.append(myStringasArray)
            }
            
            
        }
        return  questionArr
    }
    
    
    func readEasyQuestionResolve() -> Array<Array<String>> {
        var myStringasArray = Array<String>()
        var questionArr = Array<Array<String>>()
        
        for i in 150...199 {
            
            let resuorcesPath = "resolution__blancks_25_\(i)"
            
            if let txtFile = Bundle.main.path(forResource: resuorcesPath, ofType: "txt")
            {
                let txtData = NSData(contentsOfFile: txtFile)// 读取数据，UTF-8格式的NSData
                let txtString = (NSString(data: txtData! as Data, encoding: String.Encoding.utf8.rawValue))! as String
                let str = txtString.replacingOccurrences(of: "\n", with: "")
                let str1 = str.replacingOccurrences(of: "[", with: "")
                var str2 = str1.replacingOccurrences(of: "]", with: ",")
                
                str2.removeLast()
                
                myStringasArray = str2.components(separatedBy: ",")
                questionArr.append(myStringasArray)
            }
            
            
        }
        
        
        
        
        return questionArr
    }
    
    
    func readAdvancedQuestion() -> Array<Array<String>> {
        var myStringasArray = Array<String>()
        var questionArr = Array<Array<String>>()
        
        for i in 200...249 {
            
            let resuorcesPath = "sudoku_blancks_30_\(i)"
            
            if let txtFile = Bundle.main.path(forResource: resuorcesPath, ofType: "txt")
            {
                let txtData = NSData(contentsOfFile: txtFile)// 读取数据，UTF-8格式的NSData
                let txtString = (NSString(data: txtData! as Data, encoding: String.Encoding.utf8.rawValue))! as String
                let str = txtString.replacingOccurrences(of: "\n", with: "")
                let str1 = str.replacingOccurrences(of: "[", with: "")
                var str2 = str1.replacingOccurrences(of: "]", with: ",")
                
                str2.removeLast()
                
                myStringasArray = str2.components(separatedBy: ",")
                questionArr.append(myStringasArray)
            }
            
            
        }
        return  questionArr
    }
    func readAdvancedQuestionResolve() -> Array<Array<String>> {
        var myStringasArray = Array<String>()
        var questionArr = Array<Array<String>>()
        
        for i in 200...249 {
            
            let resuorcesPath = "resolution__blancks_30_\(i)"
            
            if let txtFile = Bundle.main.path(forResource: resuorcesPath, ofType: "txt")
            {
                let txtData = NSData(contentsOfFile: txtFile)// 读取数据，UTF-8格式的NSData
                let txtString = (NSString(data: txtData! as Data, encoding: String.Encoding.utf8.rawValue))! as String
                let str = txtString.replacingOccurrences(of: "\n", with: "")
                let str1 = str.replacingOccurrences(of: "[", with: "")
                var str2 = str1.replacingOccurrences(of: "]", with: ",")
                
                str2.removeLast()
                
                myStringasArray = str2.components(separatedBy: ",")
                questionArr.append(myStringasArray)
            }
            
            
        }
        
        
        
        
        return questionArr
    }
    func readDifficultyQuestion() -> Array<Array<String>> {
        var myStringasArray = Array<String>()
        var questionArr = Array<Array<String>>()
        
        for i in 250...299 {
            
            let resuorcesPath = "sudoku_blancks_35_\(i)"
            
            if let txtFile = Bundle.main.path(forResource: resuorcesPath, ofType: "txt")
            {
                let txtData = NSData(contentsOfFile: txtFile)// 读取数据，UTF-8格式的NSData
                let txtString = (NSString(data: txtData! as Data, encoding: String.Encoding.utf8.rawValue))! as String
                let str = txtString.replacingOccurrences(of: "\n", with: "")
                let str1 = str.replacingOccurrences(of: "[", with: "")
                var str2 = str1.replacingOccurrences(of: "]", with: ",")
                
                str2.removeLast()
                
                myStringasArray = str2.components(separatedBy: ",")
                questionArr.append(myStringasArray)
            }
            
            
        }
        return  questionArr
    }
    
    func readDifficultyQuestionResolve() -> Array<Array<String>> {
        var myStringasArray = Array<String>()
        var questionArr = Array<Array<String>>()
        
        for i in 250...299 {
            
            let resuorcesPath = "resolution__blancks_35_\(i)"
            
            if let txtFile = Bundle.main.path(forResource: resuorcesPath, ofType: "txt")
            {
                let txtData = NSData(contentsOfFile: txtFile)// 读取数据，UTF-8格式的NSData
                let txtString = (NSString(data: txtData! as Data, encoding: String.Encoding.utf8.rawValue))! as String
                let str = txtString.replacingOccurrences(of: "\n", with: "")
                let str1 = str.replacingOccurrences(of: "[", with: "")
                var str2 = str1.replacingOccurrences(of: "]", with: ",")
                
                str2.removeLast()
                
                myStringasArray = str2.components(separatedBy: ",")
                questionArr.append(myStringasArray)
            }
            
            
        }
        
        
        
        
        return questionArr
    }
    func readExpertQuestion() -> Array<Array<String>> {
        var myStringasArray = Array<String>()
        var questionArr = Array<Array<String>>()
        
        for i in 300...349 {
            
            let resuorcesPath = "sudoku_blancks_40_\(i)"
            
            if let txtFile = Bundle.main.path(forResource: resuorcesPath, ofType: "txt")
            {
                let txtData = NSData(contentsOfFile: txtFile)// 读取数据，UTF-8格式的NSData
                let txtString = (NSString(data: txtData! as Data, encoding: String.Encoding.utf8.rawValue))! as String
                let str = txtString.replacingOccurrences(of: "\n", with: "")
                let str1 = str.replacingOccurrences(of: "[", with: "")
                var str2 = str1.replacingOccurrences(of: "]", with: ",")
                
                str2.removeLast()
                
                myStringasArray = str2.components(separatedBy: ",")
                questionArr.append(myStringasArray)
            }
            
            
        }
        return  questionArr
    }
    
    func readExpertQuestionResolve() -> Array<Array<String>> {
        var myStringasArray = Array<String>()
        var questionArr = Array<Array<String>>()
        
        for i in 300...349 {
            
            let resuorcesPath = "resolution__blancks_40_\(i)"
            
            if let txtFile = Bundle.main.path(forResource: resuorcesPath, ofType: "txt")
            {
                let txtData = NSData(contentsOfFile: txtFile)// 读取数据，UTF-8格式的NSData
                let txtString = (NSString(data: txtData! as Data, encoding: String.Encoding.utf8.rawValue))! as String
                let str = txtString.replacingOccurrences(of: "\n", with: "")
                let str1 = str.replacingOccurrences(of: "[", with: "")
                var str2 = str1.replacingOccurrences(of: "]", with: ",")
                
                str2.removeLast()
                
                myStringasArray = str2.components(separatedBy: ",")
                questionArr.append(myStringasArray)
            }
            
            
        }
        
        
        
        
        return questionArr
    }
    
    func readCrazyQuestion() -> Array<Array<String>> {
        var myStringasArray = Array<String>()
        var questionArr = Array<Array<String>>()
        
        for i in 350...399 {
            
            let resuorcesPath = "sudoku_blancks_45_\(i)"
            
            if let txtFile = Bundle.main.path(forResource: resuorcesPath, ofType: "txt")
            {
                let txtData = NSData(contentsOfFile: txtFile)// 读取数据，UTF-8格式的NSData
                let txtString = (NSString(data: txtData! as Data, encoding: String.Encoding.utf8.rawValue))! as String
                let str = txtString.replacingOccurrences(of: "\n", with: "")
                let str1 = str.replacingOccurrences(of: "[", with: "")
                var str2 = str1.replacingOccurrences(of: "]", with: ",")
                
                str2.removeLast()
                
                myStringasArray = str2.components(separatedBy: ",")
                questionArr.append(myStringasArray)
            }
            
            
        }
        return  questionArr
    }
    
    func readCrazyQuestionResolve() -> Array<Array<String>> {
        var myStringasArray = Array<String>()
        var questionArr = Array<Array<String>>()
        
        for i in 350...399 {
            
            let resuorcesPath = "resolution__blancks_45_\(i)"
            
            if let txtFile = Bundle.main.path(forResource: resuorcesPath, ofType: "txt")
            {
                let txtData = NSData(contentsOfFile: txtFile)// 读取数据，UTF-8格式的NSData
                let txtString = (NSString(data: txtData! as Data, encoding: String.Encoding.utf8.rawValue))! as String
                let str = txtString.replacingOccurrences(of: "\n", with: "")
                let str1 = str.replacingOccurrences(of: "[", with: "")
                var str2 = str1.replacingOccurrences(of: "]", with: ",")
                
                str2.removeLast()
                
                myStringasArray = str2.components(separatedBy: ",")
                questionArr.append(myStringasArray)
            }
            
            
        }
        
        
        
        
        return questionArr
    }
    
    
}
