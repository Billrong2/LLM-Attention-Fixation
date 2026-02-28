# 
sub f {
    my($out, $mapping) = @_;
    foreach my $key (keys %$mapping) {
        $out =~ s/{$_}/$mapping->{$_}[1]/g foreach keys %$mapping;
        last if ($out !~ m/{\w}/);
        $mapping->{$key}[1] = reverse($mapping->{$key}[1]);
    }
    return $out;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("{{{{}}}}", {}),"{{{{}}}}")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
