import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, tabsize : Long) : String = {
        text.split('\n').map(t => t.replaceAll("\t", " " * tabsize.toInt)).mkString("\n")
    }
    def main(args: Array[String]) = {
    assert(f(("	f9\n	ldf9\n	adf9!\n	f9?"), (1l)).equals((" f9\n ldf9\n adf9!\n f9?")));
    }

}
