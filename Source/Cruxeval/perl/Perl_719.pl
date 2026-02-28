# 
sub f {
    my($code) = @_;
    my @lines = split(']', $code);
    my @result;
    my $level = 0;
    for my $line (@lines) {
        push @result, substr($line, 0, 1) . ' ' . '  ' x $level . substr($line, 1);
        $level += ($line =~ tr/\{\g//) - ($line =~ tr/\}\g//);
    }
    return join('\n', @result);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("if (x) {y = 1;} else {z = 1;}"),"i f (x) {y = 1;} else {z = 1;}")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
