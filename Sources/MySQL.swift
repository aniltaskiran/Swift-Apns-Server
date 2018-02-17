////
////  MySQL.swift
////  CreateYourOwnApnsPackageDescription
////
////  Created by Anıl T. on 12.01.2018.
////
//
//import MySQL
//
//private func fetchData(completion: (_ MySQL: MySQL) -> Void) {
//
//    let mysql = MySQL()
//
//    let connected = mysql.connect(host: testHost, user: testUser, password: testPassword)
//
//    guard connected else {
//        // verify we connected successfully
//        print(mysql.errorMessage())
//        return
//    }
//    print("başarılı")
//
//    defer {
//        print("kapatılıyor")
//        mysql.close() //This defer block makes sure we terminate the connection once finished, regardless of the result
//    }
//
//    //Choose the database to work with
//    guard mysql.selectDatabase(named: testDB) else {
//        print("database seçiminde hata.")
//        return
//    }
//    completion(mysql)
//}
//
//func readAll(completion: (_ tokens: [String]) -> Void){
//    fetchData { (mysql) in
//        var allTokens:[String] = []
//
//        let theStatement = MySQLStmt(mysql)
//
//        _ = theStatement.prepare(statement: "SELECT token FROM Tokens")
//        _ = theStatement.execute()
//
//        let theResults = theStatement.results()
//        //        let error = theStatement.errorMessage()
//
//        print("\r\n")
//
//        _ = theResults.forEachRow {
//            e in
//
//            for i in 0..<e.count {
//                let theFieldName = theStatement.fieldInfo(index: i)!.name
//                print("\(theFieldName): \(e[i]!)")
//                allTokens.append("\(e[i]!)")
//            }
//
//            print("\r\n")
//        }
//        completion(allTokens)
//    }
//}
//
//func returnID(token: String) -> [String]{
//    var allID:[String] = []
//
//    fetchData { (mysql) in
//        let theStatement = MySQLStmt(mysql)
//
//        _ = theStatement.prepare(statement: "SELECT ID FROM Tokens where token = '\(token)'")
//        _ = theStatement.execute()
//
//        let theResults = theStatement.results()
//        //        let error = theStatement.errorMessage()
//
//        print("\r\n")
//
//        _ = theResults.forEachRow {
//            e in
//
//            for i in 0..<e.count {
//                let theFieldName = theStatement.fieldInfo(index: i)!.name
//                print("\(theFieldName): \(e[i]!)")
//                allID.append("\(e[i]!)")
//            }
//
//            print("\r\n")
//        }
//    }
//    return allID
//}
//
//func writeValue(Query: String){
//    fetchData { (mysql) in
//        let theStatement = MySQLStmt(mysql)
//        _ = theStatement.prepare(statement: Query)
//        _ = theStatement.execute()
//        //        let theResults = theStatement.results()
//        //        let error = theStatement.errorMessage()
//        //
//        //    print("error: " + error)
//        print("yazıldı.")
//    }
//}
//
//
