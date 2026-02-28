# 
sub f {
    my($nums, $fill) = @_;
    my %ans = map { $_ => $fill } @{$nums};
    return \%ans;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([0, 1, 1, 2], "abcca"),{0 => "abcca", 1 => "abcca", 2 => "abcca"})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
