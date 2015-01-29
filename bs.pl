#!/usr/bin/perl -w
#use strict;
srand;

my @pronouns = qw(I we they);
my @articles = qw(the your my);
my @sub_conjuncs = (
    'after', 'although', 'as', 'as if', 'as long as', 'as though', 'because',
    'before', 'even if', 'even though', 'if', 'if only', 'in order that',
    'now that', 'once', 'rather than', 'since', 'so that', 'though', 'unless',
    'until', 'when', 'whenever', 'where', 'whereas', 'wherever', 'while'
    );
my @power_words = qw(
    accomplished dealt implemented projected achieved debated improved
    promoted acquired decided included proofed adjusted defined increased
    purchased administered delegated indicated qualified advised delivered
    initiated questioned analyzed demonstrated inspected rated applied
    designed instructed received appraised determined insured recognized
    arranged developed interpreted recommended assessed devised interviewed
    recorded assisted directed introduced recruited assured discovered
    investigated reduced awarded dispensed joined rehabilitated bought
    displayed kept related briefed distributed launched renovated brought
    earned led repaired budgeted edited located reported calculated educated
    maintained represented cataloged elected managed researched chaired
    encouraged maximized reviewed changed enlisted measured revised
    classified ensured mediated selected closed entertained modified served
    coached established motivated simplified combined evaluated named
    sketched communicated examined negotiated sold compared excelled observed
    solved completed executed obtained spearheaded computed exhibited
    operated specified conceived expanded ordered started concluded expedited
    organized streamlined conducted explained paid strengthened confronted
    facilitated participated studied constructed financed perceived suggested
    continued forecast performed summarized contracted formulated persuaded
    supervised controlled gained placed targeted convinced gathered planned
    taught coordinated graded predicted tested corrected greeted prepared
    trained  corresponded guided presented translated counseled handled
    processed treated created helped produced updated critiqued identified
    programmed wrote integrated
);
my @verbs = qw(
    aggregate architect benchmark brand cultivate deliver deploy
    disintermediate drive e-enable embrace empower enable engage engineer
    enhance envision evolve expedite exploit extend facilitate generate
    grow harness implement incentivize incubate innovate integrate iterate
    leverage maximize mesh monetize morph optimize orchestrate recontextualize
    reintermediate reinvent repurpose revolutionize scale seize strategize
    streamline syndicate synergize synthesize target transform transition
    unleash utilize visualize whiteboard
);
my @aux_verbs = (
    'will', 'shall', 'may', 'might', 'can', 'could', 'must',
    'ought to', 'should', 'would', 'need to'
    );
my @adjectives = qw(
    24/365 24/7 B2B B2C back-end best-of-breed bleeding-edge
    bricks-and-clicks clicks-and-mortar collaborative compelling
    cross-platform cross-media customized cutting-edge
    distributed dot-com dynamic e-business efficient
    end-to-end enterprise extensible frictionless front-end
    global granular holistic impactful innovative integrated interactive
    intuitive killer leading-edge magnetic mission-critical next-generation
    one-to-one open-source out-of-the-box plug-and-play proactive real-time
    revolutionary robust scalable seamless sexy sticky strategic synergistic
    transparent turn-key ubiquitous user-centric value-added vertical
    viral virtual visionary web-enabled wireless world-class
);
my @nouns = qw(
    action-items applications architectures bandwidth channels communities
    content convergence deliverables e-business e-commerce e-markets
    e-services e-tailers experiences eyeballs functionalities infomediaries
    infrastructures initiatives interfaces markets methodologies metrics
    mindshare models networks niches paradigms partnerships platforms
    portals relationships ROI synergies web-readiness schemas solutions
    supply-chains systems technologies users vortals
);
my @conj_adverbs = qw(however moreover nevertheless consequently);
my @conjuntors = qw(though although notwithstanding yet still);

my @sentences;
for (my $x=0; $x<100; $x++) {
    push @sentences, &sentence;
}
print join ' ', @sentences;

exit;

sub sentence {
    my $sentence;
    my $type = int(rand(5 - 1 + 1)) + 1;

    if ($type == 1) {
        $sentence = join ' ', maybe(&conj_adverb,1,4,', ') . &article,
        tobe(&noun), &power_word, &sub_conjunc,
        &pronoun, &power_word, &article,
        maybe(&adjective,1,2,' ') . &noun . maybe(&phrase,1,2,'');
    } elsif ($type == 2) {
        $sentence = join ' ', maybe(&conj_adverb,1,4,', ') . &sub_conjunc,
        &pronoun, &power_word, &article,
        maybe(&adjective,1,2,' ') . &noun . ',', &article,
        maybe(&adjective,1,2,' ') . &noun, &power_word, &article,
        maybe(&adjective,1,2,' ') . &noun . maybe(&phrase,1,3,'');
    } elsif ($type == 3) {
        $sentence = join ' ', maybe(&conj_adverb,1,4,', ') . &pronoun,
        &aux_verb, &verb, &article, maybe(&adjective,1,2,' ') . &noun,
        &sub_conjunc, &article, &adjective, plural(&noun), &aux_verb,
        &verb, &article,
        maybe(&adjective,1,2,' ') . &noun . maybe(&phrase,1,4,'');
    } elsif ($type == 4) {
        $sentence = join ' ', maybe(&conj_adverb,1,4,', ') . &sub_conjunc,
        &pronoun, &verb, &article, maybe(&adjective,1,2,' ') . &noun . ',',
        &pronoun, 'can', &verb, &article,
        maybe(&adjective,1,2,' ') . &noun . maybe(&phrase,1,4,'');
    } elsif ($type == 5) {
        $sentence = join ' ', maybe(&conj_adverb,1,4,', ') . &pronoun,
        &aux_verb, &verb, &article, maybe(&adjective,1,2,' ') . &noun,
        &sub_conjunc, &pronoun, &verb, &article,
        maybe(&adjective,1,2,' ') . &noun . maybe(&phrase,1,4,'');
    }

    return ucfirst($sentence) . '.';
}

sub pronoun { return $pronouns[int(rand($#pronouns+1))]; }
sub conjuntor { return $conjuntors[int(rand($#conjuntors+1))]; }
sub sub_conjunc { return $sub_conjuncs[int(rand($#sub_conjuncs+1))]; }
sub conj_adverb { return $conj_adverbs[int(rand($#conj_adverbs+1))]; }
sub power_word { return $power_words[int(rand($#power_words+1))]; }
sub verb { return $verbs[int(rand($#verbs+1))]; }
sub aux_verb { return $aux_verbs[int(rand($#aux_verbs+1))]; }
sub adjective { return $adjectives[int(rand($#adjectives+1))]; }
sub noun { return $nouns[int(rand($#nouns+1))]; }
sub article { return $articles[int(rand($#articles+1))]; }

sub phrase {
    return join ' ', ',', &conjuntor, &article, tobe(&noun), &power_word;
}

sub tobe {
    return $_[0] . ' is' if ($_[0] =~ /ess$/);
    return $_[0] . ' are' if ($_[0] =~ /s$/);
    return $_[0] . ' is';
}
sub plural {
    my $word = $_[0];
    if ($word =~ /s$/) {
        $word =~ s/$/es/;
    } else {
        $word =~ s/$/s/;
    }
    return $word;
}

sub adverb {
    my $verb = &verb;
    $verb =~ s/e*$/ing/;
    return $verb;
}

sub maybe {
    my $low = $_[1];
    my $high = $_[2];
    if (int(rand($high - $low + 1)) + $low == $low) {
        return $_[0] . $_[3];
    } else {
        return '';
    }
}
