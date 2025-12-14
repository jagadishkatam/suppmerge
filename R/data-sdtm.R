#' Adverse Events (AE) SDTM Example Dataset
#'
#' A full SDTM Adverse Events (AE) domain provided as an example dataset.
#' This dataset follows CDISC SDTM conventions and is intended for
#' demonstration, testing, and development of SDTM-related utilities.
#'
#' @format A data frame with the following variables:
#' \describe{
#'   \item{STUDYID}{Study identifier}
#'   \item{DOMAIN}{Domain abbreviation}
#'   \item{USUBJID}{Unique subject identifier}
#'   \item{AESEQ}{Sequence number for adverse events}
#'
#'   \item{AETERM}{Reported term for the adverse event}
#'   \item{AEDECOD}{Dictionary-derived term}
#'   \item{AEBODSYS}{Body system or organ class}
#'   \item{AEBDSYCD}{Body system or organ class code}
#'
#'   \item{AELLT}{Lowest level term}
#'   \item{AELLTCD}{Lowest level term code}
#'   \item{AEHLT}{High level term}
#'   \item{AEHLTCD}{High level term code}
#'   \item{AEHLGT}{High level group term}
#'   \item{AEHLGTCD}{High level group term code}
#'   \item{AEPTCD}{Preferred term code}
#'
#'   \item{AESEV}{Severity of the adverse event}
#'   \item{AESER}{Serious event flag}
#'   \item{AESCONG}{Congenital anomaly or birth defect flag}
#'   \item{AESDISAB}{Persisting or significant disability/incapacity flag}
#'   \item{AESDTH}{Results in death flag}
#'   \item{AESHOSP}{Requires or prolongs hospitalization flag}
#'   \item{AESLIFE}{Life-threatening flag}
#'   \item{AESOC}{Body system or organ class}
#'   \item{AESOCCD}{Body system or organ class code}
#'   \item{AESOC}{Body system or organ class code}
#'
#'   \item{AEACN}{Action taken with study treatment}
#'   \item{AEREL}{Causality relationship to study treatment}
#'   \item{AEOUT}{Outcome of the adverse event}
#'
#'   \item{AESTDTC}{Start date/time of adverse event}
#'   \item{AESTDY}{Study day of adverse event start}
#'   \item{AEENDTC}{End date/time of adverse event}
#'   \item{AEENDY}{Study day of adverse event end}
#'   \item{AEDTC}{Date/time of data collection}
#'
#'   \item{AESPID}{Sponsor-defined identifier}
#'   \item{AESCAN}{Cancer flag}
#' }
#'
#' @source Simulated SDTM-like data
"AE"



#' Supplemental Qualifiers for Adverse Events (SUPPAE)
#'
#' A minimal SDTM SUPPAE dataset containing supplemental
#' qualifiers for the AE domain.
#'
#' @format A data frame with 3 rows and 8 variables:
#' \describe{
#'   \item{STUDYID}{Study identifier}
#'   \item{RDOMAIN}{Related domain}
#'   \item{USUBJID}{Unique subject identifier}
#'   \item{IDVAR}{Identifying variable name}
#'   \item{IDVARVAL}{Identifying variable value}
#'   \item{QNAM}{Qualifier variable name}
#'   \item{QLABEL}{Qualifier label}
#'   \item{QVAL}{Qualifier value}
#' }
#'
#' @source Simulated SDTM-like data
"SUPPAE"
