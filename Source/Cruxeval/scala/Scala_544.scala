import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        val a = text.split("\n")
        var b = ListBuffer[String]()
        for (i <- 0 until a.length) {
            val c = a(i).replace("\t", "    ")
            b += c
        }
        b.mkString("\n")
    }
    def main(args: Array[String]) = {
    assert(f(("			tab tab tabulates")).equals(("            tab tab tabulates")));
    }

}
