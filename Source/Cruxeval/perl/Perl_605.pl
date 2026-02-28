# 
sub f {
    my($nums) = @_;
    @$nums = ();
    return "quack";
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([2, 5, 1, 7, 9, 3]),"quack")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
