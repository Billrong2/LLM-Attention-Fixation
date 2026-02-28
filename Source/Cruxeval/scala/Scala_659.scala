import scala.math._
import scala.collection.mutable._
object Problem {
    def f(bots : List[String]) : Long = {
        var clean = ListBuffer[String]()
        for (username <- bots) {
            if (!username.equals(username.toUpperCase)) {
                clean += username.take(2) + username.takeRight(3)
            }
        }
        clean.length
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("yR?TAJhIW?n", "o11BgEFDfoe", "KnHdn2vdEd", "wvwruuqfhXbGis"))) == (4l));
    }

}
