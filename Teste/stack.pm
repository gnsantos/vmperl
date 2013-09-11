#o "strict" te obriga a declarar todas as variáveis - ou seja, se quiser fazer variável global, 
#deve usar "our", e para fazer variáveis locais, deve fazer "my".
#Isso é um "pragma" do Perl, que funciona como uma "diretiva de compilação" para a linguagem. 
#Vai te evitar problemas de criar variáveis sem querer (o "espirra e cria uma variável" do Gubi)
#
#By The Lord of The Perl (Renatão)
#
use v5.14;
use strict;
use warnings;
use operation;
package stack ;

sub new {
	my $class= shift;
    my $self = {
    	lista => [],
    	#indx => 0
    };
    # Print all the values just for clarification.
    bless $self, $class;
    return $self;

}

sub showTop{
	my $self = shift;
	my $ln = scalar @{$self->{lista}};
	my $last = $self->{lista}[$ln - 1];
	#print "My last = $last \n";
	return $last;
}

sub shiftStack{
	my $self = shift;
	my $val1 = pop(@{$self->{lista}});
	my $val2 = pop(@{$self->{lista}});
	push (@{$self->{lista}}, $val1);
	push (@{$self->{lista}}, $val2);
	#print ">>>> Val1 == $val1 xxxxx Val2 == $val2";
}

sub pile{

	my ($self, $Item) = @_;
	print "vak = $Item \n";
	push (@{$self->{lista}}, $Item);
	#$self->{indx}++;
}

sub removeItem{
	my $self = shift;
	pop(@{$self->{lista}});
}

sub dup{
	my $self = shift;
	#my $temp = 2*pop(@{$self->{lista}});
	#push (@{$self->{lista}}, $temp);
	push (@{$self->{lista}}, 2*pop(@{$self->{lista}}));

}

sub unstack{
	my $self = shift;
	#$l = $self->{lista};
	#print "valor de l = $l \n";
	#$k = $self->{lista}[$l - 1];
	#print "Valor de k = $k \n\n";
	#$self->{indx}--;
	return pop(@{$self->{lista}});
}

sub printaStack{
	my $self = shift;
	my $ln = scalar @{$self->{lista}};
	print "Valor ln = $ln \n";
	print ("\n\n");
	my $in = 0;
	for (; $in < $ln; $in++){
		print "val # = $self->{lista}[$in] \n";	
	}
}
1;