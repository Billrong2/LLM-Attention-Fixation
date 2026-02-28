import scala.math._
import scala.collection.mutable._
object Problem {
    def f(a : Map[String,List[String]], b : Map[String,String]) : Map[String,List[String]] = {
        for ((key, value) <- b) {
            if (!a.contains(key)) {
                a += (key -> List(value))
            } else {
                a += (key -> (a(key) :+ value))
            }
        }
        a
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,List[String]]()), (Map[String,String]("foo" -> "bar"))).equals((Map[String,List[String]]("foo" -> List[String]("bar")))));
    }

}
