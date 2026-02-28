# 
sub f {
    my($dct) = @_;
    my @lst;
    foreach my $key (sort keys %$dct) {
        push @lst, [ $key, $dct->{$key} ];
    }
    return \@lst;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({"a" => 1, "b" => 2, "c" => 3}),[["a", 1], ["b", 2], ["c", 3]])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
