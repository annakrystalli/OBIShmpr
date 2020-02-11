#' Title
#'
#' @param sp_id 
#' @param save_all_recs 
#' @param check_match 
#' @param use_defaults 
#'
#' @return
#' @export
#'
#' @examples
get_temp_summ_by_sp <- function(sp_id, save_all_recs = TRUE, check_match = TRUE, use_defaults = TRUE){
    # function to get OBIS records for a given species and match to IAP and Bio-Oracle temperatures
    # if save_all_recs == TRUE, this full matched dataset will be saved before summarising
    # function returns a summary of temperature affinity of the species
    
    # First, check if this species has previously been matched, if check_match is TRUE
    # (This is an option in case the user wants to update all records)
    
    if(check_match == TRUE){
        out_path <- ifelse(use_defaults, paste0(file.path(getwd()), "/t_matched_obis_recs"),
                           paste0(bespoke_path, "/t_matched_obis_recs"))
        # set species_done flag to FALSE
        species_done <- FALSE
        
        # check if the directory exists:
        if(dir.exists(file.path(out_path))){
            # get list of aphia ids from the files in this directory:
            done_files <- list.files(path = out_path)
            done_aphias <- done_files %>%
                word(sep = "_") %>%
                str_replace(pattern = "aphia", replacement = "") %>%
                as.integer()
            
            # check if species sp_id is in this list
            species_done <- sp_id %in% done_aphias
        }
        
        # get the file if it exists
        if(species_done == TRUE){
            which_file <- which(done_aphias == sp_id)
            
            # what if more than one file matches?
            if(length(which_file) > 1){
                # find the most recent one
                which_file <- which_file[order(done_files[which_file], decreasing = TRUE) == 1]
            }
            
            sp_temp <- read_csv(file = paste(out_path, done_files[which_file], sep = "/"),
                                col_types = cols(
                                    decimalLongitude = col_double(),
                                    decimalLatitude = col_double(),
                                    depth = col_double(),
                                    eventDate = col_datetime(format = ""),
                                    scientificName = col_character(),
                                    aphiaID = col_integer(),
                                    year = col_integer(),
                                    month = col_character(),
                                    depth0 = col_double(),
                                    grid_depth = col_integer(),
                                    grid_lon = col_integer(),
                                    grid_lat = col_integer(),
                                    iap_t = col_double(),
                                    iap_sst = col_double(),
                                    iap_sbt = col_double(),
                                    iap_grid_bottom_depth = col_integer(),
                                    bo_sst = col_double(),
                                    bo_sbt = col_double()
                                )) %>%
                t_summary() %>%
                mutate(species_id = sp_id) %>%
                dplyr::select(species_id, everything())
        } else {
            sp_temp <- get_obis_recs(species_id = sp_id) %>%
                get_iap_gridded_t() %>%
                get_bio_oracle_t() %>%
                save_full_recs(save_recs = save_all_recs) %>%
                t_summary() %>%
                mutate(species_id = sp_id) %>%
                dplyr::select(species_id, everything())
        }
    } else {
        sp_temp <- get_obis_recs(species_id = sp_id) %>%
            get_iap_gridded_t() %>%
            get_bio_oracle_t() %>%
            save_full_recs(save_recs = save_all_recs) %>%
            t_summary() %>%
            mutate(species_id = sp_id) %>%
            dplyr::select(species_id, everything())
    }
    
    sp_temp
}