# 
sub f {
    my($nums) = @_;
    my %copy = %{$nums};
    my %newDict = ();
    foreach my $k (keys %copy) {
        $newDict{$k} = scalar @{$copy{$k}};
    }
    return \%newDict;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({}),{})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
