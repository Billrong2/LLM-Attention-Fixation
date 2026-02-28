# 
sub f {
    my($label1, $char, $label2, $index) = @_;
    my $m = rindex($label1, $char);
    if ($m >= $index) {
        return substr($label2, 0, $m - $index + 1);
    } else {
        return $label1 . substr($label2, $index - $m - 1);
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("ekwies", "s", "rpg", 1),"rpg")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
