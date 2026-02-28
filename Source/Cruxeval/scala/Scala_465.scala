import scala.math._
import scala.collection.mutable._
object Problem {
    def f(seq : List[String], value : String) : Map[String,String] = {
        var roles = Map[String,String]().withDefaultValue("north")
        roles ++= seq.map(x => x -> "north")
        if (value != ""){
            roles ++= value.split(", ").map(_.strip).map(x => x -> "north")
        }
        roles
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("wise king", "young king")), ("")).equals((Map[String,String]("wise king" -> "north", "young king" -> "north"))));
    }

}
