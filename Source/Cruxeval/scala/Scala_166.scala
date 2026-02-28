import scala.math._
import scala.collection.mutable._
object Problem {
    def f(graph : Map[String,Map[String,String]]) : Map[String,Map[String,String]] = {
        var new_graph = Map[String, Map[String, String]]()
        for ((key, value) <- graph) {
            var subMap = Map[String, String]()
            for (subkey <- value.keys) {
                subMap += (subkey -> "")
            }
            new_graph += (key -> subMap)
        }
        new_graph
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,Map[String,String]]())).equals((Map[String,Map[String,String]]())));
    }

}
