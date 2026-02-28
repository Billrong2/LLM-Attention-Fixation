# 
sub f {
    my($values) = @_;
    @{$values} = sort {$a <=> $b} @{$values};
    return $values;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 1, 1, 1]),[1, 1, 1, 1])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
