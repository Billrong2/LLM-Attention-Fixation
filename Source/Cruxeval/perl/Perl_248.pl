# 
sub f {
    my($a, $b) = @_;
    @$a = sort {$a <=> $b} @$a;
    @$b = sort {$b <=> $a} @$b;
    return [@$a, @$b];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([666], []),[666])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
