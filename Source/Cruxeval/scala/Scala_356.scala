import scala.math._
object Problem {
    def f(array : List[Long], num : Long) : List[Long] = {
        var reverse = false
        var n = num
        if (n < 0) {
            reverse = true
            n *= -1
        }
        var arrayNew = array.reverse
        val l = arrayNew.length
        
        arrayNew = List.fill(n.toInt)(arrayNew).flatten
        
        if (reverse) {
            arrayNew = arrayNew.reverse
        }
        arrayNew
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong)), (1l)).equals((List[Long](2l.toLong, 1l.toLong))));
    }

}
