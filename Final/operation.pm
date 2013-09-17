#!/usr/bin/perl
use v5.10;
use strict;
use warnings;

package operation;
#Construtor da Classe operation
sub new {
	my $class = shift;
	my $self = {
		number1 => undef,
		number2 => undef,
		ADD => \&sumOpt,
		SUB => \&subOpt,
		MUL => \&timOpt,
		DIV => \&divOpt,
		JIT => \&logicComp,
		JIF => \&logicComp,
		EQ => \&logicComp,
		GT => \&logicComp,
		GE => \&logicComp,
		LT => \&logicComp,
		LE => \&logicComp,
		NE => \&logicComp,
	};
	bless $self,$class;
	return $self;
}

#Verifica se o Opcode fornecido é um código válido

sub checkOpt{
	my $self = shift;
	my $opt = shift;
	if (exists $self->{$opt}){	return 1;	}
	else {	return 0;	}
} 
#Realiza a operação aritmética requisitada
sub makeAritmetic{

	my $self = shift;
	($self->{number1},$self->{number2},my $opc) = @_;
	my $stat = $self->{$opc};
	return &$stat($self,$opc);
}
#Soma
sub sumOpt{
	my $self = shift;
	return ($self->{number1} + $self->{number2});
}
#Subtração
sub subOpt{
	my $self = shift;
	return ($self->{number2} - $self->{number1});
}
#Produto
sub timOpt{
	my $self = shift;
	return ($self->{number1}*$self->{number2});
}
#Divisão
sub divOpt{
	my $self = shift;
	if ($self->{number2} != 0){
		return ($self->{number2}/$self->{number1});
	}
	else{
		print "Divisao por Zero!";
		return -1;
	}
}
#Comparação Lógica
sub logicComp{
	my $self = shift;
	my $opCode = shift;
	given($opCode)
	{
		when("EQ"){ return ($self->{number1} == $self->{number2}); }
		when("GT"){ return ($self->{number1} >  $self->{number2}); }
		when("GE"){ return ($self->{number1} >= $self->{number2}); }
		when("LT"){ return ($self->{number1} <  $self->{number2}); }
		when("LE"){ return ($self->{number1} <= $self->{number2}); }
		when("NE"){ return ($self->{number1} != $self->{number2}); }
		default{print "\nDeu errado!";}
	}
}

1;
