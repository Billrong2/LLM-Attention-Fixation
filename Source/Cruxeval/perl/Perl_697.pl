# 
sub f {
    my($s, $sep) = @_;
    my $sep_index = index($s, $sep);
    my $prefix = substr($s, 0, $sep_index);
    my $middle = substr($s, $sep_index, length($sep));
    my $right_str = substr($s, $sep_index + length($sep));
    return ($prefix, $middle, $right_str);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("not it", ""),["", "", "not it"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
