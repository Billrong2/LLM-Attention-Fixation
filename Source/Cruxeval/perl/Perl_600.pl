# 
sub f {
    my($array) = @_;
    my @just_ns = map { 'n' x $_ } @{$array};
    my @final_output;
    foreach my $wipe (@just_ns) {
        push @final_output, $wipe;
    }
    return \@final_output;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([]),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
