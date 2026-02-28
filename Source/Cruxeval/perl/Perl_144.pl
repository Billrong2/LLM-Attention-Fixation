# 
sub f {
    my($vectors) = @_;
    my @sorted_vecs;
    foreach my $vec (@$vectors) {
        my @sorted_vec = sort {$a <=> $b} @$vec;
        push @sorted_vecs, \@sorted_vec;
    }
    return \@sorted_vecs;
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
