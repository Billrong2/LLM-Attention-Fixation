import scala.math._
import scala.collection.mutable._
object Problem {
    def f(fields : Tuple3[String, String, String], update_dict : Map[String,String]) : Map[String,String] = {
        var di = Map[String, String]()
        for (x <- fields.productIterator) {
            di += (x.asInstanceOf[String] -> "")
        }
        di ++= update_dict
        di
    }
    def main(args: Array[String]) = {
    assert(f((("ct", "c", "ca")), (Map[String,String]("ca" -> "cx"))).equals((Map[String,String]("ct" -> "", "c" -> "", "ca" -> "cx"))));
    }

}
