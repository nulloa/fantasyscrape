#' Generate the yahoo url to pull the data
#'
#' Use this function to generate the yahoo fantasy football url from which the
#' data will be pulled.
#'
#' @param league_id The league id for the league to be scraped. Will break if
#' not specified.
#' @param stat_type The projection type requested. Has to be one of
#' \code{c("Projected",  "Actual")}.
#' If omitted then Projected stats will be scraped
#' @param position The player position to scrape data for. Has to be one of
#' \code{c("O", "DP", "QB", "RB", "WR", "TE", "K", "DEF", "D", "DB", "DL", "LB", "DT", "DE", "CB", "S")}.
#' Only one allowed.
#' @param season The year data should be scraped for. If omitted the current
#' season data will be scraped.
#' @param week The week that data will be scraped for. If omitted, season data
#' from the current week will be scraped up to Week 18.
#' @import httr tidyverse
#' @export


get_yahoo_url <- function(league_id = NULL,
                          stat_type = c("Projected",  "Actual"),
                          position = c("O", "DP", "QB", "RB", "WR", "TE", "K", "DEF",
                                       "D", "DB", "DL", "LB", "DT", "DE", "CB", "S"),
                          season = NULL, week = NULL, count=0){


  # Check if season is set
  if(is.null(season))
    season <- current_season()

  # Check if season is appropriate
  if(season > current_season()){
    stop("Invalid season. Please specify ", current_season(), " or earlier", call. = FALSE)
  }

  # Check if week is set
  if(!is.null(week) && week != 0){
    if(!(week %in% 1:17))
      stop("When specifying a week please only use numbers between 1 and 17", call. = FALSE)
  }

  # Check if leagueID is set
  if(is.null(league_id))
    stop("Yahoo League ID is not set. Please set it.", call. = FALSE)

  yahoo_base <- str_to_url("https://football.fantasysports.yahoo.com/f1/")

  yahoo_qry <- list(sort = "PTS", sdir = "1", status = "ALL", pos = ifelse(position == "DST", "DEF", position),
                    stat1 = "", jsenabled = 1, count = 0)

  yahoo_qry$stat1 <- switch(
    stat_type,
    "Projected" = paste0("S_PW_", week),
    "Actual" = paste0("S_W_", week)
  )

  yahoo_path <- paste(league_id, "players", sep = "/")
  yahoo_path <- paste0(httr::parse_url(yahoo_base)$path, yahoo_path)

  yahoo_url <- modify_url(yahoo_base, path = yahoo_path, query = yahoo_qry)







}
