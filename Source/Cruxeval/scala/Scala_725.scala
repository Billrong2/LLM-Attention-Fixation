import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Long = {
        var result_list = List("3", "3", "3", "3")
        if(result_list.nonEmpty){
            result_list = List.empty[String]
        }
        text.length
    }
    def main(args: Array[String]) = {
    assert(f(("mrq7y")) == (5l));
    }

}
