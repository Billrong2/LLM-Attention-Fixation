import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, prefix : String) : String = {
        if (text.startsWith(prefix)) {
            text.stripPrefix(prefix)
        } else if (text.contains(prefix)) {
            text.replace(prefix, "").trim()
        } else {
            text.toUpperCase()
        }
    }
    def main(args: Array[String]) = {
    assert(f(("abixaaaily"), ("al")).equals(("ABIXAAAILY")));
    }

}
