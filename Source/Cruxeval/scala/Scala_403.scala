import scala.collection.mutable._
import scala.math._
object Problem {
    def f(full : String, part : String) : Long = {
        var length = part.length
        var index = full.indexOf(part)
        var count = 0
        var mutableFull = new StringBuilder(full)
        while (index >= 0) {
            mutableFull = mutableFull.delete(0, index + length)
            index = mutableFull.indexOf(part)
            count += 1
        }
        count
    }
    def main(args: Array[String]) = {
    assert(f(("hrsiajiajieihruejfhbrisvlmmy"), ("hr")) == (2l));
    }

}
