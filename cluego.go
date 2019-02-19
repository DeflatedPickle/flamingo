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

func NewRoom(name, shortName string, width, height int, inventory []*Item) *Room {
	return &Room{
		name:      name,
		shortName: shortName,
		width:     width,
		height:    height,
		inventory: inventory,
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
	actions []Action
}

func NewPerson(name string, ai *AIController, room *Room) *Person {
	return &Person{
		name:        name,
		ai:          ai,
		alive:       true,
		murderer:    false,
		inventory:   []*Item{},
		currentRoom: room,
		actions:     []Action{},
	}
}

type Item struct {
	// The name of the item
	name string

	// The people that have held this item
	fingerPrints []*Person
}

func NewItem(name string) *Item {
	return &Item{
		name:         name,
		fingerPrints: []*Person{},
	}
}

type Time struct {
	hours   int
	minutes int
}

func (time *Time) String() string {
	return fmt.Sprintf("%02d:%02d", time.hours, time.minutes)
}

type Action interface {
}

type ActionMove struct {
	Action

	name       string
	happenedAt Time

	from *Room
	to   *Room

	direction int
}

func (action *ActionMove) String() string {
	return fmt.Sprintf("%s moved from the %s to the %s,", action.happenedAt.String(), action.from.name, action.to.name)
}

func NewActionMove(time Time, from, to *Room, direction int) *ActionMove {
	return &ActionMove{
		Action:     nil,
		name:       "Move",
		happenedAt: time,
		from:       from,
		to:         to,
		direction:  direction,
	}
}

type ActionItem struct {
	Action

	name       string
	happenedAt Time

	item *Item

	// True if it was picked up, false if it was put down
	pickedUp bool
}

func NewActionItem(time Time, item *Item, pickedUp bool) *ActionItem {
	return &ActionItem{
		Action:     nil,
		name:       "Item",
		happenedAt: time,
		item:       item,
		pickedUp:   pickedUp,
	}
}

func (action *ActionItem) String() string {
	if action.pickedUp {
		return fmt.Sprintf("%s picked up a %s,", action.happenedAt.String(), action.item.name)
	}
	return fmt.Sprintf("%s put down a %s,", action.happenedAt.String(), action.item.name)
}

func main() {
	// Set the clock
	hours := 12
	minutes := 00

	rand.Seed(time.Now().Unix())

	candelabra := NewItem("Candelabra")
	candelstick := NewItem("Candlestick")

	plate := NewItem("Plate")
	tableKnife := NewItem("Table Knife")
	fork := NewItem("Fork")

	wineGlass := NewItem("Wine Glass")

	kitchenKnife := NewItem("Kitchen Knife")

	pottedPlant := NewItem("Potted Plant")

	book := NewItem("Book")

	// Define the rooms of the house
	// TODO: Add hallways
	var house []*Room

	grandFoyer := NewRoom("Grand Foyer", "GF", 20, 32,
		[]*Item{&*candelabra, &*candelabra, &*candelstick})
	diningRoom := NewRoom("Dining Room", "DR", 28, 19,
		[]*Item{&*plate, &*plate, &*tableKnife, &*tableKnife, &*fork, &*fork, &*wineGlass, &*wineGlass})
	kitchen := NewRoom("Kitchen", "K", 12, 19,
		[]*Item{&*kitchenKnife})
	ballroom := NewRoom("Ballroom", "BR", 38, 28,
		[]*Item{&*pottedPlant, &*candelabra})
	library := NewRoom("Library", "L", 38, 28,
		[]*Item{&*book, &*book, &*book, &*candelstick, &*candelstick})
	conservatory := NewRoom("Conservatory", "C", 19, 19,
		[]*Item{&*pottedPlant})

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
		for minutes < 60 {
			fmt.Printf("\nThe clock strikes %02d:%02d PM.\n", hours, minutes)

			// Generate a number for the actions people could do,
			// check if they can do it,
			// then roll a dice to see if they do it
			for _, peep := range people {
				// Skip if they're dead
				if !peep.alive {
					continue
				}

				action := rand.Intn(9)
				willDo := rand.Intn(6)
				// fmt.Println("--------", action, willDo)

				// Non-Event-Based Actions:
				// 0..2 - Nothing
				// 3 - Move rooms, north
				// 4 - Move rooms, east
				// 5 - Move rooms, south
				// 6 - Move rooms, west
				// 7 - Pick up an item
				// 8 - Put down an item

				nothingMax := 2

				switch {
				case 0 <= action && action <= nothingMax:
					// Do nothing
				case action == nothingMax + 1:
					// Skip if the dice roll was 0 or 5
					// Helps thin down the amount of action's by a smidgen
					if willDo == 0 || willDo == 5 {
						continue
					}

					if peep.currentRoom.roomNorth != nil {
						oldRoom := peep.currentRoom

						peep.currentRoom = peep.currentRoom.roomNorth
						fmt.Printf("The %s leaves the %s and enters the %s.\n", peep.name, oldRoom.name, peep.currentRoom.name)
						peep.actions = append(peep.actions, NewActionMove(Time{hours: hours, minutes: minutes}, oldRoom, peep.currentRoom, 0))
					}
				case action == nothingMax + 2:
					// Skip if the dice roll was 0 or 5
					// Helps thin down the amount of action's by a smidgen
					if willDo == 0 || willDo == 5 {
						continue
					}

					if peep.currentRoom.roomEast != nil {
						oldRoom := peep.currentRoom

						peep.currentRoom = peep.currentRoom.roomEast
						fmt.Printf("The %s leaves the %s and enters the %s.\n", peep.name, oldRoom.name, peep.currentRoom.name)
						peep.actions = append(peep.actions, NewActionMove(Time{hours: hours, minutes: minutes}, oldRoom, peep.currentRoom, 1))
					}
				case action == nothingMax + 3:
					// Skip if the dice roll was 0 or 5
					// Helps thin down the amount of action's by a smidgen
					if willDo == 0 || willDo == 5 {
						continue
					}

					if peep.currentRoom.roomSouth != nil {
						oldRoom := peep.currentRoom

						peep.currentRoom = peep.currentRoom.roomSouth
						fmt.Printf("The %s leaves the %s and enters the %s.\n", peep.name, oldRoom.name, peep.currentRoom.name)
						peep.actions = append(peep.actions, NewActionMove(Time{hours: hours, minutes: minutes}, oldRoom, peep.currentRoom, 2))
					}
				case action == nothingMax + 4:
					// Skip if the dice roll was 0 or 5
					// Helps thin down the amount of action's by a smidgen
					if willDo == 0 || willDo == 5 {
						continue
					}

					if peep.currentRoom.roomWest != nil {
						oldRoom := peep.currentRoom

						peep.currentRoom = peep.currentRoom.roomWest
						fmt.Printf("The %s leaves the %s and enters the %s.\n", peep.name, oldRoom.name, peep.currentRoom.name)
						peep.actions = append(peep.actions, NewActionMove(Time{hours: hours, minutes: minutes}, oldRoom, peep.currentRoom, 3))
					}
				case action == nothingMax + 5:
					// Skip if the dice roll was 2 or 3
					// Helps thin down the amount of action's by a smidgen
					if willDo == 2 || willDo == 3 {
						continue
					}

					// Is their inventory not full?
					if len(peep.inventory) < 4 {
						roomInventory := peep.currentRoom.inventory

						index := rand.Intn(len(roomInventory))
						item := roomInventory[index]

						// Add the item to the persons' inventory
						peep.inventory = append(peep.inventory, item)
						// Remove the item from the rooms' inventory
						roomInventory = append(roomInventory[:index], roomInventory[index+1:]...)

						fmt.Printf("The %s picks up a %s.\n", peep.name, item.name)
						peep.actions = append(peep.actions, NewActionItem(Time{hours: hours, minutes: minutes}, item, true))

						item.fingerPrints = append(item.fingerPrints, peep)
					}
				case action == nothingMax + 6:
					// Skip if the dice roll was 2 or 3
					// Helps thin down the amount of action's by a smidgen
					if willDo == 2 || willDo == 3 {
						continue
					}

					// Do they have any items?
					if len(peep.inventory) > 0 {
						roomInventory := peep.currentRoom.inventory

						index := rand.Intn(len(peep.inventory))
						item := peep.inventory[index]

						// Remove the item from the persons' inventory
						peep.inventory = append(peep.inventory[:index], peep.inventory[index+1:]...)
						// Add the item to the room' inventory
						roomInventory = append(roomInventory, item)

						fmt.Printf("The %s put down a %s.\n", peep.name, item.name)
						peep.actions = append(peep.actions, NewActionItem(Time{hours: hours, minutes: minutes}, item, false))
					}
				}
			}

			// Increase the minutes
			minutes += 5
		}

		// Increase the hours
		minutes = 0
		hours++
	}
	for _, peep := range people {
		fmt.Printf("\nThe actions %s took are as follows; %v", peep.name, peep.actions)
	}
}
