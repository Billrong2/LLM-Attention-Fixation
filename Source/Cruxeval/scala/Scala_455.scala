import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var uppers = 0
        for(c <- text){
            if(c.isUpper){
                uppers += 1
            }
        }

        if(uppers >= 10){
            text.toUpperCase
        } else {
            text
        }
    }
    def main(args: Array[String]) = {
    assert(f(("?XyZ")).equals(("?XyZ")));
    }

}
