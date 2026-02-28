# 
sub f {
    my($line, $equalityMap) = @_;
    my %rs = map { $_->[0] => $_->[1] } @{$equalityMap};
    return $line =~ s/(.)/exists $rs{$1} ? $rs{$1} : $1 /egr;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("abab", [["a", "b"], ["b", "a"]]),"baba")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
