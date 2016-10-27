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


// calculate the number of players in each team
let playersPerTeam = listOfPlayers.count / listOfTeams.count

// iterate through the teams' players, looking at the equivalent roster position across the teams
// if we detect an imbalance we will repeatedly swap players around as we walk down the rosters
// until it is balanced or until we reach the end of the rosters
for rosterPosition in 0..<playersPerTeam {
    
    /////////////////////////////////////////////////////////////////////////
    // Step A - tally the heights for each team and put them in an array
    
    var heightTallies: [Int] = []
    
    // iterate through the teams
    for team in listOfTeams {
        
        // initialize the tally to zero
        var tally = 0
        
        // get the array of players for the team
        if let players = team[teamPlayersKey] as? [[String:Any]] {
            
            // iterate through the players
            for player in players {
                
                // get the players height
                if let height = player[playerHeightKey] as? Int {
                    
                    // add it to the tally
                    tally += height
                }
            }
        }
        
        // append this tally to an array that corresponds to the list of teams
        heightTallies.append(tally)
    }
    
    
    /////////////////////////////////////////////////////////////////////////
    // Step B - compare the average heights to see if there is an imbalance
    
    // these willl capture which teams have the highest and lowest average heights
    var teamWithTheLowestAverageHeight: Int?
    var teamWithTheHighestAverageHeight: Int?
    
    // if this gets set to true then we move on to the swapping players logic
    var imbalanceFound = false
    
    // to keep track of the highest and lowest averages across all the teams for comparison purposes
    var lowestAverage = 0.0
    var highestAverage = 0.0
    
    // iterate through the tallies
    for tallyIndex in 0..<heightTallies.count {
        
        // get the tally at this index
        let tally = heightTallies[tallyIndex]
        
        // calculate the average height
        let averageHeightForThisTeam = Double(tally / playersPerTeam)
        
        // first time we get here these optionals will not have been set, so just
        // setting initial values for subsequent comparisons
        if teamWithTheLowestAverageHeight == nil ||
            teamWithTheHighestAverageHeight == nil {
            
            teamWithTheLowestAverageHeight = tallyIndex
            lowestAverage = averageHeightForThisTeam
            teamWithTheHighestAverageHeight = tallyIndex
            highestAverage = averageHeightForThisTeam
        }
        
        
        // compare this average to the lowest average so far
        if averageHeightForThisTeam - lowestAverage > 1.5 {
            
            // significantly different averageHeight
            imbalanceFound = true
        }
        
        // compare this average to the highest average so far
        if highestAverage - averageHeightForThisTeam > 1.5 {
            
            // significantly different averageHeight
            imbalanceFound = true
        }
        
        // capture whether this average height is the lowest so far
        if averageHeightForThisTeam < lowestAverage {
            teamWithTheLowestAverageHeight = tallyIndex
            lowestAverage = averageHeightForThisTeam
        }
        
        // capture whether this average height is the highest so far
        if averageHeightForThisTeam > highestAverage {
            teamWithTheHighestAverageHeight = tallyIndex
            highestAverage = averageHeightForThisTeam
        }
    }
    
    
    /////////////////////////////////////////////////////////////////////////
    // Step C - if there is an imbalance then try swapping the highest and lowest players around
    
    if imbalanceFound {
        
        // protecting against nil values here
        if teamWithTheLowestAverageHeight != nil &&
            teamWithTheHighestAverageHeight != nil {
            
            // safe to use the bang operator
            let highest = teamWithTheHighestAverageHeight!
            let lowest = teamWithTheLowestAverageHeight!
            
            print("Imbalance found. Highest: \(highest), lowest \(lowest)")
            
            // checking there is really work to do and that these values are within the bounds of our array
            if highest != lowest &&
                listOfTeams.indices.contains(highest) &&
                listOfTeams.indices.contains(lowest) {
                
                // fetch the appropriate team dictionaries from the list of teams
                var lowTeamDict = listOfTeams[lowest]
                var highTeamDict = listOfTeams[highest]
                
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
                    listOfTeams[lowest] = lowTeamDict
                    listOfTeams[highest] = highTeamDict
                }
            }
        }
        
    } else {
        
        // no imbalance move on
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
