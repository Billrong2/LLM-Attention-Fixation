# 
sub f {
    my($album_sales) = @_;
    while (scalar(@$album_sales) != 1) {
        push @$album_sales, shift @$album_sales;
    }
    return $album_sales->[0];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([6]),6)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
