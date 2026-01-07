# Lexical-semantic-change  
This repository contains the diachronic semantic data and analytical codes for the paper "***Stochastic modeling of lexical semantic competition in words***".  
## Data Description
- **`polysemous_data.Rdata`**:  
  An R data object containing two-sense diachronic sense-proportion trajectories for polysemous words.  
  Each entry (e.g., `polysemous_data$entertain`) is a list with:
    - `word`: the target word  
  - `senses`: OED-defined senses, including sense definitions and raw yearly sense proportions  
  - `n_senses`: number of senses (here, 2)  
  - `df`: a three-column data frame used for modeling, with columns:
    - `year`: time index (strictly increasing)
    - `sense1`: proportion trajectory for sense 1
    - `sense2`: proportion trajectory for sense 2  
    The simplex constraint `sense1 + sense2 = 1` holds at each time point.

  Example structure:

```r
> polysemous_data$entertain
$word
[1] "entertain"

$senses
$senses$entertain_1_verb_1
$senses$entertain_1_verb_1$definition     # Lexical definition source: Oxford English Dictionary (OED)
[1] "provide (someone) with amusement or enjoyment."

$senses$entertain_1_verb_1$x     # Year information with the time interval ∆t = 1
  [1] 1820 1821 1822 1823 1824 1825 1826 1827 1828 1829 1830 1831 1832 1833 1834
 [16] 1835 1836 1837 1838 1839 1840 1841 1842 1843 1844 1845 1846 1847 1848 1849
  ...
[151] 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984
[166] 1985 1986 1987 1988 1989

$senses$entertain_1_verb_1$y     # The proportion of the sense at each time inerval
  [1] 0.1475410 0.1470588 0.1678832 0.1718750 0.1849315 0.2015504 0.2048193 0.2000000 0.2037037 0.1966102 0.1855204 0.1722846 0.1821192 0.1818182 0.2049383
 [16] 0.2088773 0.2162850 0.1967963 0.2059621 0.1758530 0.1636364 0.1900826 0.1969697 0.1983240 0.2288136 0.2630273 0.2423529 0.2824601 0.2888889 0.2877030
  ...
[151] 0.7007299 0.6642857 0.6666667 0.6030534 0.6212121 0.6390977 0.6567164 0.6666667 0.6883117 0.7225806 0.7278481 0.7454545 0.7739726 0.7826087 0.7786260
[166] 0.7686567 0.7681159 0.7676056 0.7520661 0.7413793


$senses$entertain_1_verb_2
$senses$entertain_1_verb_2$definition
[1] "give attention or consideration to (an idea or feeling)"

$senses$entertain_1_verb_2$x
  [1] 1820 1821 1822 1823 1824 1825 1826 1827 1828 1829 1830 1831 1832 1833 1834
 [16] 1835 1836 1837 1838 1839 1840 1841 1842 1843 1844 1845 1846 1847 1848 1849
  ...
[151] 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984
[166] 1985 1986 1987 1988 1989

$senses$entertain_1_verb_2$y
  [1] 0.8524590 0.8529412 0.8321168 0.8281250 0.8150685 0.7984496 0.7951807 0.8000000 0.7962963 0.8033898 0.8144796 0.8277154 0.8178808 0.8181818 0.7950617
 [16] 0.7911227 0.7837150 0.8032037 0.7940379 0.8241470 0.8363636 0.8099174 0.8030303 0.8016760 0.7711864 0.7369727 0.7576471 0.7175399 0.7111111 0.7122970
  ...
[151] 0.2992701 0.3357143 0.3333333 0.3969466 0.3787879 0.3609023 0.3432836 0.3333333 0.3116883 0.2774194 0.2721519 0.2545455 0.2260274 0.2173913 0.2213740
[166] 0.2313433 0.2318841 0.2323944 0.2479339 0.2586207


$n_senses     # Sense number of the word
[1] 2

$df     # Data after cubic spline interpolation, where sense1 denotes dominant sense
# A tibble: 170 × 3
    year sense1 sense2
   <int>  <dbl>  <dbl>
 1  1820  0.852  0.148
 2  1821  0.853  0.147
 3  1822  0.832  0.168
 4  1823  0.828  0.172
 5  1824  0.815  0.185
 6  1825  0.798  0.202
 7  1826  0.795  0.205
 8  1827  0.8    0.2  
 9  1828  0.796  0.204
10  1829  0.803  0.197
# ℹ 160 more rows
# ℹ Use `print(n = ...)` to see more rows
```

- **`diachronic_meaning_change.xlsx`**:  
  A diachronic semantic dataset constructed in this study, containing proportion trajectories for 14,347 senses across 3,168 polysemous words from 1810 to 2009.

- **`diachronic_change_statistics.xlsx`**:  
  Provides frequency/semantic change degrees and key parameters from the semantic competition model for the 3168 polysemous words: 
  - `freq_change`: frequency change
  - `semantic_change`: semantic change
  - `r_1`: internal inheritance rate  
  - `σ_1`: competition coefficient  
  - `c`: diffusion coefficient

- **`semantic_domain.xlsx`**:  
  Semantic domain labels of the 3168 words as described in Supplementary Methods Section 1.

