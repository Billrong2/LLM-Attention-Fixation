# 
sub f {
    my($array) = @_;
    my @new_array = reverse(@$array);
    return [map {$_ * $_} @new_array];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, 1]),[1, 4, 1])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
