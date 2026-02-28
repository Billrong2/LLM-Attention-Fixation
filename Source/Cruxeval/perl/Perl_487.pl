# 
sub f {
    my($dict) = @_;
    my @even_keys;
    foreach my $key (keys %$dict) {
        if ($key % 2 == 0) {
            push @even_keys, $key;
        }
    }
    return \@even_keys;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({4 => "a"}),[4])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
