// Toby J Morgan
// 2016.10.20
// SoccerLeagueCoordinator
// Team Treehouse Project Assignment

import Foundation


////////////////////////////////////
// PART 1
////////////////////////////////////

// create dictionary key constants for player dictionaries (to prevent typo errors)
let playerNameKey = "Name"
let playerHeightKey = "Height"
let playerExperienceKey = "Experience"
let playerGuardianKey = "Guardians"

// create an array of player dictionaries
// could have used structs or classes here
let listOfPlayers = [
    [playerNameKey : "Joe Smith",             playerHeightKey : 42, playerExperienceKey : true,  playerGuardianKey: "Jim and Jan Smith"],
    [playerNameKey : "Jill Tanner",           playerHeightKey : 36, playerExperienceKey : true,  playerGuardianKey: "Clara Tanner"],
    [playerNameKey : "Bill Bon",              playerHeightKey : 43, playerExperienceKey : true,  playerGuardianKey: "Sara and Jenny Bon"],
    [playerNameKey : "Eva Gordon",            playerHeightKey : 45, playerExperienceKey : false, playerGuardianKey: "Wendy and Mike Gordon"],
    [playerNameKey : "Matt Gill",             playerHeightKey : 40, playerExperienceKey : false, playerGuardianKey: "Charles and Sylvia Gill"],
    [playerNameKey : "Kimmy Stein",           playerHeightKey : 41, playerExperienceKey : false, playerGuardianKey: "Bill and Hillary Stein"],
    [playerNameKey : "Sammy Adams",           playerHeightKey : 45, playerExperienceKey : false, playerGuardianKey: "Jeff Adams"],
    [playerNameKey : "Karl Saygan",           playerHeightKey : 42, playerExperienceKey : true,  playerGuardianKey: "Heather Bledsoe"],
    [playerNameKey : "Suzane Greenberg",      playerHeightKey : 44, playerExperienceKey : true,  playerGuardianKey: "Henrietta Dumas"],
    [playerNameKey : "Sal Dali",              playerHeightKey : 41, playerExperienceKey : false, playerGuardianKey: "Gala Dali"],
    [playerNameKey : "Joe Kavalier",          playerHeightKey : 39, playerExperienceKey : false, playerGuardianKey: "Sam and Elaine Kavalier"],
    [playerNameKey : "Ben Finkelstein",       playerHeightKey : 44, playerExperienceKey : false, playerGuardianKey: "Aaron and Jill Finkelstein"],
    [playerNameKey : "Diego Soto",            playerHeightKey : 41, playerExperienceKey : true,  playerGuardianKey: "Robin and Sarika Soto"],
    [playerNameKey : "Chloe Alaska",          playerHeightKey : 47, playerExperienceKey : false, playerGuardianKey: "David and Jamie Alaska"],
    [playerNameKey : "Arnold Willis",         playerHeightKey : 43, playerExperienceKey : false, playerGuardianKey: "Claire Willis"],
    [playerNameKey : "Phillip Helm",          playerHeightKey : 44, playerExperienceKey : true,  playerGuardianKey: "Thomas Helm and Eva Jones"],
    [playerNameKey : "Les Clay",              playerHeightKey : 42, playerExperienceKey : true,  playerGuardianKey: "Wynonna Brown"],
    [playerNameKey : "Herschel Krustofski",   playerHeightKey : 45, playerExperienceKey : true,  playerGuardianKey: "Hyman and Rachel Krustofski"]
]



////////////////////////////////////
// PART 2
////////////////////////////////////

// create dictionary key constants for team dictionaries (to prevent typo errors)
let teamPlayersKey = "Players"
let teamNameKey = "Team Name"
let teamPracticeTimeKey = "Practice Time"

// create an array of team dictionaries

// N.B. I chose to avoid hard-coding the number of teams to 3.
//      Instead I create an array of team dictionaries, so the number of teams
//      can change in the future.

