#o "strict" te obriga a declarar todas as variáveis - ou seja, se quiser fazer variável global, 
#deve usar "our", e para fazer variáveis locais, deve fazer "my".
#Isso é um "pragma" do Perl, que funciona como uma "diretiva de compilação" para a linguagem. 
#Vai te evitar problemas de criar variáveis sem querer (o "espirra e cria uma variável" do Gubi)
#
#By The Lord of The Perl (Renatão)
#

use strict;
use warnings;

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

sub insertItem{

	my ($self, $Item) = @_;
	print "vak = $Item \n";
	push (@{$self->{lista}}, $Item);
	#$self->{indx}++;
}

sub removeItem{
	my $self = shift;
	#$l = $self->{lista};
	#print "valor de l = $l \n";
	#$k = $self->{lista}[$l - 1];
	#print "Valor de k = $k \n\n";
	#$self->{indx}--;
	return pop(@{$self->{lista}});
}

sub printaStack{
	my ($self,$indx) = @_;
	my $ln = scalar @{$self->{lista}};
	print "Valor ln = $ln \n";
	print ("\n\n");
	my $in = 0;
	for (; $in < $ln; $in++){
		print "val # = $self->{lista}[$in] \n";	
	}
}
1;