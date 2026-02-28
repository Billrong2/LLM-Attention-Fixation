import scala.math._
import scala.collection.mutable._
object Problem {
    def f(fruits : List[String]) : List[String] = {
        if (fruits.last == fruits.head) {
            return List("no")
        } else {
            fruits.drop(2).dropRight(2)
        }
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("apple", "apple", "pear", "banana", "pear", "orange", "orange"))).equals((List[String]("pear", "banana", "pear"))));
    }

}
