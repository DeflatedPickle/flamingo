package main

// A basic room with-in the house
type Room struct {
	// The name of the room
	name string

	// The size of the room
	width  int
	height int

	// The room' inventory
	inventory []*Item

	// The rooms to each side of this room
	nextToEast  *Room
	nextToWest  *Room
	nextToNorth *Room
	nextToSouth *Room
}

// An AI controller for people
type AIController struct {
	// The likeliness that this person will murder another
	murderLikeliness int

	// How sociable this person is -- if it's low, they're unlikely to talk
	// to anyone, and the others might not even learn of their existence
	sociability int
}

// A person to interact with rooms in the house
type Person struct {
	// The name of the person
	name string

	// Whether or not this person is alive
	alive bool

	// Whether or not this person is the murderer (changed after they murder)
	murderer bool

	// The inventory of the person
	inventory []*Item

	// The room the person is currently in
	currentRoom *Room
}

type Item struct {
	// The name of the item
	name string
}

func main() {
	// Set the clock
	var clock = 0

	// Define the people attending the party
	var people = []*Person{
		&Person{name: "Lady Livesalot"},
	}

	// Define the rooms of the house
	var rooms = []*Room{
		&Room{name: "Entry Hall"},
		&Room{name: "Dining Room"},
		&Room{name: "Kitchen"},
	}

	// Everyone starts off in the entry hall
	for _, peep := range people {
		peep.currentRoom = rooms[0]
	}

	// Update the game
	for clock > 1000 {
		clock++
	}
}
