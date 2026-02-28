import scala.collection.mutable._
import scala.math._
object Problem {
    def f(name : String) : String = {
        var new_name = ""
        var reversedName = name.reverse
        var shouldBreak = false
        for(i <- 0 until reversedName.length if !shouldBreak){
            val n = reversedName(i)
            if(n != '.' && new_name.count(_ == '.') < 2){
                new_name = n + new_name
            } else {
                shouldBreak = true
            }
        }
        new_name
    }
    def main(args: Array[String]) = {
    assert(f((".NET")).equals(("NET")));
    }

}
