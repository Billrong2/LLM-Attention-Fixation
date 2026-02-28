# 
sub f {
    my($nums) = @_;
    my @digits;
    foreach my $num (@$nums) {
        if ((ref($num) eq 'SCALAR' and ${$num} =~ /^\d+$/) or ref($num) eq '') {
            push @digits, $num;
        }
    }
    @digits = map { int($_) } @digits;
    return \@digits;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([0, 6, "1", "2", 0]),[0, 6, 1, 2, 0])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
