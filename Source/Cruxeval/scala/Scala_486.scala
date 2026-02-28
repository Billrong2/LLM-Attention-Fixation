import scala.math._
import scala.collection.mutable._
object Problem {
    def f(dic : Map[Long,Long]) : Map[Long,Long] = {
        var dic_op = dic.map{case (k,v) => (k, v*v)}
        dic_op
    }
    def main(args: Array[String]) = {
    assert(f((Map[Long,Long](1l -> 1l, 2l -> 2l, 3l -> 3l))).equals((Map[Long,Long](1l -> 1l, 2l -> 4l, 3l -> 9l))));
    }

}
