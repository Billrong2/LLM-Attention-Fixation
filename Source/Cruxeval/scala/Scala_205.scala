import scala.collection.mutable._
import scala.math._
object Problem {
    def f(a : String) : String = {
        var str = a
        var breakOuter = false
        for (_ <- 1 to 10 if !breakOuter) {
            var breakInner = false
            for (j <- 0 until str.length if !breakInner) {
                if (str(j) != '#') {
                    str = str.substring(j)
                    breakInner = true
                }
            }
            if (!str.contains('#')) {
                str = ""
                breakOuter = true
            }
        }
        while (str.last == '#') {
            str = str.init
        }
        str
    }
    def main(args: Array[String]) = {
    assert(f(("##fiu##nk#he###wumun##")).equals(("fiu##nk#he###wumun")));
    }

}
