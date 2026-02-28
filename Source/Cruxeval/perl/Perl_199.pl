# 
sub f {
    my($s, $char) = @_;
    my $base = $char x ($s =~ tr/$char// + 1);
    return $s =~ s/\Q$base\E$//r;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("mnmnj krupa...##!@#!@#$$@##", "@"),"mnmnj krupa...##!@#!@#$$@##")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
