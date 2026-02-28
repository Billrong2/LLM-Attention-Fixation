import scala.collection.mutable._
import scala.math._
object Problem {
    def f(strand : String, zmnc : String) : Long = {
        var mutableStrand = strand
        var poz = mutableStrand.indexOf(zmnc)
        while (poz != -1) {
            mutableStrand = mutableStrand.substring(poz + 1)
            poz = mutableStrand.indexOf(zmnc)
        }
        return mutableStrand.lastIndexOf(zmnc).toLong
    }
    def main(args: Array[String]) = {
    assert(f((""), ("abc")) == (-1l));
    }

}
