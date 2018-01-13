//
//  Config.swift
//  CreateYourOwnApnsPackageDescription
//
//  Created by Anıl T. on 12.01.2018.
//

 import MySQL


let testHost = "127.0.0.1"
let testUser = "root"
let testPassword = SECRET_TEST_PASSWORD
let testDB = SECRET_TESTDB


//Obviously change these details to a database and user you have already defined

private func fetchData(completion: (_ MySQL: MySQL) -> Void) {
    
    let mysql = MySQL() // Create an instance of MySQL to work with
    
    let connected = mysql.connect(host: testHost, user: testUser, password: testPassword)
    
    guard connected else {
        // verify we connected successfully
        print(mysql.errorMessage())
        return
    }
    print("başarılı")
    
    defer {
        print("kapatılıyor")
        mysql.close() //This defer block makes sure we terminate the connection once finished, regardless of the result
    }
    
    //Choose the database to work with
    guard mysql.selectDatabase(named: testDB) else {
        print("seçilemedi")
        return
    }
    print("seçildi")
    completion(mysql)
}

func readAll(completion: (_ tokens: [String]) -> Void){
    fetchData { (mysql) in
        var allTokens:[String] = []

        let theStatement = MySQLStmt(mysql)

        _ = theStatement.prepare(statement: "SELECT * FROM Devices")
        _ = theStatement.execute()

        let theResults = theStatement.results()

        print("\r\n")

        _ = theResults.forEachRow {
            e in

            for i in 0..<e.count {
                let theFieldName = theStatement.fieldInfo(index: i)!.name
                print("\(theFieldName): \(e[i]!)")
                allTokens.append("\(e[i]!)")
            }

            print("\r\n")
        }
        completion(allTokens)
    }
}

func writeValue(token: String){
    fetchData { (mysql) in
    let theStatement = MySQLStmt(mysql)
    _ = theStatement.prepare(statement: "INSERT INTO Devices(token) values(\"\(token)\")")
    _ = theStatement.execute()
    print("yazıldı.")
    }
}

