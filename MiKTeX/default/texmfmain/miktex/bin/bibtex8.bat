@echo off
@rem Uncomment only one of the following strings in accordance 
@rem with the encoding used in your .tex, .bst files

@rem bibtex8.exe --huge --csfile ruscii   %1 %2 %3 %4 %5 %6 %7 %8 %9
@rem bibtex8.exe --huge --csfile 88591lat %1 %2 %3 %4 %5 %6 %7 %8 %9
@rem bibtex8.exe --huge --csfile 88591sca %1 %2 %3 %4 %5 %6 %7 %8 %9
@rem bibtex8.exe --huge --csfile 88592pl  %1 %2 %3 %4 %5 %6 %7 %8 %9
@rem bibtex8.exe --huge --csfile ascii %1 %2 %3 %4 %5 %6 %7 %8 %9
@rem bibtex8.exe --huge --csfile cp1250pl %1 %2 %3 %4 %5 %6 %7 %8 %9
@rem bibtex8.exe --huge --csfile cp437lat %1 %2 %3 %4 %5 %6 %7 %8 %9
@rem bibtex8.exe --huge --csfile cp850lat %1 %2 %3 %4 %5 %6 %7 %8 %9
@rem bibtex8.exe --huge --csfile cp850sca %1 %2 %3 %4 %5 %6 %7 %8 %9
@rem bibtex8.exe --huge --csfile cp852pl  %1 %2 %3 %4 %5 %6 %7 %8 %9
@rem bibtex8.exe --huge --csfile cp866rus %1 %2 %3 %4 %5 %6 %7 %8 %9
@rem bibtex8.exe --huge --csfile koi8u    %1 %2 %3 %4 %5 %6 %7 %8 %9
bibtex8.exe --huge --csfile cp1251   %1 %2 %3 %4 %5 %6 %7 %8 %9

