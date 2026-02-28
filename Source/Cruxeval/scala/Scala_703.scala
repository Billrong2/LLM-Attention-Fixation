import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, char : String) : String = {
        val count = text.split(char * 2, -1).head.length
        text.substring(count)
    }
    def main(args: Array[String]) = {
    assert(f(("vzzv2sg"), ("z")).equals(("zzv2sg")));
    }

}
