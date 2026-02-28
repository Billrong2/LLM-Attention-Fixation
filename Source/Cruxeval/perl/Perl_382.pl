# 
sub f {
    my($a) = @_;
    my %s = reverse %$a;
    return join(" ", map { "(" . $s{$_} . ", '" . $_ . "')" } sort { $a <=> $b } keys %s);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({15 => "Qltuf", 12 => "Rwrepny"}),"(12, 'Rwrepny') (15, 'Qltuf')")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
