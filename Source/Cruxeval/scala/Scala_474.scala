import scala.math._
import scala.collection.mutable._
object Problem {
    def f(txt : String, marker : Long) : String = {
        var a = ListBuffer[String]()
        val lines = txt.split('\n')
        for (line <- lines){
            a += line.padTo(marker.toInt, ' ').mkString("")
        }
        a.mkString("\n")
    }
    def main(args: Array[String]) = {
    assert(f(("#[)[]>[^e>\n 8"), (-5l)).equals(("#[)[]>[^e>\n 8")));
    }

}
