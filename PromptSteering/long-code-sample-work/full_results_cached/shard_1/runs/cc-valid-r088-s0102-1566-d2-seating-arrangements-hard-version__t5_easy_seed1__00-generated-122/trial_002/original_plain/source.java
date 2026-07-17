import java.util.*;


import java.io.*;
public class Main {
		static long mod = 1000000007;
		static PrintWriter out = new PrintWriter(new BufferedOutputStream(System.out));
		public static void main(String[] args) throws IOException  {
			FastReader sc = new FastReader();
			int t  = sc.nextInt();
			while( t-- > 0) {
				ArrayList<pair> x = new ArrayList<>();
				int n = sc.nextInt();
				int m = sc.nextInt();
				for( int i =0; i< m*n ;i++) {
					pair pr = new pair();
					pr.idx = i+1;
					pr.val = sc.nextInt();
					x.add(pr);
				}
				Collections.sort(x);
//				int arr[] = new int[m*n];
//				for( int i= 0; i< m*n ;i++) {
//					arr[ x.get(i).idx-1] = i+1;
//				}
//				for( pair y : x) {
//					out.print(y.idx+ " ");
//				}
//				out.println();
//				for(int y : arr) {
//					out.print(y+ " ");
//				}
//				out.println();
				long sum = 0;
//				for( pair pr : x) {
//					out.print( pr.idx + " ");
//				}
//				out.println();
				//out.flush();
//				int a[] = new int[m*n];
//				for( int i = 0; i<m*n; i++) {
//					a[i] = x.get(i).idx;
//				}
				// 0  - m-1 ,
//				ArrayList<pair>[] mat= new ArrayList[n];
//				for( int i =0 ;i < n; i++) {
//					mat[i] = new ArrayList<>();
//				}
//				for( int i =0 ; i< m*n ;i++) {
//					// row = arr[i]/m
//					int col = 0;
//					int row= 0;
//					int temp = arr[i];
//					if( temp% m == 0) {
//						col = m-1;
//					}
//					else {
//						col = temp%m - 1;
//					}
//					row = (temp-1)/m + 1;
//					mat[row-1].add(col, i);
//				}
				int i = 0 ;
				int j = m-1;
				while( n-- > 0) {
					ArrayList<pair> h = new ArrayList<>();
					for( int k = i ; k<= j ; k++) {
						h.add(x.get(k));
					}
//					for( pair pr : h) {
//						out.print( pr.idx + " ");
//					}
//					out.println();
					//out.flush();
					Collections.sort(h , new sort());
					sum+=solve( h , m);
					i+=m;
					j+=m;
				}
//				int i = 0;
//				int j = m-1;
//				while( n-- > 0) {
//					sum+=solve( arr , i , j );
//					i+=m;
//					j+=m;
//				}
//				out.println(sum);
//				for( int i = 0; i< m ; i++) {
//					long temp = 0;
//					for( int j =0 ; j < i ; j++) {
//						if(arr[i] > arr[j]) {
//							temp++;
//						}
//					}
//					sum+=temp;
//				}
				out.println(sum);
			}
			out.flush();
		}		
		private static long solve(ArrayList<pair> arr, int m ) {
			long sum = 0;
//			for( int i = 0 ; i < m; i++) {
//				out.print( arr.get(i).idx + " ");
//			}
//			out.println();
			for( int i = 0; i< m ; i++) {
			long temp = 0;
			for( int j = 0 ; j < i ; j++) {
				if(arr.get(i).idx > arr.get(j).idx) {
					temp++;
				}
			}
			sum+=temp;
		}
			return sum;
		}
		public static class pair implements Comparable<pair>{
			int idx;
			int val;
			@Override
			public int compareTo(Main.pair o) {
				int temp = this.val - o.val;
//				if( temp == 0) {
//					return  o.idx- this.idx;
//				}
				return temp;
			}
			
		}
		public static class sort implements Comparator<pair>{

			@Override
			public int compare(Main.pair o1, Main.pair o2) {
				int temp = o1.val - o2.val;
				if( temp == 0) {
					return o2.idx - o1.idx;
				}
				return 0;
			}
			
		}

		public static int[] nextLargerElement(int[] arr, int n)	{ 
			Stack<Integer> stack = new Stack<>();
			int rtrn[] = new int[n];
	        rtrn[n-1] = -1;
	        stack.push( n-1);
	        for( int i = n-2 ;i >= 0 ; i--){
	            int temp = arr[i];
	            int lol = -1;
	            while( !stack.isEmpty() && arr[stack.peek()] <= temp){
	            	if(arr[stack.peek()] == temp ) {
	            		lol = stack.peek();
	            	}
	                stack.pop();
	            }
	            if( stack.isEmpty()){
	            	if( lol != -1) {
	            		rtrn[i] = lol;
	            		}
	            	else {
	                rtrn[i] = -1;
	            	}
	            }
	            else{
	            	rtrn[i] = stack.peek();
	            }
	            stack.push( i);
	        }
	        return rtrn;
		}
		
		 static int gcd(int a, int b)
		    {
		        if (a == 0)
		            return b;
		        return gcd(b % a, a);
		    }
		     
//		    // method to return LCM of two numbers
//		    static int lcm(int a, int b)
//		    {
//		        return (a / gcd(a, b)) * b;
//		    }
	 
		static HashMap<Long,Long> primefactor( long n){
			HashMap<Long ,Long> hm = new HashMap<>();
			long temp = 0;
			while( n%2 == 0) {
				temp++;
				n/=2;
	 		 }	
			if( temp!= 0) {
	 			 hm.put( 2L, temp);
	 		 }
	 		 long c = (long)Math.sqrt(n);
	 		 for( long i = 3 ; i <= c ; i+=2) {
	 			 temp = 0;
	 			 while( n% i == 0) {
	 				 temp++;
	 				 n/=i;
	 			 }
	 			 if( temp!= 0) {
	 				 hm.put( i, temp);
	 			 }
	 		 }
	 		 if( n!= 1) {
	 			 hm.put( n , 1L);
	 		 }
	 		 return hm;
	 		// this is the link where i found this method
	 		 // https://www.geeksforgeeks.org/print-all-prime-factors-of-a-given-number/
	 	 }
	 
		 static class FastReader {
		        BufferedReader br;
		        StringTokenizer st;
		 
		        public FastReader()
		        {
		            br = new BufferedReader(
		                new InputStreamReader(System.in));
		        }
		        
		        String next()
		        {
		            while (st == null || !st.hasMoreElements()) {
		                try {
		                    st = new StringTokenizer(br.readLine());
		                }
		                catch (IOException e) {
		                    e.printStackTrace();
		                }
		            }
		            return st.nextToken();
		        }
		 
		        int nextInt() { return Integer.parseInt(next()); }
		 
		        long nextLong() { return Long.parseLong(next()); }
		 
		        double nextDouble()
		        {
		            return Double.parseDouble(next());
		        }
		 
		        String nextLine()
		        {
		            String str = "";
		            try {
		                str = br.readLine();
		            }
		            catch (IOException e) {
		                e.printStackTrace();
		            }
		            return str;
		        }
		    }
		
}