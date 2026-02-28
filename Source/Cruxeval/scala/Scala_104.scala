import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Map[String,Long] = {
        var dic = Map[String, Long]()
        
        for (char <- text) {
            dic += (char.toString -> (dic.getOrElse(char.toString, 0L) + 1))
        }
        
        for ((key, value) <- dic) {
            if (value > 1) {
                dic += (key -> 1)
            }
        }
        
        dic
    }
    def main(args: Array[String]) = {
    assert(f(("a")).equals((Map[String,Long]("a" -> 1l))));
    }

}
