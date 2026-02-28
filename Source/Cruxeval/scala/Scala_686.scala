import scala.math._
import scala.collection.mutable._
object Problem {
    def f(d : Map[String,Long], l : List[String]) : Map[String,Long] = {
        var new_d = Map[String, Long]()

        for (k <- l) {
            if (d.contains(k)) {
                new_d = new_d + (k -> d(k))
            }
        }

        new_d
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,Long]("lorem ipsum" -> 12l, "dolor" -> 23l)), (List[String]("lorem ipsum", "dolor"))).equals((Map[String,Long]("lorem ipsum" -> 12l, "dolor" -> 23l))));
    }

}
