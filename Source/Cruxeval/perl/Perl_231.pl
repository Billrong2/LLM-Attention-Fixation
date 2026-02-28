# 
sub f {
    my($years) = @_;
    my $a10 = scalar(grep {$_ <= 1900} @$years);
    my $a90 = scalar(grep {$_ > 1910} @$years);
    
    if ($a10 > 3) {
        return 3;
    } elsif ($a90 > 3) {
        return 1;
    } else {
        return 2;
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1872, 1995, 1945]),2)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
