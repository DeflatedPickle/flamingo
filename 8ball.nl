#!/usr/bin/newlisp

; TODO: Add ASCII art for the 8-ball

; Seeds the random value
(seed (date-value))

; Generate a random number and assign it
(define num (first (randomize (rand 20 42))))

; Maybe find a web API with answers, store them in a list
; and get the num element from it
; Credit: https://en.wikipedia.org/wiki/Magic_8-Ball
(if
 (= num 0)  (println "It is certain.")
 (= num 1)  (println "As I see it, yes.")
 (= num 2)  (println "Reply hazy, try again.")
 (= num 3)  (println "Don't count on it.")
 (= num 4)  (println "It is decidedly so.")
 (= num 5)  (println "Most likely.")
 (= num 6)  (println "Ask again later.")
 (= num 7)  (println "My reply is no.")
 (= num 8)  (println "Without a doubt.")
 (= num 9)  (println "Outlook good.")
 (= num 10) (println "Better not tell you now.")
 (= num 11) (println "My sources say no.")
 (= num 12) (println "Yes - definitely.")
 (= num 13) (println "Yes.")
 (= num 14) (println "Cannot predict now.")
 (= num 15) (println "Outlook not so good.")
 (= num 16) (println "You may rely on it.")
 (= num 17) (println "Signs point to yes.")
 (= num 18) (println "Concentrate and ask again.")
 (= num 19) (println "Very doubtful."))

; Exit the program
(exit)