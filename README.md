
<!-- README.md is generated from README.Rmd. Please edit that file -->

# OBIShmpr

<!-- badges: start -->

<!-- badges: end -->

The goal of OBIShmpr is to link and query OBIS occurence data with a
variety of marine habitat data.

### Data Sources

  - #### Bio-ORACLE:
    
    a set of GIS rasters providing geophysical, biotic and environmental
    data for surface and benthic marine realms.
    <https://www.bio-oracle.org/>. Accessed via
    [`sdmpredictors`](https://github.com/lifewatch/sdmpredictors)

  - #### EMODnet Seabed Habitat maps:
    
    a

  - #### [Synthetic map of the NW European Shelf sedimentary environment](https://www.earth-syst-sci-data.net/10/109/2018/essd-10-109-2018.pdf)
    
    **data product**
    [10.15129/1e27b806-1eae-494d-83b5-a5f4792c46fc](https://pureportal.strath.ac.uk/en/datasets/data-for-a-synthetic-map-of-the-northwest-european-shelf-sediment)
    0.125◦ by 0.125◦ resolution synthetic maps of continuous properties
    of the north-west European sedimentary environment. The maps are a
    blend of gridded survey data, statistically modelled values based on
    distributions of bed shear stress due to tidal currents and waves
    and bathymetric properties.
    
      - percentage compositions of mud, sand and gravel;
      - porosity and permeability;
      - median grain size of the whole sediment and of the sand and the
        gravel fractions;
      - carbon and nitrogen content of sediments;
      - percentage of seabed area covered by rock;
      - mean and maximum depth-averaged tidal velocity and wave orbital
        velocity at the seabed; and mean monthly natural disturbance
        rates.

  - #### [EMODnet Habitat maps]()

## Installation

<!-- You can install the released version of OBIShmpr from [CRAN](https://CRAN.R-project.org) with: 

``` r
install.packages("OBIShmpr")
```
-->

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("annakrystalli/OBIShmpr")
```

## Example

### Get habitat data for a species

``` r
library(OBIShmpr)
## basic example code
```

## An example with one species

This is an example of how to run the above code for a single species -
we use *Scytothamnus fasciculatus*, Aphia ID 325567, chosen as it has
just 6 OBIS records so should run reasonably quickly.

``` r
get_temp_summ_by_sp(sp_id = 325567)
```

### Get species profile for habitat
