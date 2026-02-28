import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Long = {
        var a = 0
        if (text(0) != "" && text.drop(1).contains(text(0))) {
            a += 1
        }
        for (i <- 0 until text.length - 1) {
            if (text(i) != "" && text.drop(i + 1).contains(text(i))) {
                a += 1
            }
        }
        a
    }
    def main(args: Array[String]) = {
    assert(f(("3eeeeeeoopppppppw14film3oee3")) == (18l));
    }

}
