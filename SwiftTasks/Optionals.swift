/*
Write a function that accepts an optional array of integers and returns one randomly.
If the array is missing or empty, return a random number in the range 1 through 100.
Do this in a single line of code!
*/

func returnNumber(arr numsArray: [Int]?) -> Int {
    return numsArray?.randomElement() ?? Int.random(in: 0...100);
}

var numsArray: [Int] = []
print(returnNumber(arr: numsArray))
