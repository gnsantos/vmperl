#!/usr/bin/perl
use v5.10;
use strict;
use warnings;

package operation;

sub printResult {
	print "ok!";
}

sub new {
	my $class = shift;
	my $self = {
		#idealmente em perl usa-se um hash para manter uma struct de 
		#dados, e eles terao uma relacao (chave => conteudo(separados por virgula)), no caso 
		#a chave será um literal e conteudo um tipo de dado, e podem
		#ser definidos como se segue:
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
	# print "----------TUDO OK!----------\n";
	bless $self,$class;
	return $self;
}

#calcula a operacao
sub checkOpt{
	my $self = shift;
	my $opt = shift;
	if (exists $self->{$opt}){	return 1;	}
	else {	return 0;	}
} 
sub makeAritmetic{

	my $self = shift;
	($self->{number1},$self->{number2},my $opc) = @_;
	my $stat = $self->{$opc};
	return &$stat($self,$opc);
}

sub sumOpt{
	my $self = shift;
	return ($self->{number1} + $self->{number2});
}


sub subOpt{
	my $self = shift;
	return ($self->{number2} - $self->{number1});
}

sub timOpt{
	my $self = shift;
	return ($self->{number1}*$self->{number2});
}

sub divOpt{
	my $self = shift;
	if ($self->{number2} != 0){
		return ($self->{number2}/$self->{number1});
	}
	else{
		return 777;
	}
}

sub logicComp{
	my $self = shift;
	my $opCode = shift;
	# print "($self->{number1} x $self->{number2})\n";
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
