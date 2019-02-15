#!/usr/bin/newlisp

(define art [text]
            _______
        ___/       \___
     __/               \__
   _/                     \_
  /                         \
 |    ___________________    |
/     \ $f            ^ /     \
|      \ $s          & /      |
\       \_____________/       /
 |                           |
  \_                       _/
    \__                 __/
       \___         ___/
           \_______/

[/text])

; Seeds the random value
(seed (date-value))

; Generate a random number and assign it
(define num (first (randomize (rand 20 42))))

; Maybe find a web API with answers, store them in a list
; and get the num element from it
; Credit: https://en.wikipedia.org/wiki/Magic_8-Ball
(if
 ; TODO: Move these replacements to a function
 (= num 0)  (println (replace "$s" (replace "$f" (replace "^" (replace "&" art "\b\b\b\b\b\b\b") "\b\b\b\b\b\b\b") "     It is") "   certain"))
 (= num 1)  (println (replace "$s" (replace "$f" (replace "^" (replace "&" art "\b\b\b\b\b\b\b") "\b\b\b\b\b\b\b\b\b") "    As I see") "   it, yes"))
 (= num 2)  (println (replace "$s" (replace "$f" (replace "^" (replace "&" art "\b\b\b\b\b\b\b\b") "\b\b\b\b\b\b\b\b\b\b") "  Reply hazy,") "  try again"))
 (= num 3)  (println (replace "$s" (replace "$f" (replace "^" (replace "&" art "\b\b\b\b\b\b") "\b\b\b\b\b\b\b\b\b\b") "  Don't count") "    on it"))
 (= num 4)  (println (replace "$s" (replace "$f" (replace "^" (replace "&" art "\b\b\b\b\b\b\b\b\b") "\b\b\b\b\b\b\b") "     It is") "decidedly so"))
 (= num 5)  (println (replace "$s" (replace "$f" (replace "^" (replace "&" art "\b\b\b\b\b\b\b") "\b\b\b\b\b\b\b") "      Most") "    likely"))
 (= num 6)  (println (replace "$s" (replace "$f" (replace "^" (replace "&" art "\b\b\b\b\b\b") "\b\b\b\b\b\b\b\b\b") "   Ask again") "    later"))
 (= num 7)  (println (replace "$s" (replace "$f" (replace "^" (replace "&" art "\b\b\b\b\b\b") "\b\b\b\b\b\b\b\b\b") "    My reply") "    is no"))
 (= num 8)  (println (replace "$s" (replace "$f" (replace "^" (replace "&" art "\b\b\b\b\b\b") "\b\b\b\b\b\b\b\b\b") "   Without a") "    doubt"))
 (= num 9)  (println (replace "$s" (replace "$f" (replace "^" (replace "&" art "\b\b\b\b\b") "\b\b\b\b\b\b\b\b") "    Outlook") "    good"))
 (= num 10) (println (replace "$s" (replace "$f" (replace "^" (replace "&" art "\b\b\b\b\b\b\b\b\b") "\b\b\b\b\b\b\b\b\b\b") "   Better not") "tell you now"))
 (= num 11) (println (replace "$s" (replace "$f" (replace "^" (replace "&" art "\b\b\b\b\b\b") "\b\b\b\b\b\b\b\b\b\b") "   My sources") "   say no"))
 (= num 12) (println (replace "$s" (replace "$f" (replace "^" (replace "&" art "\b\b\b\b\b\b\b\b\b") "\b\b\b\b\b\b\b\b\b") "      Yes - ") "  definitely"))
 (= num 13) (println (replace "$s" (replace "$f" (replace "^" (replace "&" art " ") "\b\b\b\b\b\b") "      Yes") "  "))
 (= num 14) (println (replace "$s" (replace "$f" (replace "^" (replace "&" art "\b\b\b\b\b") "\b\b\b\b\b\b\b\b\b\b\b\b") " Cannot predict") "     now"))
 (= num 15) (println (replace "$s" (replace "$f" (replace "^" (replace "&" art "\b\b\b\b\b\b\b") "\b\b\b\b\b\b\b\b\b\b") "  Outlook not") "   so good"))
 (= num 16) (println (replace "$s" (replace "$f" (replace "^" (replace "&" art "\b\b\b\b\b\b") "\b\b\b\b\b\b\b\b\b\b\b") "  You may rely") "    on it"))
 (= num 17) (println (replace "$s" (replace "$f" (replace "^" (replace "&" art "\b\b\b\b\b\b") "\b\b\b\b\b\b\b\b\b\b") "  Signs point") "   to yes"))
 (= num 18) (println (replace "$s" (replace "$f" (replace "^" (replace "&" art "\b\b\b\b\b\b\b\b") "\b\b\b\b\b\b\b\b\b\b\b\b") "Concentrate and") "  ask again"))
 (= num 19) (println (replace "$s" (replace "$f" (replace "^" (replace "&" art "\b\b\b\b\b\b\b\b") "\b\b\b\b\b\b") "     Very") "   doubtful"))
)

; Exit the program
(exit)