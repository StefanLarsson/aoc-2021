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

(defn row-col-to-index 
  [row col] (+ (* 5 row) col))

(defn bingo-row? [board row]
  (every? #(contains? (:marked board) %) (map (partial row-col-to-index row) (range 5))))

(defn bingo-col? [board col]
  (every? #(contains? (:marked board) %) (map #(row-col-to-index % col) (range 5))))

(defn mark-all [number boards]
  (map #(mark % number) boards))

(defn day4-1 []
  (println "Day 4 part 1")
  (let [
        text (slurp "resources/day4.txt")
        [numbers2 boards] (parse-bingo text)
        marked-boards (reductions #(mark-all %2 %1) boards numbers2)]
    (prn boards)
    (println "AAA")
    (prn (take 2 marked-boards)) 
  )
  )

(defn -main
  "Advent of Code 2021"
  [& args]
  (println "Hello, Advent of Code 2021!")
  (day4-1))

