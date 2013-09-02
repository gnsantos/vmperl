package foo;

sub new{
	my $instance = shift;
	return 	bless \$instance;
}

sub sayHello {

	print "hello niggas"
}

1;

#todo obj deve retornar valor 1 e a extensão dos arquivos é sempre .pm