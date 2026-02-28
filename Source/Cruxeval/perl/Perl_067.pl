# 
sub f {
    my($num1, $num2, $num3) = @_;
    my @nums = ($num1, $num2, $num3);
    @nums = sort {$a <=> $b} @nums;
    return "$nums[0],$nums[1],$nums[2]";
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(6, 8, 8),"6,8,8")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
