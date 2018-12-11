(ns the-joy-of-clojure.basics-test
  (:require [clojure.test :refer :all]
            [the-joy-of-clojure.basics :refer :all]))


(testing "Recursion"
  (deftest sum-down-from-test
    (is (= 0 (sum-down-from 0 0)))
    (is (= 5 (sum-down-from 4 1)))
    (is (= 6 (sum-down-from 0 3)))))

(run-tests)