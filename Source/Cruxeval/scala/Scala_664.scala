import scala.math._
object Problem {
    def f(tags : Map[String,String]) : String = {
        var resp = ""
        for (key <- tags.keys) {
            resp += key + " "
        }
        resp
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,String]("3" -> "3", "4" -> "5"))).equals(("3 4 ")));
    }

}
