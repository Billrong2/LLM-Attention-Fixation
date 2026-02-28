use Encode;

sub f {
    my($string, $code) = @_;
    my $t;
    eval {
        $t = encode($code, $string);
        if(substr($t, -1) eq "\n"){
            $t = substr($t, 0, -1);
        }
        $t = decode('UTF-8', $t);
    };
    return $t;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("towaru", "UTF-8"),"towaru")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
