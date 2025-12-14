#' Merge SDTM SUPP Domain with Main Domain
#'
#' Reads an SDTM main domain dataset and its corresponding SUPP domain,
#' reshapes supplemental qualifiers to wide format, and merges them into
#' the main domain according to SDTM conventions.
#' @param path Character string specifying the directory containing the
#' domain datasets.
#' @param domain Character string specifying the SDTM domain name
#' (e.g., \code{"AE"}, \code{"DM"}).
#' @param ext Character string specifying the file extension.
#' Supported values are \code{".sas7bdat"}, \code{".xpt"},
#'   \code{".RData"}, and \code{".RDS"}.
#'
#' @details
#' For non-DM domains, supplemental qualifiers are merged using
#' \code{STUDYID}, \code{USUBJID}, and the identifier variable specified
#' in \code{IDVAR}. For the DM domain, qualifiers are merged using
#' \code{STUDYID} and \code{USUBJID} only.
#'
#' @return
#' A data frame containing the main SDTM domain with supplemental
#' qualifiers merged as additional columns. Variable labels from the
#' SUPP domain are preserved where available.
#'
#'
#' @import rlang
#'
#' @importFrom haven read_sas read_xpt zap_missing
#' @importFrom dplyr mutate across filter select left_join where join_by
#' @importFrom tidyr pivot_wider
#' @importFrom stringr str_to_upper str_detect
#' @importFrom rlang sym
#' @importFrom magrittr %>%
#'
#'
#' @examples
#' \dontrun{
#' merge_supp(path = "data/sdtm/", domain='AE', ext='.sas7bdat'
#' )
#' }
#'
#' @export
merge_supp <- function(path=NULL,domain=NULL, ext=NULL){

# browser()
  domain <- as.character(substitute(domain))

  ## =========================================================
  ## NEW: handle in-memory data when path is NULL
  ## =========================================================
  if (is.null(path)) {

    main_name <- domain
    supp_name <- paste0("SUPP", domain)

    if (!exists(main_name, envir = parent.frame()) ||
        !exists(supp_name, envir = parent.frame())) {
      stop(
        paste(
          "Datasets", main_name, "and", supp_name,
          "must exist in memory when path is NULL"
        )
      )
    }

    main_domain <- get(main_name, envir = parent.frame())
    supp_domain <- get(supp_name, envir = parent.frame())

  } else {
    ## =========================================================
    ## EXISTING FILE-BASED LOGIC (UNCHANGED)
    ## =========================================================
    path <- as.character(substitute(path))

    filepath <- paste0(path,domain,ext)
    suppfilepath <- paste0(path,'SUPP',domain,ext)

    if (!(file.exists(suppfilepath) && file.exists(filepath))){
      stop(paste('SUPP or Main Domain File not found', filepath))
    } else {
      print(paste('File exists', filepath))
    }

    main_domain <- switch(ext,
                          ".sas7bdat" = haven::read_sas(filepath),
                          ".xpt"      = haven::read_xpt(filepath),
                          ".rda"    = load(filepath),
                          ".RDS"      = readRDS(filepath),
                          stop("Unsupported file type: ", ext)
    )

    supp_domain <- switch(ext,
                          ".sas7bdat" = haven::read_sas(suppfilepath),
                          ".xpt"      = haven::read_xpt(suppfilepath),
                          ".rda"    = load(suppfilepath),
                          ".RDS"      = readRDS(suppfilepath),
                          stop("Unsupported file type: ", ext)
    )
  }

  supp_domain <- supp_domain %>% dplyr::mutate(across(where(is.numeric), haven::zap_missing)) %>%
    filter(RDOMAIN == str_to_upper(domain))

  if (nrow(supp_domain)>0 && ! domain %in% c("DM","CO")) {
    suppn <- names(supp_domain)[str_detect(names(supp_domain),'^IDVAR')]
    if (length(suppn)>0) {
      idname <- unique(supp_domain$IDVAR)
      qnam <- unique(supp_domain$QNAM)
      qlab <- unique(supp_domain$QLABEL)
      suppd <- supp_domain %>% mutate(!!sym(idname) := as.numeric(IDVARVAL)) %>%
        select(STUDYID, USUBJID, !!sym(idname),QNAM, QVAL ) %>%
        pivot_wider(names_from = QNAM, values_from = QVAL)

      for (i in seq_along(qnam)) {
        var <- qnam[i]
        lbl <- qlab[i]
        attr(suppd[[var]], "label") <- lbl
      }

      main_domain <- main_domain %>% left_join(suppd, join_by(STUDYID, USUBJID, !!sym(idname)))
    }
  } else if (nrow(supp_domain)>0 && domain == "DM"){
    suppn <- unique(supp_domain$QNAM)
    if (length(suppn)>0) {
      qnam <- unique(supp_domain$QNAM)
      qlab <- unique(supp_domain$QLABEL)
      suppd <- supp_domain %>%
        select(STUDYID, USUBJID,QNAM, QVAL ) %>%
        pivot_wider(names_from = QNAM, values_from = QVAL)

      for (i in seq_along(qnam)) {
        var <- qnam[i]
        lbl <- qlab[i]
        attr(suppd[[var]], "label") <- lbl
      }
      main_domain <- main_domain %>% left_join(suppd, join_by(STUDYID, USUBJID))
    }
  }
  # browser()
  message('Succefully merged')
  return(main_domain)

}

 # merge_supp(path = "data/", domain = 'AE', ext = ".rda")
