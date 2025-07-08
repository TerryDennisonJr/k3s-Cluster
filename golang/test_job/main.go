package main

import (
	"fmt"
	"os"
	"time"
)

func main() {
	count := 5
	// sleeper := "sleep 10"
	for i := 0; i < count; i++ {
		cwd, err := os.Getwd()
		if err != nil {
			fmt.Print("Error reading directory")
		}
		fmt.Println("Hello World Terry! from " + cwd)
		time.Sleep(5 * time.Second)

	}

}
