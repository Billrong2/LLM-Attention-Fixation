import scala.math._
import scala.collection.mutable._
object Problem {
    def f(data : Map[String,List[String]]) : List[String] = {
        var members = List[String]()
        for ((key, value) <- data) {
            for (member <- value) {
                if (!members.contains(member)) {
                    members = members :+ member
                }
            }
        }
        return members.sorted
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,List[String]]("inf" -> List[String]("a", "b"), "a" -> List[String]("inf", "c"), "d" -> List[String]("inf")))).equals((List[String]("a", "b", "c", "inf"))));
    }

}
