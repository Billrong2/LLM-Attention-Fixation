import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;

public class Main {
	static final long MOD=1000000007;
	static final long MOD1=998244353;
	static long ans=0;
	//static ArrayList<Integer> ans=new ArrayList<>();
	public static void main(String[] args){
		PrintWriter out = new PrintWriter(System.out);
		InputReader sc=new InputReader(System.in);
		int t = sc.nextInt();
		for (int i = 0; i < t; i++) {
			int n = sc.nextInt();
			int m = sc.nextInt();
			int k = sc.nextInt();
			int[] yline = sc.nextIntArray(n);
			int[] xline = sc.nextIntArray(m);
			int[] px = new int[k];
			int[] py = new int[k];
			for (int j = 0; j < py.length; j++) {
				px[j] = sc.nextInt();
				py[j] = sc.nextInt();
			}
			out.println(solve(n, m, k, yline, xline, px, py));
		}
		out.flush();
	}
	static long solve(int n,int m,int k,int[] yline,int[] xline,int[] px,int[] py) {
		HashSet<Integer> yset = new HashSet<Integer>();
		HashSet<Integer> xset = new HashSet<Integer>();
		ArrayList<Pair> xlist = new ArrayList<Main.Pair>();
		ArrayList<Pair> ylist = new ArrayList<Main.Pair>();
		for (int i = 0; i < n; i++) {
			yset.add(yline[i]);
			xlist.add(new Pair(yline[i], -1));
		}
		for (int i = 0; i < m; i++) {
			xset.add(xline[i]);
			ylist.add(new Pair(xline[i], -1));
		}
		for (int i = 0; i < k; i++) {
			boolean xx = xset.contains(py[i]);
			boolean yy = yset.contains(px[i]);
			if(xx&&yy)continue;
			if (xx)xlist.add(new Pair(px[i], py[i]));
			if (yy)ylist.add(new Pair(py[i], px[i]));
		}
		Collections.sort(xlist);
		Collections.sort(ylist);
		HashMap<Integer, Long> mapx = new HashMap<Integer, Long>();
		HashMap<Integer, Long> mapy = new HashMap<Integer, Long>();
		long sumx = 0;
		long sumy = 0;
		long ans = 0;
		for (int i = 0; i < xlist.size(); i++) {
			Pair p = xlist.get(i);
			if (p.y==-1) {
				mapx.clear();
				sumx=0;
			}else {
				ans += sumx;
				if (mapx.containsKey(p.y)) {
					ans -= mapx.get(p.y);
				}else {
					mapx.put(p.y, 0l);
				}
				mapx.put(p.y, mapx.get(p.y)+1l);
				sumx++;
			}
		}
		for (int i = 0; i < ylist.size(); i++) {
			Pair p = ylist.get(i);
			if (p.y==-1) {
				mapy.clear();
				sumy=0;
			}else {
				ans += sumy;
				if (mapy.containsKey(p.y)) {
					ans -= mapy.get(p.y);
				}else {
					mapy.put(p.y, 0l);
				}
				mapy.put(p.y, mapy.get(p.y)+1l);
				sumy++;
			}
		}
		return ans;
	}
	static class Pair implements Comparable<Pair>{
    	public int x;
    	public int y;
    	public Pair(int x,int y) {
    		this.x=x;
    		this.y=y;
    	}
    	@Override
    	public boolean equals(Object obj) {
    		if(obj instanceof Pair) {
    			Pair other = (Pair) obj;
    			return other.x==this.x && other.y==this.y;
    		}
    		return false;
    	}//同値の定義
    	@Override
    	public int hashCode() {
    		return Objects.hash(this.x,this.y);
    	}//これ書かないと正しく動作しない（要　勉強）
    	@Override
    	public int compareTo( Pair p){
    		if (this.x>p.x) {
    			return 1;
    		}
    		else if (this.x<p.x) {
    			return -1;
    		}
    		else {
    			return 0;
    		}
    	}
    }
	static class InputReader { 
		private InputStream in;
		private byte[] buffer = new byte[1024];
		private int curbuf;
		private int lenbuf;
		public InputReader(InputStream in) {
			this.in = in;
			this.curbuf = this.lenbuf = 0;
		}
		public boolean hasNextByte() {
			if (curbuf >= lenbuf) {
				curbuf = 0;
				try {
					lenbuf = in.read(buffer);
				} catch (IOException e) {
					throw new InputMismatchException();
				}
				if (lenbuf <= 0)
					return false;
			}
			return true;
		}
 
		private int readByte() {
			if (hasNextByte())
				return buffer[curbuf++];
			else
				return -1;
		}
 
		private boolean isSpaceChar(int c) {
			return !(c >= 33 && c <= 126);
		}
 
		private void skip() {
			while (hasNextByte() && isSpaceChar(buffer[curbuf]))
				curbuf++;
		}
 
		public boolean hasNext() {
			skip();
			return hasNextByte();
		}
 
		public String next() {
			if (!hasNext())
				throw new NoSuchElementException();
			StringBuilder sb = new StringBuilder();
			int b = readByte();
			while (!isSpaceChar(b)) {
				sb.appendCodePoint(b);
				b = readByte();
			}
			return sb.toString();
		}
 
		public int nextInt() {
			if (!hasNext())
				throw new NoSuchElementException();
			int c = readByte();
			while (isSpaceChar(c))
				c = readByte();
			boolean minus = false;
			if (c == '-') {
				minus = true;
				c = readByte();
			}
			int res = 0;
			do {
				if (c < '0' || c > '9')
					throw new InputMismatchException();
				res = res * 10 + c - '0';
				c = readByte();
			} while (!isSpaceChar(c));
			return (minus) ? -res : res;
		}
 
		public long nextLong() {
			if (!hasNext())
				throw new NoSuchElementException();
			int c = readByte();
			while (isSpaceChar(c))
				c = readByte();
			boolean minus = false;
			if (c == '-') {
				minus = true;
				c = readByte();
			}
			long res = 0;
			do {
				if (c < '0' || c > '9')
					throw new InputMismatchException();
				res = res * 10 + c - '0';
				c = readByte();
			} while (!isSpaceChar(c));
			return (minus) ? -res : res;
		}
 
		public double nextDouble() {
			return Double.parseDouble(next());
		}
 
		public int[] nextIntArray(int n) {
			int[] a = new int[n];
			for (int i = 0; i < n; i++)
				a[i] = nextInt();
			return a;
		}
		public double[] nextDoubleArray(int n) {
			double[] a = new double[n];
			for (int i = 0; i < n; i++)
				a[i] = nextDouble();
			return a;
		}
		public long[] nextLongArray(int n) {
			long[] a = new long[n];
			for (int i = 0; i < n; i++)
				a[i] = nextLong();
			return a;
		}
 
		public char[][] nextCharMap(int n, int m) {
			char[][] map = new char[n][m];
			for (int i = 0; i < n; i++)
				map[i] = next().toCharArray();
			return map;
		}
	}
}
