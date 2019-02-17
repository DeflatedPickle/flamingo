package main

import (
	"fmt"
	"math/rand"
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
func (room Room) positionRoom(rooms ...*Room) {
	room.roomNorth = rooms[0]
	room.roomEast = rooms[1]
	room.roomSouth = rooms[2]
	room.roomWest = rooms[3]
}

// An AI controller for people
type AIController struct {
	// The likeliness that this person will murder another
	murderLikeliness int

	// How sociable this person is -- if it's low, they're unlikely to talk
	// to anyone, and the others might not even learn of their existence
	sociability int
}

func NewAIController() *AIController {
	return &AIController{
		murderLikeliness: rand.Intn(1000),
		sociability:      0,
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
}

func NewPerson(name string, ai *AIController, room *Room) *Person {
	return &Person{
		name:        name,
		ai:          ai,
		alive:       true,
		murderer:    false,
		inventory:   []*Item{},
		currentRoom: room,
	}
}

type Item struct {
	// The name of the item
	name string
}

func main() {
	// Set the clock
	clock := 12.00

	rand.Seed(42)

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

	// Loop the game for 12 hours,
	// the murder should happen after 8 hours
	// and then some more actions might happen, to help confuse things
	for clock < 24.00 {
		fmt.Printf("Time: %f\n", clock)

		// Generate a number for the actions people could do,
		// check if they can do it,
		// then roll a dice to see if they do it
		for _, peep := range people {
			fmt.Println(peep.name)
		}

		// Increase the clock by a minute
		clock += 00.10
	}
}
