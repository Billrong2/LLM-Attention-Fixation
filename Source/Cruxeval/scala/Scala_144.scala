import scala.math._
import scala.collection.mutable._
object Problem {
    def f(vectors : List[List[Long]]) : List[List[Long]] = {
        vectors.map(vec => vec.sorted)
    }
    def main(args: Array[String]) = {
    assert(f((List[List[Long]]())).equals((List[List[Long]]())));
    }

}
