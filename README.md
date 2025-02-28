# Lexical-semantic-evolution
This repository contains the analytical codes and diachronic semantic data for the paper "***Stochastic modeling of socio-cultural influences on the lexical semantic evolution***".

## Diachronic Semantic Data
The diachronic semantic data are stored in an RData file named **"polysemous_data.Rdata"**. For each word, e.g. ***"entertain"***, we give its diachronic sense information as demonstrated in the following structure:
```bash
> polysemous_data$entertain
$word
[1] "entertain"

$senses
$senses$entertain_1_verb_1
$senses$entertain_1_verb_1$definition     # Lexical definition source: Oxford English Dictionary (OED)
[1] "Provide (someone) with amusement or enjoyment."

$senses$entertain_1_verb_1$x     # Year information with the time interval ∆t = 10
 [1] 1830 1840 1850 1860 1870 1880 1890 1900 1910 1920 1930 1940 1950 1960
[15] 1970 1980 1990 2000 2010

$senses$entertain_1_verb_1$y     # The proportion of the sense at each time inerval
 [1] 0.1811594 0.2236842 0.2619048 0.3038869 0.3958333 0.4886364 0.4239482
 [8] 0.5090253 0.5934959 0.5363636 0.6622807 0.6990291 0.7241379 0.6890244
[15] 0.6666667 0.6547619 0.7880435 0.7189189 0.8095238


$senses$entertain_1_verb_2
$senses$entertain_1_verb_2$definition
[1] "Give attention or consideration to (an idea or feeling)"

$senses$entertain_1_verb_2$x
 [1] 1830 1840 1850 1860 1870 1880 1890 1900 1910 1920 1930 1940 1950 1960
[15] 1970 1980 1990 2000 2010

$senses$entertain_1_verb_2$y
 [1] 0.8188406 0.7763158 0.7380952 0.6961131 0.6041667 0.5113636 0.5760518
 [8] 0.4909747 0.4065041 0.4636364 0.3377193 0.3009709 0.2758621 0.3109756
[15] 0.3333333 0.3452381 0.2119565 0.2810811 0.1904762


$n_senses     # Sense number of the word
[1] 2

$df     # Data after cubic spline interpolation, where sense1 denotes dominant sense
   year    sense1    sense2
1  1830 0.8188406 0.1811594
2  1832 0.8098068 0.1901932
3  1834 0.8011020 0.1988980
[... truncated for brevity ...]
90 2008 0.2426142 0.7573858
91 2010 0.1904762 0.8095238
```
---
