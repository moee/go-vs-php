set term svg
set output "result.svg"

set yrange [0:28]

set style fill solid 0.25 border -1
set style boxplot nooutliers pointtype 7
set style data boxplot
set boxwidth  0.5
set pointsize 0.5
set title "ab benchmark (15 threads, 10k requests)"
set ylabel "Total response time (ms)"
unset key

set xtics ("PHP 5" 1, "PHP 7" 2, "go" 3)
set xtics nomirror
set ytics nomirror

plot 'php5/ab.dat' using (1):10, \
	'php7/ab.dat' using (2):10, \
	'go/ab.dat' using (3):10
