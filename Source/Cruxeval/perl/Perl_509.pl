# 
sub f {
    my($value, $width) = @_;
    if ($value >= 0) {
        return sprintf("%0*d", $width, $value);
    }
    elsif ($value < 0) {
        return '-' . sprintf("%0*d", $width, -$value);
    }
    return '';
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(5, 1),"5")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
