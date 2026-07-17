/*
    This code is written by KESHAV DAGA
    @keshavkeshu
*/


import java.util.*;
import java.io.*;
public class Main  
{
    static FastReader in=new FastReader();
    static final Random random=new Random();
    static int mod=1000000007;
    static int inf=Integer.MAX_VALUE;
    static int ninf=Integer.MIN_VALUE;
    static HashMap<String,Integer>map=new HashMap<>();
    static String yes="YES",no="NO";

    public static void main(String args[]) throws IOException {
        /*
            This is main section or the coding part
            @keshavkeshu
        */
        int t=in.nextInt();
        StringBuilder res=new StringBuilder();
        outer: while(t-->0)
        {
            // logic
            int n=in.nextInt();
            String s=in.next();
            
            int ans=1;
            int two=0,three=0,seven=0,five=0;
            for(int i=0;i<s.length();i++)
            {
                int a=s.charAt(i)-'0';
                if(a!=2 && a!=3 && a!=5 && a!=7)
                {
                    print("1");
                    print(s.charAt(i));
                    continue outer;
                }
                if(a==2)
                    two++;
                if(a==3)
                    three++;
                if(a==5)
                    five++;
                if(a==7)
                    seven++;
            }
            
            int p=0;
            String x="";
            for(int i=0;i<n;i++)
            {
                char ch1=s.charAt(i);
                for(int j=1;j<n;j++)
                {
                    char ch2=s.charAt(j);
                    x=""+ch1+ch2;
                    p=Integer.valueOf(x);
                    if(!isPrime(p))
                    {
                        print("2");
                        
                        print(x);
                        continue outer;
                    }
                    
                }
            }
            
            
        }
        
        //printprint(res);
    }
    
    
    
    
    static boolean isPrime(int n)
    {
 
        
        if (n <= 1)
            return false;
 
        
        else if (n == 2)
            return true;
 
        else if (n % 2 == 0)
            return false;
 
        for (int i = 3; i <= Math.sqrt(n); i += 2)
        {
            if (n % i == 0)
                return false;
        }
        return true;
    }
    
   
   
    
    static int max(int a, int b)
    {
        if(a<b)
        	return b;
        return a;
    }
    
    static int min(int a, int b)
    {
        if(a>b)
        	return b;
        return a;
    }
    
    static long max(long a, long b)
    {
        if(a<b)
        	return b;
        return a;
    }
    
    static long min(long a, long b)
    {
        if(a>b)
        	return b;
        return a;
    }
    static int max(int a, int b, int c)
    {
        if(a>b && a>c)
        	return a;
        else if(b>a && b>c)
            return b;
        else
            return c;
    }
    
    static int min(int a, int b, int c)
    {
        if(a<b && a<c)
        	return a;
        else if(b<a && b<c)
            return b;
        else
            return c;
    }
    
     
    static void ruffleSort(int[] a) {
        int n=a.length;
        for (int i=0; i<n; i++) {
            int oi=random.nextInt(n), temp=a[oi];
            a[oi]=a[i]; a[i]=temp;
        }
        Arrays.sort(a);
    }

    static < E > void print(E res)
    {
        System.out.println(res);
    }
    
    static < E > void printd(E res)
    {
        System.out.println(res);
    }


    static  int gcd(int a,int b)
    {
        if(b==0)
        {
            return a;
        }
        return gcd(b,a%b);
    }
    
    static int lcm(int a, int b)
    {
        return (a / gcd(a, b)) * b;
    }

    
    static int abs(int a)
    {
        if(a<0)
            return -1*a;
        return a;
    }

    static class FastReader
    {
        BufferedReader br;
        StringTokenizer st;

        public FastReader()
        {
            br = new BufferedReader(new
                    InputStreamReader(System.in));
        }

        String next()
        {
            while (st == null || !st.hasMoreElements())
            {
                try
                {
                    st = new StringTokenizer(br.readLine());
                }
                catch (IOException  e)
                {
                    e.printStackTrace();
                }
            }
            return st.nextToken();
        }
        int nextInt()
        {
            return Integer.parseInt(next());
        }

        long nextLong()
        {
            return Long.parseLong(next());
        }

        double nextDouble()
        {
            return Double.parseDouble(next());
        }
        String nextLine()
        {
            String str = "";
            try
            {
                str = br.readLine();
            }
            catch (IOException e)
            {
                e.printStackTrace();
            }
            return str;
        }

        int [] ria(int n) {
            int res [] = new int [n];
            for(int i = 0; i<n; i++)res[i] = nextInt();
            return res;
        }
        long [] rla(int n) {
            long res [] = new long [n];
            for(int i = 0; i<n; i++)res[i] = nextLong();
            return res;
        }
    }

}
