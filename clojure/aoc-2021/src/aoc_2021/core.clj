(ns aoc-2021.core
  (:gen-class)
  (:require [clojure.string :as str]))


(defn comma-separated-to-something [s] 
  (map read-string (str/split s #",")))

(defn bingo-board [s]
  (let [strings (filter (complement str/blank?) (str/split s #"\D"))
        numbers (map read-string strings)]
  { :numbers numbers :marked #{}}
  ))

(defn mark [board number]
  (let [locations (keep-indexed #(if (= number %2) %1) (:numbers board))]
    {:numbers (:numbers board) :marked (into (:marked board) locations)}))

(defn parse-bingo [s]
  (let [ splittery (str/split s #"\n" 2)
         numbers (comma-separated-to-something (first splittery))
         stuff (str/split (first (rest splittery)) #"\n\n")
         ]
    [numbers (map bingo-board stuff)])
    )

(definterface IBingoMarkable
  (mark [x y])
  (complete?)
  )

(definterface IBingoScorable
  (score)
  )


(defn day4-1 []
  (println "Day 4 part 1")
  (let [
        text (slurp "resources/day4.txt")
        [numbers2 boards] (parse-bingo text)
        ]
    (prn boards)
(println "AAA")
    (prn (map #(mark % 92) boards))
(println "BBB")
    (prn (map #(mark % 12) (map #(mark % 92) boards)))
  )
  )

(defn -main
  "Advent of Code 2021"
  [& args]
  (println "Hello, Advent of Code 2021!")
  (day4-1))

