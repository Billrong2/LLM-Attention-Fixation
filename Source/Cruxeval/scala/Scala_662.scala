import scala.math._
import scala.collection.mutable._
object Problem {
    def f(values : List[String]) : List[String] = {
        var names = List("Pete", "Linda", "Angela")
        names = names ::: values
        names = names.sorted
        names
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("Dan", "Joe", "Dusty"))).equals((List[String]("Angela", "Dan", "Dusty", "Joe", "Linda", "Pete"))));
    }

}
