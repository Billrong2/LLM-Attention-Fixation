import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Long = {
        var count = 0
        for (i <- text) {
            if (List('.', '?', '!', ',', '.').contains(i)) {
                count += 1
            }
        }
        count
    }
    def main(args: Array[String]) = {
    assert(f(("bwiajegrwjd??djoda,?")) == (4l));
    }

}
