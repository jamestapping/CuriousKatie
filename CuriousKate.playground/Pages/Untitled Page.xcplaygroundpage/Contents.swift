import UIKit

// MARK:- Set up objects required for the algorithm

struct Person {
    
    var name: String
    var age: Int
    var hometown: String
    var interest: [Interest]
    
}

struct Interest: Equatable {
    
    var name: String
    var properties : String

}

struct tempArray {
    
    var name: String
    var interest : [String]
}


//MARK:- Store participants names and hometowns used for generating people

var names = ["James", "Robert", "Mitar", "Jules", "Antoine","Sylvain","Julia","Prisila","Angela","Isabelle","Alice","Jennifer"]

var hometowns = ["Paris","London","Milan","Chengdu","Istanbul","Moscow","Berlin","Madrid","Kyiv","Rome","Bucharest","Minsk","Vienna","Belgrade"]

// Array used to store the interests
var interests:[Interest] = []

// Array used to store the pairings
var pairings = [[String:String]]()


// Append each interest to the interest array
interests.append(Interest(name: "Skydiving", properties: "My Expensive hobby"))
interests.append(Interest(name: "Walking", properties: "I love hills"))
interests.append(Interest(name: "Jogging", properties: "I love my expensive trainers"))
interests.append(Interest(name: "Dancing", properties: "Nightclubs are my thing"))
interests.append(Interest(name: "Films", properties: "I have Netflix and Amazon prime"))
interests.append(Interest(name: "Television Series", properties: "I love to binge watch"))
interests.append(Interest(name: "Technology", properties: "Apple or Android? Both!"))
interests.append(Interest(name: "Pets", properties: "I have two dogs and a cat"))
interests.append(Interest(name: "Cars", properties: "I am saving up for a Porche"))
interests.append(Interest(name: "Travel", properties: "I love to fly far away"))


var people:[Person] = []

//MARK:- Randomly generate participants

func generateParticipants() -> [Person] {
    
    print ("Generating Participants")
    print ("***********************")
    
    let numberOfParticipants = getNumberOfParticipants()
    
    for i in 0...numberOfParticipants - 1  {
        
        let age = Int.random(in: 25...55)
    
        let newPerson = Person(name: names[i], age: age, hometown: hometowns.randomElement()!, interest: getRandomInterests())
        people.append(newPerson)
        
    }
    
    print ("Done")
    
    return people
}


// MARK:- Introductions

func logIntroductions() {

    print ("There are \(participants.count) participants")

   var introductions:[String] = []

    for i in 0...participants.count - 1  {

        introductions.append("hello my name is \(participants[i].name) and I am \(participants[i].age). I enjoy \(participants[i].interest)")

        print ("hello my name is \(participants[i].name) and I am \(participants[i].age). I am from \(participants[i].hometown) I have \(participants[i].interest.count) interests")

    }
}

// MARK:- Create a list of random interests.

func getRandomInterests() -> [Interest] {
    
    var randomInterests:[Interest] = []
    
    let randomNumberOfInterests = Int.random(in: 1...interests.count)
    
    for _ in 1...randomNumberOfInterests {
        
        var randomInterest = interests.randomElement()
        
        while (randomInterests.firstIndex(where: {$0.name == randomInterest!.name}) != nil) {
            
            randomInterest = interests.randomElement()
            
        }
        
        randomInterests.append(randomInterest!)
    }
    
    return randomInterests
}

// MARK: - Show all interests of all participants but in random order

func iterateThroughInterests() {
    
    var storeTempInterests:[String] = []
    var participantsTempArray:[tempArray] = []

    print ("We have \(participants.count) participants")
    
    
    for participant in 0 ... participants.count - 1 {
        
        for _ in 0 ... participants[participant].interest.count - 1 {
            
            var randomInterest = Int.random(in: 0...participants[participant].interest.count - 1)
            var randomInterestName = participants[participant].interest[randomInterest].name
            
            while (storeTempInterests.firstIndex(of: randomInterestName) != nil) {
                
                // print ("Seen this interest before for \(participants[participant].name) getting another one")
                
                randomInterest = Int.random(in: 0...participants[participant].interest.count - 1)
                randomInterestName = participants[participant].interest[randomInterest].name
                
            }
            
            storeTempInterests.append(randomInterestName)
            
        }
        
        
        // Add name of participant and their interests to the temp array
        
        participantsTempArray.append(tempArray(name: participants[participant].name, interest: storeTempInterests))
        
        
        print (participants[participant].name ," has these interests ", storeTempInterests)
        
        storeTempInterests = []
        
    }
    
}


// MARK:- Randomly share an interest


func shareInterests() {
    
    
    print ("Started Sharing:")
    print ("*****************")
    
    var storeShareOrder:[Int] = []
    
    for _ in 0 ... participants.count - 1 {
        
        var randomParticipant = Int.random(in: 0 ... participants.count - 1)
        
        while (storeShareOrder.firstIndex(of: randomParticipant) != nil) {
            
            // print ("Seen this one before, generate another")
            
            randomParticipant = Int.random(in: 0 ... participants.count - 1)
            
        }
        
        let randomInterest = Int.random(in: 0 ... participants[randomParticipant].interest.count - 1)
        print ("My Name is \(participants[randomParticipant].name), I like \(participants[randomParticipant].interest[randomInterest].name), \(participants[randomParticipant].interest[randomInterest].properties)")
        
        storeShareOrder.append(randomParticipant)
    }
    
    print (storeShareOrder)
    
}


// MARK:- Function to find pairings (people with nothing in common)

func makePairs() {
    
    
    for participant in 0 ... participants.count - 1 {
            
            for secondParticipant in 0 ... participants.count - 1 {
                
                let person1 = participants[participant].name
                let person2 = participants[secondParticipant].name
                
                // Don't check a participant with itself.
                
                if person1 != person2 {
                    
                    // check if they don't have anything in common
                    
                    if !participants[participant].interest.contains(where: participants[secondParticipant].interest.contains) {
    
                        
                        // remove duplicates 
                        
                        if person1 < person2 {
                            
                        // create the pairings list.
                            
                        pairings.append([person1:person2])
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    
    // Display the pairings if any found
    
    
    print ("********************")
    print ("Found \(pairings.count) possible pairings")
    
    if pairings.count != 0 {
        
        for i in 0 ... (pairings.count) - 1 {
            
            print ("\(pairings[i])")
            
        }
        
    }
    
}


// MARK:- Return a number between 2 and 12 that is a multiple of 2

func getNumberOfParticipants() -> Int {
    
    var numberOfParticipants = 1
    while (!numberOfParticipants.isMultiple(of: 2)) {
        
        numberOfParticipants = Int.random(in: 2 ... 12)
    }
    return numberOfParticipants
}
    

var participants = generateParticipants()

iterateThroughInterests()

logIntroductions()

shareInterests()

makePairs()


