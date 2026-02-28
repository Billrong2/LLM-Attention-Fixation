import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var result = ""
        for(i <- 0 until text.length){
            if(i % 2 == 0){
                result += text(i).toString.toUpperCase
            }else{
                result += text(i)
            }
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f(("vsnlygltaw")).equals(("VsNlYgLtAw")));
    }

}
