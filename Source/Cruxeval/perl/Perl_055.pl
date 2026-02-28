# 
sub f {
    my($array) = @_;
    my @array_2;
    foreach my $i (@$array) {
        if ($i > 0) {
            push @array_2, $i;
        }
    }
    @array_2 = sort {$b <=> $a} @array_2;
    return \@array_2;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([4, 8, 17, 89, 43, 14]),[89, 43, 17, 14, 8, 4])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
