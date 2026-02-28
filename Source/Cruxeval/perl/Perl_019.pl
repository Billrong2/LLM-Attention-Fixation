# 
sub f {
    my($x, $y) = @_;
    my $tmp = join('', map { $_ eq '9' ? '0' : '9' } reverse(split(//, $y)));
    if ($x =~ /^\d+$/ && $tmp =~ /^\d+$/) {
        return $x . $tmp;
    } else {
        return $x;
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("", "sdasdnakjsda80"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
