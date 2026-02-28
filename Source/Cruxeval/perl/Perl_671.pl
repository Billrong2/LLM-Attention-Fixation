# 
sub f {
    my($text, $char1, $char2) = @_;
    my @t1a;
    my @t2a;
    for my $i (0 .. length($char1)-1) {
        push @t1a, substr($char1, $i, 1);
        push @t2a, substr($char2, $i, 1);
    }
    my %t1 = map { $t1a[$_] => $t2a[$_] } 0 .. $#t1a;
    my $trans = join '', map { defined $t1{$_} ? $t1{$_} : $_ } split //, $text;
    return $trans;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("ewriyat emf rwto segya", "tey", "dgo"),"gwrioad gmf rwdo sggoa")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
