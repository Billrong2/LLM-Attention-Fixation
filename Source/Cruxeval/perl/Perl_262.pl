# 
sub f {
    my($nums) = @_;
    my $count = scalar(@$nums);
    my %score = (0 => "F", 1 => "E", 2 => "D", 3 => "C", 4 => "B", 5 => "A", 6 => "");
    my @result;
    for my $i (0..$count-1) {
        push @result, $score{$nums->[$i]};
    }
    return join('', @result);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([4, 5]),"BA")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
