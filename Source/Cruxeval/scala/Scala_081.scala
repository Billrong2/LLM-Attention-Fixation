import scala.math._
import scala.collection.mutable._
object Problem {
    def f(dic : Map[String,Any], inx : String) : List[Tuple2[String, Any]] = {
        try {
            val updatedDic = dic.updated(inx, inx.toLowerCase())
            updatedDic.toList
        } catch {
            case e: NoSuchElementException => dic.toList
        }
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,Any]("Bulls" -> 23l, "White Sox" -> 45l)), ("Bulls")).equals((List[Tuple2[String, Any]](("Bulls", "bulls"), ("White Sox", 45l)))));
    }

}
