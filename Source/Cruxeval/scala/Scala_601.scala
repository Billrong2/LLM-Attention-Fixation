import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var t = 5
        var tab = ArrayBuffer[String]()
        for (i <- text) {
            if ("aeiouy".contains(i.toLower)) {
                tab += i.toString.toUpperCase * t
            } else {
                tab += i.toString * t
            }
        }
        tab.mkString(" ")
    }
    def main(args: Array[String]) = {
    assert(f(("csharp")).equals(("ccccc sssss hhhhh AAAAA rrrrr ppppp")));
    }

}
