class Animal {
    let legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    func speak() {
        print("bau dog")
    }
}

class Corgi: Dog {
    override func speak() {
        print("bau corgi")
    }
}

class Poodle: Dog {
    override func speak() {
        print("bau poodle")
    }
}

class Cat: Animal {
    let isTame: Bool
    
    init(legs: Int, isTame: Bool) {
        self.isTame = isTame
        super.init(legs)
    }
    
    func speak() {
        print("miao cat")
    }
}

class Persian: Cat {
    override func speak() {
        print("miao persian")
    }
}

class Lion: Cat {
    override func speak() {
        print("miao lion")
    }
}
