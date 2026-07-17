import java.util.*;
import java.io.*;
public class ferrisWheel {
	static Scanner sc=new Scanner(System.in);
	static PrintWriter pw=new PrintWriter(System.out);
	public static long get(Long [] a,long x) {
		int start=0,end=a.length-1,mid=(start+end)/2;
		while(start<=end) {
			if(a[mid]>=x)
				end=mid-1;
			else start=mid+1;
			mid=(start+end)/2;
		}
		return start==a.length?-1:start;
	}
	public static void main(String[] args) throws IOException {
	int n=sc.nextInt();
	Long [] arr=sc.nextLongArray(n);
	Arrays.sort(arr);
	long [] sums=new long[n];
	sums[0]=arr[0];
	for(int i=1;i<n;i++)
		sums[i]=sums[i-1]+arr[i];
	int t=sc.nextInt();
	while(t-->0) {
		long d=sc.nextLong(),p=sc.nextLong();
		long x=get(arr, d);
		long ans=0,ans2=0;
		long sum=sums[arr.length-1],sum2=sum;
		if(x==-1 || x==0) {
			long temp=d-arr[(int) (x==-1? arr.length-1:x)];
			ans+=temp<0?0:temp;
			sum-=arr[(int) (x==-1? arr.length-1:x)];
			if(sum<p)
				ans+=p-sum;
			ans2=ans;
		}
		else {
			sum-=arr[(int) x];
			if(sum<p)
				ans+=p-sum;
			ans2+=Math.abs(d-arr[(int) (x-1)]);
			sum2-=arr[(int) (x-1)];
			if(sum2<p)
				ans2+=p-sum2;
		}
		pw.println(Math.min(ans, ans2));
	}
        		
	pw.flush();
	
	}
	static class tuble implements Comparable<tuble> {
		int x;
		int y;
		int z;
 
		public tuble(int x, int y, int z) {
			this.x = x;
			this.y = y;
			this.z = z;
		}
 
		public String toString() {
			return x + " " + y + " " + z;
		}
 
		public int compareTo(tuble other) {
			if (this.x == other.x) {
				if (this.y == other.y) {
					return this.z - other.z;
				}
				return this.y - other.y;
			} else {
				return this.x - other.x;
			}
		}
	}
 
	/*static class Permutation {
	    // Prints the array
	    public void printArr(int a[], int n,int [][]arr,int c)
	    {
	        for (int i = 0; i < n; i++)
	            arr[c][i]=a[i];
	        c++;
	    }
	 
	    public void heapPermutation(int a[], int size, int n,int [][]arr,int c)
	    {

	        if (size == 1)
	            printArr(a, n,arr,c);
	 
	        for (int i = 0; i < size; i++) {
	            heapPermutation(a, size - 1, n,arr,c);
	            if (size % 2 == 1) {
	                int temp = a[0];
	                a[0] = a[size - 1];
	                a[size - 1] = temp;
	            }
	            else {
	                int temp = a[i];
	                a[i] = a[size - 1];
	                a[size - 1] = temp;
	            }
	        }
	    }
	}
	static class UnionFind {                                              
		int[] p, rank, setSize;
		int numSets;

		public UnionFind(int N) 
		{
			numSets=N;
			p = new int[N+1];
			rank = new int[N+1];
			setSize = new int[N+1];
			for (int i = 0; i <= N; i++) {  p[i] = i; setSize[i] = 1; }
		}

		public int findSet(int i) { return p[i] == i ? i : (p[i] = findSet(p[i])); }

		public boolean isSameSet(int i, int j) { return findSet(i) == findSet(j); }

		public void join(int i, int j) 
		{ 
			if (isSameSet(i, j)) 
				return;
			numSets--; 
			int x = findSet(i), y = findSet(j);
			if(rank[x] > rank[y]) { p[y] = x; setSize[x] += setSize[y]; }
			else
			{	p[x] = y; setSize[y] += setSize[x];
				if(rank[x] == rank[y]) rank[y]++; 
			} 
		}

		public int numDisjointSets() { return numSets; }

		public int sizeOfSet(int i) { return setSize[findSet(i)]; }
		public String toString () {
			return Arrays.toString(p)+"   "+Arrays.toString(rank);
		}
	}
	static class pair {
		int x;
		int y;
		public pair(int a,int b) {
			this.x=a;this.y=b;
		}
		public void swap(pair p) {
			pair temp=new pair(p.x, p.y);
			p.x=this.x;p.y=this.y;
			this.x=temp.x;this.y=temp.y;
		}
		public String toString () {
			return x+","+y+" ";
		}
		
		public boolean equals(pair p) {
			if(x==p.x && y==p.y)
				return true;
			return false;
		}
	}
	*/
	static class Scanner {
		StringTokenizer st;
		BufferedReader br;
		public Scanner(InputStream s) {
			br = new BufferedReader(new InputStreamReader(s));
		}
 
		public Scanner(FileReader r) {
			br = new BufferedReader(r);
		}
 
		public String next() throws IOException {
			while (st == null || !st.hasMoreTokens())
				st = new StringTokenizer(br.readLine());
			return st.nextToken();
		}
		public String readAllLines(BufferedReader reader) throws IOException {
		    StringBuilder content = new StringBuilder();
		    String line;
		    
		    while ((line = reader.readLine()) != null) {
		        content.append(line);
		        content.append(System.lineSeparator());
		    }
 
		    return content.toString();
		}
		public int nextInt() throws IOException {
			return Integer.parseInt(next());
		}
 
		public long nextLong() throws IOException {
			return Long.parseLong(next());
		}
 
		public String nextLine() throws IOException {
			return br.readLine();
		}
 
		public double nextDouble() throws IOException {
			String x = next();
			StringBuilder sb = new StringBuilder("0");
			double res = 0, f = 1;
			boolean dec = false, neg = false;
			int start = 0;
			if (x.charAt(0) == '-') {
				neg = true;
				start++;
			}
			for (int i = start; i < x.length(); i++)
				if (x.charAt(i) == '.') {
					res = Long.parseLong(sb.toString());
					sb = new StringBuilder("0");
					dec = true;
				} else {
					sb.append(x.charAt(i));
					if (dec)
						f *= 10;
				}
			res += Long.parseLong(sb.toString()) / f;
			return res * (neg ? -1 : 1);
		}
 
		public long[] nextlongArray(int n) throws IOException {
			long[] a = new long[n];
			for (int i = 0; i < n; i++)
				a[i] = nextLong();
			return a;
		}
 
		public Long[] nextLongArray(int n) throws IOException {
			Long[] a = new Long[n];
			for (int i = 0; i < n; i++)
				a[i] = nextLong();
			return a;
		}
 
		public int[] nextIntArray(int n) throws IOException {
			int[] a = new int[n];
			for (int i = 0; i < n; i++)
				a[i] = nextInt();
			return a;
		}
 
		public Integer[] nextIntegerArray(int n) throws IOException {
			Integer[] a = new Integer[n];
			for (int i = 0; i < n; i++)
				a[i] = nextInt();
			return a;
		}
 
		public boolean ready() throws IOException {
			return br.ready();
		}
 
	}
 
}