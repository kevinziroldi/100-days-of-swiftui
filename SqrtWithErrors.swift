enum SqrtError : Error {
    case outOfBound, noRoot
}

func integerSqrt(number: Int) throws -> Int {
    if number < 1 || number > 10000 {
        throw SqrtError.outOfBound
    }
    
    var i = 1;
    while true {
        if i*i == number {
            return i
        }else if i*i > number {
            throw SqrtError.noRoot
        }else {
            i += 1
        }
    }
}

let num = 25
do {
    let intSqrt = try integerSqrt(number: num)
    print(intSqrt)
}catch {
    print("The integer sqrt doesn't exist.")
}
