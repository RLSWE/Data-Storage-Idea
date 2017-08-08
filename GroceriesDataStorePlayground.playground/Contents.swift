//: Playground - noun: a place where people can play

import UIKit

//Singleton protocol
protocol Singleton {
    static var shared : Self { get }
}
//Data storage protocol
protocol DataStorage : Singleton{
    associatedtype Data : Sequence //Array,Set and Dictionary conform to Sequence
    associatedtype Key : Hashable
    
    var data : Data {get set}
}

//Grocery protocol
protocol Grocery {
    var price : Double {get set}
    var name : String {get}
    
}

struct Fruit : Grocery,CustomStringConvertible {
    var price: Double
    var name: String
    var sweetness : Int // 1 - 10
    
    var description: String{
        return "\(name) is \(sweetness)/10 sweet and costs \(price)"
    }
}

struct Vegetable : Grocery,CustomStringConvertible {
    var price: Double
    var name: String
    var hasCarbs : Bool
    var description: String{
        return "\(name) has \(hasCarbs ? "" : "no") carbs and costs \(price)"
    }
}












//////// #### Example #1 #### ////////
//Groceries Data Store
final class GroceriesListStorage : DataStorage { //declared as final because it conforms to Singleton protocol with the 'shared' property, which is type of Self.
    
    static var shared = GroceriesListStorage()
    
    //Declare the data key which we will later use on the subscript.
    enum DataKey : String{ //Could also be Int or any other hashable
        case fruits = "fruits"
        case vegetables = "veggies"
    }
    
    //Declare typealiases to override the associated types
    typealias Key = DataKey
    typealias Data = Dictionary<Key,[Grocery]>
    
    var data = Data()
    
    subscript(key:Key) -> [Grocery]?{
        get{
            return self.data[key]
        }
        set{
            self.data[key] = newValue
        }
    }
}

let banana = Fruit(price: 0.90, name: "Banana", sweetness: 8)
let kiwi = Fruit(price: 1.30, name: "Kiwi", sweetness: 8)
let cucumber = Vegetable(price: 0.40, name: "Cucumber", hasCarbs: false)

GroceriesListStorage.shared[.fruits]=[banana,kiwi]
GroceriesListStorage.shared[.vegetables]=[cucumber]

print(GroceriesListStorage.shared[.fruits]!)
GroceriesListStorage.shared[.fruits]?.remove(at: 0) //Couldv'e used remove object if GroceriesListStorage.Data elements were of type that conforms to Equatable
print(GroceriesListStorage.shared[.fruits]!)

print(GroceriesListStorage.shared[.vegetables]!)









//////// #### Example #2 #### ////////
//Winning Lottery Numbers Store
final class WinningLotteryNumbersStorage : DataStorage { //declared as final because it conforms to Singleton protocol with the 'shared' property, which is type of Self.
    
    static var shared = WinningLotteryNumbersStorage()
    
    enum DataKey : String{
        case winningNumbers = "winning"
        case losingNumbers = "losing"
    }
    
    typealias Key = DataKey
    typealias Data = Dictionary<Key,[[Int]]>
    
    var data = Data()
    
    subscript(key:Key) -> [[Int]]?{
        get{
            return self.data[key]
        }
        set{
            self.data[key] = newValue
        }
    }
}


WinningLotteryNumbersStorage.shared[.winningNumbers] = [[1,7,4],[1,5,7],[8,2,1]]
WinningLotteryNumbersStorage.shared[.losingNumbers] = [[6,4,3],[2,5,7],[7,6,1]]

print("The losing lottery numbers are : \(WinningLotteryNumbersStorage.shared[.losingNumbers]!)")
print("The winning lottery numbers are : \(WinningLotteryNumbersStorage.shared[.winningNumbers]!)")



