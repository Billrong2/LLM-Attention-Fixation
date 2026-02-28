# 
sub f {
    my($numbers) = @_;
    my @new_numbers;
    for my $i (0..$#{$numbers}) {
        push @new_numbers, $numbers->[$#{$numbers}-$i];
    }
    return \@new_numbers;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([11, 3]),[3, 11])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
