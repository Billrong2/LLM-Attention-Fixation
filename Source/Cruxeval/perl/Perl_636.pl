# 
sub f {
    my($d) = @_;
    my %r;
    while (keys %$d) {
        %r = (%r, %$d);
        delete $d->{(sort {$a <=> $b} keys %$d)[-1]};
    }
    return \%r;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({3 => "A3", 1 => "A1", 2 => "A2"}),{3 => "A3", 1 => "A1", 2 => "A2"})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
