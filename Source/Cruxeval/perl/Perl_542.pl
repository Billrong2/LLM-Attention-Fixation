# 
sub f {
    my($test, $sep, $maxsplit) = @_;
    $sep = ' ' unless defined $sep;
    $maxsplit = -1 unless defined $maxsplit;
    
    eval {
        return [ reverse split($sep, $test, $maxsplit) ];
    } or do {
        return [ reverse split(' ', $test) ];
    };
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("ab cd", "x", 2),["ab cd"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
