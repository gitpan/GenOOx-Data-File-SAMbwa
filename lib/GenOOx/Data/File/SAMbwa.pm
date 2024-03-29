# POD documentation - main docs before the code

=head1 NAME

GenOOx::Data::File::SAMbwa - GenOO framework extension to read SAM files created by the BWA aligner

=head1 SYNOPSIS

GenOO framework extension to read SAM files created by the BWA aligner.
Include it in your script and ask GenOO SAM parser to use it.

    use GenOOx::Data::File::SAMbwa::Record;

    my $file_parser = GenOO::Data::File::SAM->new(
        file          => 'file.sam',
        records_class => 'GenOOx::Data::File::SAMbwa::Record'
    );

    while (my $record = $file_parser->next_record) {
        # $record is now an instance of GenOOx::Data::File::SAMbwa::Record.
        print $record->cigar."\n"; # name
        print $record->flag."\n"; # flag
        print $record->number_of_mappings."\n"; # new stuff not present by default
    }


=head1 DESCRIPTION

The GenOO framework SAM parser avoids code that is unique to specific programs and makes no assumptions for the optional fields in a SAM file. This module is a plugin for the GenOO framework and provides the functionality for reading SAM files generated from the BWA aligner. The module has been created on top of the generic GenOO SAM parser and to use it just include it in your scripts and ask GenOO SAM parser to use it.

=head1 EXAMPLES

    # Create a parser
    my $file_parser = GenOO::Data::File::SAM->new(
        file          => 'file.sam',
        records_class => 'GenOOx::Data::File::SAMbwa::Record'
    );

    # Loop on the records of the file
    while (my $record = $file_parser->next_record) {
        # $record is now an instance of GenOOx::Data::File::SAMbwa::Record.
        print $record->cigar."\n"; # name
        print $record->flag."\n"; # flag
        print $record->number_of_mappings."\n"; # new stuff not present by default in GenOO
    }

=cut

# Let the code begin...

package GenOOx::Data::File::SAMbwa;
$GenOOx::Data::File::SAMbwa::VERSION = '0.0.3';

#######################################################################
#######################   Load External modules   #####################
#######################################################################
use Modern::Perl;


1;
