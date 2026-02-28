# 
sub f {
    my($nums, $n) = @_;
    my @nums = @{$nums};
    my $pos = scalar @nums - 1;
    for my $i (-scalar @nums .. -1) {
        splice @nums, $pos, 0, $nums[$i];
    }
    return \@nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([], 14),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