- **`external_factors.xlsx`**:  
  Data for driving force analysis, as introduced in Supplementary Discussion Section 1.

## Code for Word Sense Disambiguation 

See code in `label_sense`.

### Prerequisites

**1. Install Python packages**

*   **`Python 3.5+`**
*   **[`NLTK`](http://www.nltk.org/install.html)**
*   **[`bert_serving`](https://pypi.org/project/bert-serving-server/)**

**2. Download the pre-trained language model**

In this study, we used the [`uncased BERT-Base`](https://storage.googleapis.com/bert_models/2018_10_18/uncased_L-12_H-768_A-12.zip) model to generate deep contextualized word embeddings. More options can be found at https://github.com/google-research/bert.

Since BERT is a deep learning model, it is suggested to use the tool on a **GPU-based** device.

### Automatic analysis 

**Step 1. Start the BERT service.**

```python
bert-serving-start \
    -pooling_strategy NONE \
    -max_seq_len 128 \
    -pooling_layer -1 \
    -device_map 0 \           # please specify the GPU device ID
    -model_dir bert_base \    # please specify the directory of the pre-trained BERT model
    -show_tokens_to_client \
    -priority_batch_size 32   # batch_size is set based on GPU memory, in this study the Nvidia 1080TI (11G memory) is used.
```

**Step 2. Tag the senses for polysemous words.**

```python
python tag_text_server.py
```

**Step 3. Terminate the BERT service.**

```python
bert-serving-terminate -port 5555
```


## Code for SDE Modeling

See code in `r.SDE.Bayesian` (an R package implementing the SDE–Bayesian inference pipeline for two-sense semantic competition).

### Prerequisites

**1. Install R and required packages**

*   **`R (>= 4.1.0)`** (recommended)
*   **`fmcmc`**
*   **`coda`**
*   **`MASS`**
*   **`devtools`** and **`roxygen2`**
*   **`Sim.DiffProc`** 
  
Example installation in R:
```r
install.packages(c("fmcmc", "coda", "MASS", "devtools", "roxygen2", "Sim.DiffProc"))
```
**2. Prepare input data**  
The core fitting functions expect a data frame (or matrix) with **three columns**:  

*   `time` (strictly increasing)
*   `sense1` (proportion trajectory for sense 1)
*   `sense2` (proportion trajectory for sense 2), with the simplex constraint **`sense1 + sense2 = 1`**

In this repository, an example object is available as:  
*   `polysemous_data$entertain$df` (columns: `year`, `sense1`, `sense2`)


### Usage  
**Step 1. Install the `r.SDE.Bayesian` package locally.**

```r
# Method 1: Install Directly from GitHub
# Install the remotes package if not already installed
install.packages("remotes")

# Install r.SDE.Bayesian from GitHub
remotes::install_github("ZhangXuan0429/r.SDE.Bayesian")


# Method 2: Download ZIP and Install Locally
# Download the ZIP file from GitHub first, then extract the ZIP file.
remotes::install_local("yourpath/r.SDE.Bayesian-main", force = TRUE, upgrade = "never")

# Load the package
library(r.SDE.Bayesian)
```

**Step 2. Run MCMC to fit the LV-style competition SDE.**
```r
set.seed(123)

result <- polysemous_data$entertain
dat <- result$df 

chain <- sde_mcmc_fit(
  dat = dat,
  initial = rep(0.01, 3),
  nsteps = 20000,
  prior_max = 100
)
```

**Step 3. Check convergence and summarize posterior estimates.**
```r
# Log-posterior trace
lp <- apply(chain, 1, function(p) sde_log_posterior(
  par = p,
  dat = dat,
  prior_max = 100
))

# Geweke diagnostic on last 2000 samples
(geweke <- coda::geweke.diag(tail(lp, 2000)))

# Posterior mean of last 2000 samples
(par_lv <- colMeans(tail(chain, 2000)))
```
**Step 4. Solve (simulate) the fitted SDE trajectory using `Sim.DiffProc`.**  
```r
library(Sim.DiffProc)

# We simulate x1(t) under the fitted SDE; x2(t) is enforced as 1 - x1(t).
# The drift uses the LV-style form consistent with the manuscript:
# dx1 = r1 * x1 * (1 - x1 - sigma1 * (1 - x1)) dt + c dW

set.seed(123)

mod <- snssde1d(
  drift = expression(par_lv[1] * x * (1 - x - par_lv[2] * (1 - x))),
  diffusion = expression(par_lv[3]),
  x0 = as.numeric(dat$x1[1]),
  M  = 10000,
  t0 = as.numeric(dat$time[1]),
  T  = as.numeric(dat$time[nrow(dat)]),
  Dt = 1,
  N  = nrow(dat) - 1,
  method = "euler"
)
```

**Step 5 (optional). Fit the replicator-drift SDE under the same inference pipeline.**  
The package supports alternative drift forms by switching the transition density function:  
```r
set.seed(123)

chain_rep <- sde_mcmc_fit(
  dat = dat,
  initial = rep(0.01, 3),
  nsteps = 20000,
  prior_max = 100,
  log_cond_pdf = sde_log_cond_pdf_replica
)

(par_rep <- colMeans(tail(chain_rep, 2000)))
```
---