// could have used structs or classes here
var listOfTeams: [[String:Any]] = [
    [teamPlayersKey : [], teamNameKey : "Dragons", teamPracticeTimeKey : "March 17, 1pm"],
    [teamPlayersKey : [], teamNameKey : "Sharks", teamPracticeTimeKey : "March 17, 3pm"],
    [teamPlayersKey : [], teamNameKey : "Raptors", teamPracticeTimeKey : "March 18, 1pm"]]


// this function distributes players to each of the teams, one-by-one
// parameters: experienced - allows us to distribute just experienced or inexperienced players
//             startingWithTeam - allows us start at a particular team, just in case players
//                                were not evenly distributed last time the funciton was called
// returns: Int - which tells the caller which team will be due a player next time the function
//                is called
func distributePlayers(experienced: Bool, startingWithTeam: Int) -> Int {
    
    // a counter to determine which team should get the next player
    // set to desired starting team index
    var nextTeamToGetPlayer = startingWithTeam
    
    // bounds check on counter value
    if nextTeamToGetPlayer < 0 || nextTeamToGetPlayer >= listOfTeams.count {
        nextTeamToGetPlayer = 0
    }
    
    // could have used filter statements here
    
    // iterate through the list of players
    for player in listOfPlayers {
        
        // get the experienced value from the player dictionary
        // could have used a guard satement here
        if let isExperienced = player[playerExperienceKey] as? Bool {
            
            if isExperienced == experienced {
                
                // fetch the appropriate team dictionary from the list of teams
                var teamDict = listOfTeams[nextTeamToGetPlayer]
                
                // fetch the players array for that team
                if let players = teamDict[teamPlayersKey] as? [[String:Any]] {
                    
                    // add the new player to the players array of the team dictionary (value type)
                    teamDict[teamPlayersKey] = players + [player]
                    
                    // assign this as the new dictionary for this team (value type)
                    listOfTeams[nextTeamToGetPlayer] = teamDict
                }
                
                // increment the counter to point to the next team
                nextTeamToGetPlayer += 1
                
                // check if the counter exceeds the number of teams, if so reset to the first team
                if nextTeamToGetPlayer >= listOfTeams.count {
                    nextTeamToGetPlayer = 0
                }
            }
            
        } else {
            
            print("Oops! Problem processing player data: value for '\(playerExperienceKey)' not found.")
        }
    }

    return nextTeamToGetPlayer
}


if listOfPlayers.count % listOfTeams.count != 0 {
    
    print("Oops! \(listOfPlayers.count) players cannot be evenly distributed across \(listOfTeams.count) teams.")
    
} else {
    
    // distribute experienced players to the teams first
    let nextTeam = distributePlayers(experienced: true, startingWithTeam: 0)
    
    // distribute inexperienced players to the teams next
    distributePlayers(experienced: false, startingWithTeam: nextTeam)
}




//////////////////////////////////////
// PART 2 - Exceeds Expectations Part
//////////////////////////////////////

// look to see if we have an imbalance in the average players height between teams


// function to get the average height of an array of players
func getAverageHeightOfPlayers(players: [[String:Any]]) -> Double {
    
    var tally = 0.0
    
    for player in players {
        
        // get the players height
        if let height = player[playerHeightKey] as? Int {
            
            // add it to the tally
            tally += Double(height)
        }
    }
    
    return tally / Double(players.count)
}



// calculate the number of players in each team
let playersPerTeam = listOfPlayers.count / listOfTeams.count

