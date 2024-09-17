/*
Create a struct to store information about a car, including its
- model
- number of seats
- current gear
- add a method to change gears up or down.
 
 Have a think about variables and access control: what data should be a variable rather than a constant, and what data should be exposed publicly?
 Should the gear-changing method validate its input somehow?
*/

struct Car {
    public let model: String
    public let seatsNumber: Int
    private(set) var currGear: Int
    
    mutating func changeGear(gear: Int) -> Bool {
        if gear >= 1 && gear <= 6 {
            currGear = gear
            return true
        }else {
            return false
        }
    }
}
