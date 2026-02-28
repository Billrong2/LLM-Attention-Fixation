import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text: String, letter: String): Long = {
        var counts = Map[Char, Int]()
        text.foreach(char => {
            if (counts.contains(char)) {
                counts += (char -> (counts(char) + 1))
            } else {
                counts += (char -> 1)
            }
        })
        counts.getOrElse(letter(0), 0).toLong
    }
    def main(args: Array[String]) = {
    assert(f(("za1fd1as8f7afasdfam97adfa"), ("7")) == (2l));
    }

}
