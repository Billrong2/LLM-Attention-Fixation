# 
sub f {
    my($filename) = @_;
    my @suffix = split(/\./, $filename);
    pop @suffix;
    $suffix = join('.', @suffix);
    my $f2 = $filename . reverse($suffix);
    return substr($f2, -length($suffix)) eq $suffix;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("docs.doc"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
