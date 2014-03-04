# POD documentation - main docs before the code

=head1 NAME

GenOOx::Data::File::SAMbwa::Record - Represents a record of a SAM format file generated by BWA

=head1 SYNOPSIS

    # Object representing a record of a sam file 

    # To initialize 
    my $sam_record = GenOOx::Data::File::SAMbwa::Record->new(
        fields => [qname,flag, rname, pos, mapq, cigar,
                   rnext, pnext, tlen, seq, qual, tags]
    );


=head1 DESCRIPTION

    This object represents a record of a sam file generated by BWA and offers methods for accessing the different
    attributes. It implements several additional methods that transform original attributes in more manageable
    attributes. eg. from the FLAG attribute the actual strand is extracted etc.

=head1 EXAMPLES

    # Check if the record corresponds to a match
    my $mapped = $sam_record->is_mapped;
    
    # Check if the record corresponds to a non match
    my $unmapped = $sam_record->is_unmapped;
    
    # Parse the FLAG attribute and return 1 or -1 for the strand
    my $strand = $sam_record->strand;

=cut

# Let the code begin...

package GenOOx::Data::File::SAMbwa::Record;
$GenOOx::Data::File::SAMbwa::Record::VERSION = '0.0.3';

#######################################################################
#######################   Load External modules   #####################
#######################################################################
use Moose;
use namespace::autoclean;


#######################################################################
############################   Inheritance   ##########################
#######################################################################
extends 'GenOO::Data::File::SAM::Record';


#######################################################################
########################   Interface Methods   ########################
#######################################################################
sub number_of_best_hits {
	my ($self) = @_;
	
	return $self->tag('X0:i');
}

sub number_of_suboptimal_hits {
	my ($self) = @_;
	
	return $self->tag('X1:i') || 0;
}

sub number_of_mappings {
	my ($self) = @_;
	
	return $self->number_of_best_hits + $self->number_of_suboptimal_hits;
}

sub alternative_mappings {
	my ($self) = @_;
	
	my @alternative_mappings;
	my $value = $self->tag('XA:Z');
	if (defined $value) {
		@alternative_mappings = split(/;/,$value);
	}
	return @alternative_mappings;
}


#######################################################################
############################   Finalize   #############################
#######################################################################
__PACKAGE__->meta->make_immutable;

1;
