package main

import (
	"fmt"
	"math/rand"
	"time"
)

// A basic room with-in the house
type Room struct {
	// The name of the room
	name string

	// This name is used to label the room on the map
	shortName string

	// The size of the room
	width  int
	height int

	// The room' inventory
	inventory []*Item

	// The rooms to each side of this room
	roomEast  *Room
	roomWest  *Room
	roomNorth *Room
	roomSouth *Room
}

func NewRoom(name, shortName string, width, height int) *Room {
	return &Room{
		name:      name,
		shortName: shortName,
		width:     width,
		height:    height,
		inventory: []*Item{},
		roomEast:  nil,
		roomWest:  nil,
		roomNorth: nil,
		roomSouth: nil,
	}
}

// Position the room besides 4 others, in the order; north, east, south and west
func (room *Room) positionRoom(rooms ...*Room) {
	room.roomNorth = rooms[0]
	room.roomEast = rooms[1]
	room.roomSouth = rooms[2]
	room.roomWest = rooms[3]
}

// An AI controller for people
type AIController struct {
	// The likeliness that this person will murder another
	murderLikeliness int

	// Complications
	// These are character traits that will affect the actions people do, and their response to others
	// They might also give them motives to murder someone, or be blamed for murder

	// How sociable this person is -- if it's low, they're unlikely to talk
	// to anyone, and the others might not even learn of their existence, if it's high,
	// most of the people will know of them by the time of the murder
	sociability int
	// How anxious this person is -- if it's low, they'll be more happy around
	// others, and if it's high, they'll try to avoid crowds
	anxiety int
	// How much this person likes to hold onto objects -- if it's low, they won't mind
	// dropping their objects, and if it's high, they'll try to hold onto it,
	// even if it's the murder weapon
	hoarding int
}

func NewAIController() *AIController {
	return &AIController{
		murderLikeliness: rand.Intn(100),
		sociability:      0,
		anxiety:          0,
	}
}

// A person to interact with rooms in the house
type Person struct {
	// The name of the person
	name string

	// The AI attached to this person
	ai *AIController

	// Whether or not this person is alive
	alive bool

	// Whether or not this person is the murderer (changed after they murder)
	murderer bool

	// The inventory of the person
	inventory []*Item

	// The room the person is currently in
	currentRoom *Room

	// The actions this person has done over the night
	actions []string
}

func NewPerson(name string, ai *AIController, room *Room) *Person {
	return &Person{
		name:        name,
		ai:          ai,
		alive:       true,
		murderer:    false,
		inventory:   []*Item{},
		currentRoom: room,
		actions:     []string{},
	}
}

type Item struct {
	// The name of the item
	name string
}

func main() {
	// Set the clock
	minutes := 00
	hours := 12

	rand.Seed(time.Now().Unix())

	// Define the rooms of the house
	// TODO: Add hallways
	var house []*Room

	grandFoyer := NewRoom("Grand Foyer", "GF", 20, 32)
	diningRoom := NewRoom("Dining Room", "DR", 28, 19)
	kitchen := NewRoom("Kitchen", "K", 12, 19)
	ballroom := NewRoom("Ballroom", "BR", 38, 28)
	library := NewRoom("Library", "L", 38, 28)
	conservatory := NewRoom("Conservatory", "C", 19, 19)

	house = append(house, grandFoyer, diningRoom, kitchen, ballroom, library, conservatory)

	// Position the rooms in the house
	grandFoyer.positionRoom(nil, ballroom, nil, diningRoom)
	diningRoom.positionRoom(kitchen, grandFoyer, nil, nil)
	kitchen.positionRoom(nil, nil, diningRoom, nil)
	ballroom.positionRoom(conservatory, nil, library, nil)
	library.positionRoom(ballroom, nil, nil, nil)
	conservatory.positionRoom(nil, nil, ballroom, nil)

	// Define the people attending the party
	people := []*Person{
		NewPerson("Baron", NewAIController(), grandFoyer),
		NewPerson("Baroness", NewAIController(), grandFoyer),
		NewPerson("Duchess", NewAIController(), grandFoyer),
		NewPerson("Count", NewAIController(), grandFoyer),
		NewPerson("Colonel", NewAIController(), grandFoyer),
	}

	for _, peep := range people {
		fmt.Printf("The %s enters the grand foyer, with a likelyness to murder of %d%%.\n", peep.name, peep.ai.murderLikeliness)
	}

	// Loop the game for 12 hours,
	// the murder should happen after 8 hours
	// and then some more actions might happen, to help confuse things
	for hours < 24 {
		for minutes <= 60 {
			fmt.Printf("\nThe clock strikes %02d:%02d PM.\n", hours, minutes)

			// Generate a number for the actions people could do,
			// check if they can do it,
			// then roll a dice to see if they do it
			for _, peep := range people {
				if !peep.alive {
					continue
				}

				action := rand.Intn(5)
				willDo := rand.Intn(6)

				if willDo == 1 || willDo == 6 {
					continue
				}

				// Non-Event-Based Actions:
				// 0 - Move rooms north
				// 1 - Move rooms east
				// 2 - Move rooms south
				// 3 - Move rooms west
				// 4 - Pick up item
				// 5 - Put down item

				switch action {
				case 0:
					if peep.currentRoom.roomNorth != nil {
						peep.currentRoom = peep.currentRoom.roomNorth
						fmt.Printf("The %s enters the %s.\n", peep.name, peep.currentRoom.name)
					}
				case 1:
					if peep.currentRoom.roomEast != nil {
						peep.currentRoom = peep.currentRoom.roomEast
						fmt.Printf("The %s enters the %s.\n", peep.name, peep.currentRoom.name)
					}
				case 2:
					if peep.currentRoom.roomSouth != nil {
						peep.currentRoom = peep.currentRoom.roomSouth
						fmt.Printf("The %s enters the %s.\n", peep.name, peep.currentRoom.name)
					}
				case 3:
					if peep.currentRoom.roomWest != nil {
						peep.currentRoom = peep.currentRoom.roomWest
						fmt.Printf("The %s enters the %s.\n", peep.name, peep.currentRoom.name)
					}
				case 4:
				case 5:
				}
			}

			// Increase the minutes
			minutes += 5
		}

		// Increase the hours
		minutes = 0
		hours++
	}
}
