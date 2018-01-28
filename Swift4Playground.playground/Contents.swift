//: Playground - noun: a place where people can play

import UIKit

// ***   VARIABLES   ******************************************************************************
print("Hello")
let hello = "Hello"
var world = "World"
print(hello + " " + world)
print("\(hello) \(world)")

let implicitInt  = 1
let explicitInt : Int = 2
let implicitDouble = 2.9
let explicitDouble : Double = 2.0
let quote = """
Something's very "serious"!
"""
print(quote)

var optionalStr : String? = nil
optionalStr = "None nil value"
print("Optional value : \(optionalStr ?? "Nil value")")
if let noneNilValue = optionalStr { print(noneNilValue) }


// ***   DATA STRUCTURES - ARRAYS AND DICTIONARIES ***********************************************

var implicitArr = [2,3,4]
var explicitArr : [Int] = [1,3,5]
var emptyArray1 : [Double] = []
var emptyArray2 = [Double]()
emptyArray1.append(4.5)
var implicitDict = ["key1" : 1, "key2" : 2]
var explicitDict : [Int:String] = [1:"key1", 2:"key2"]
var emptyDict1 = [String:Int]()
var emptyDict2 : [String:Int] = [:]
emptyDict1["key"] = 1


// ***   CONTROL FLOW   ******************************************************************************

for num in implicitArr {
    print(num)
}

for (key, value) in implicitDict {
    print("\(key), \(value) : \(String(describing: implicitDict[key]))")
}

for _ in 0..<3 {
    // Do something
}

switch implicitInt {
    case 1...3: print("Integer")
    case 6: print("is 6")
    case let x where x % 2 == 0: print("is even")
    default: print("default 0")
}

if (1 % 2 == 0) { } else { }

while implicitInt < 0 {
    // do something
}

repeat {
    // do something
} while implicitInt < 0


// ***   FUNCTIONS   ***************************************************************************

func greet() {
    print("Hi")
}
greet()

func add(num: Int) -> Int {
    return num + 1
}
add(num: 1)

func isReal(status: String? = nil) -> Bool {
    return status != nil
}
isReal()

func fullname(_ firstname: String, and lastname: String) -> String {
    return "\(firstname) \(lastname)"
}
fullname("Clark", and: "Kent")

func getTuple() -> (num: Int, str: String) {
    return (num: 9, str: "str")
}
var tuple = getTuple()
tuple.num
tuple.str

func rename(name: String) -> String {
    var newName = name
    func getRandomName() {
        newName = "\(newName) Random"
    }
    getRandomName()
    return newName
}
rename(name: "Somebody")

// ***   CLOSURES   ******************************************************************************

typealias CustomClosure = (Double) -> Double

func getClosure() -> CustomClosure {
    return { (number: Double) in
            return number + 1.2332
    }
}
var closure = getClosure()
closure(4.9)

func funcWithCompletion(completion:CustomClosure) -> Void {
    completion(3.6)
}

funcWithCompletion { (number : Double) in
    return number / 6.332
}

var increments = explicitArr.map({ (num: Int) -> Int
    in return num + 4
})

var multiples = explicitArr.map({
    num in 3 * num
})

var sorted = explicitArr.sorted {
    $0 > $1
}


// ***   OBJECTS AND CLASSES   ******************************************************************************
class Vehicle {
    let isStatic : Bool = false
    var wheels: Int
    var fuel : String?
    
    init(wheels: Int) {
        self.wheels = wheels
    }
    
    func drive() {
        print("Vehicle is moving")
    }
}

class Car: Vehicle {
    var seats : Int = 2
    
    var color: String? {
        willSet {
            driverName = newValue ?? "No driver for car color"
        }
        didSet {
            print(color ?? "No car color")
        }
    }
    
    private var _driverName: String = "Driver"
    
    var driverName : String {
        get { return _driverName }
        set { _driverName = newValue }
    }
    
    init(seats: Int, fuel: String, wheels: Int) {
        self.seats = seats
        super.init(wheels: wheels)
        self.fuel = fuel
    }
}

var car = Car(seats: 5, fuel: "petrol", wheels: 4)
car.seats
car.color = "Red"
car.driverName



class Person {
    var name : String
    var age : Int
    var gender : String?
    
    convenience init?(name: String) {
        self.init(name: name, age: 0, gender: nil)
    }
    
    convenience init?() {
        self.init(name: "Unknown", age: 0, gender: nil)
    }
    
    required init?(name: String, age: Int, gender: String? = nil) {
        if name.isEmpty || age < 0 { return nil }
        self.name = name
        self.age = age
        self.gender = gender
    }
    
    func simpleDescription() {
        if let gen = gender,
            !gen.isEmpty {
            print("\(self.name) is \(self.age) years old \(gen == "M" ? "Male" : "Female")")
        }
        else {
            print("\(self.name) is \(self.age) years old")
        }
    }
}

class Child : Person {
    convenience init?() {
        self.init(name: "", age: 1, gender: "F")
    }
    
    required init?(name: String, age: Int, gender: String?) {
        super.init(name: name, age: age, gender: gender)
        self.name = name
        self.age = age
    }
}

var people = [Person(), Person(name: "John"), Person(name: ""), Person(name:"Cris", age: 2), Person(name: "Eric", age: 3, gender: "M")]
for person in people {
    person?.simpleDescription()
}






