// walk through the roster
// for each iteration, we will determine if there is an imbalance in the average heights
// and if so, try swapping the tallest and shortest player at that roster position
for rosterPosition in 0..<playersPerTeam {
    
    // create an array for capturing the current average height of each team
    var averageTeamHeights = [Double]()
    
    for team in listOfTeams {
        
        // get the array of players for this team
        if let players = team[teamPlayersKey] as? [[String:Any]] {
            
            // capture the calculated average height in our array
            averageTeamHeights.append(getAverageHeightOfPlayers(players: players))
        }
    }
    
    // now we will compare the teams to see which are the tallest and shortest teams
    var shortestTeamIndex: Int?
    var tallestTeamIndex: Int?
    
    for teamIndex in 0..<averageTeamHeights.count {
        
        // fetch this team's average height from the array
        let averageHeightForThisTeam = averageTeamHeights[teamIndex]
        
        if shortestTeamIndex == nil {
            
            // this is the first iteration, so set this team's index as a starting point
            shortestTeamIndex = teamIndex
            tallestTeamIndex = teamIndex
        }
        
        // compare to see if this team is the shortest
        if averageHeightForThisTeam < averageTeamHeights[shortestTeamIndex!] {
            shortestTeamIndex = teamIndex
        }
        
        // compare to see if this team is the tallest
        if averageHeightForThisTeam > averageTeamHeights[tallestTeamIndex!] {
            tallestTeamIndex = teamIndex
        }
    }
    
    // check to see:
    //    - our optionals have values
    //    - they are different teams
    //    - that there is an unacceptable imbalance
    if let shortestTeamIndex = shortestTeamIndex,
        let tallestTeamIndex = tallestTeamIndex,
        shortestTeamIndex != tallestTeamIndex &&
        averageTeamHeights[shortestTeamIndex] < averageTeamHeights[tallestTeamIndex] - 1.5 {
            
        // we have an unacceptable height imbalance
        
        print("Imbalance found. Highest: \(tallestTeamIndex), lowest \(shortestTeamIndex)")
        
        
        // fetch the appropriate team dictionaries from the list of teams
        var lowTeamDict = listOfTeams[shortestTeamIndex]
        var highTeamDict = listOfTeams[tallestTeamIndex]
        
        // fetch the players array for those teams
        if var lowTeamPlayers = lowTeamDict[teamPlayersKey] as? [[String:Any]],
            var highTeamPlayers = highTeamDict[teamPlayersKey] as? [[String:Any]] {
            
            // remove and capture the players at this roster position
            let playerOnShortTeam = lowTeamPlayers.remove(at: rosterPosition)
            let playerOnTallTeam = highTeamPlayers.remove(at: rosterPosition)
            
            // swap them
            lowTeamPlayers.insert(playerOnTallTeam, at: rosterPosition)
            highTeamPlayers.insert(playerOnShortTeam, at: rosterPosition)
            
            // replace rosters with updated arrays (value types)
            lowTeamDict[teamPlayersKey] = lowTeamPlayers
            highTeamDict[teamPlayersKey] = highTeamPlayers
            
            // replace team dictionaries with updated dictionaries (value types)
            listOfTeams[shortestTeamIndex] = lowTeamDict
            listOfTeams[tallestTeamIndex] = highTeamDict
        }
        
    } else {
        
        // if we get here, either something went wrong (one or zero number of teams for example)
        // or there is no imbalance between average team heights and our work is done
        // either way, we want to break out
        break
    }
}


////////////////////////////////////
// PART 3
////////////////////////////////////

var letters = [String]()

for team in listOfTeams {
    
    // get the details from the team dictionary
    // could have used a guard satement here
    if let teamName = team[teamNameKey] as? String,
        let practiceTime = team[teamPracticeTimeKey] as? String,
        let players = team[teamPlayersKey] as? [ [String : Any] ] {
        
        // iterate through the players on the team
        for player in players {
            
            // get the player details
            // could have used a guard satement here
            if let playerName = player[playerNameKey] as? String,
                let playerGuardians = player[playerGuardianKey] as? String {
                
                letters.append("Dear \(playerGuardians),\n\nI am writing to let you know that \(playerName) has been selected to play for the \(teamName) soccer team. Our practice time will be \(practiceTime) at Wembley Stadium.\n\nLooking forward to seeing your child there.\n\nYours sincerely,\n\nDavid Beckham\n")
                
            } else {
                
                print("Oops! There was a problem reading player data whilst generating letters.")
            }
        }
        
    } else {
        
        print("Oops! There was a problem with the letter data")
    }
}

letters
