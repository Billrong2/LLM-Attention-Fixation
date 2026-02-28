import scala.collection.mutable._

object Problem {
    def f(text : String) : String = {
        val res = new ArrayBuffer[Byte]()
        for (ch <- text.getBytes("UTF-8")) {
            if (ch == 61) {
                return s"b'${new String(res.toArray, "UTF-8")}'"
            }
            if (ch != 0) {
                res ++= (s"$ch; ".getBytes("UTF-8"))
            }
        }
        s"b'${new String(res.toArray, "UTF-8")}'"
    }
    def main(args: Array[String]) = {
    assert(f(("os||agx5")).equals(("b'111; 115; 124; 124; 97; 103; 120; 53; '")));
    }

}
