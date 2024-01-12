leagueid <- '385631'






yahoo_url <- "https://football.fantasysports.yahoo.com/f1/385631/players?sort=PTS&sdir=1&status=ALL&pos=QB&stat1=S_PW_1&jsenabled=1&count=0"
document <- rvest::read_html(yahoo_url)

document %>% html_elements(xpath='//*[@id="yui_3_18_1_2_1704006538677_36604"]') %>% html_table()

yahoo_url %>% rvest::read_html() %>% html_elements(., css="#yui_3_18_1_2_1704006538677_36604") %>% html_table()
yahoo_url %>% rvest::read_html() %>% html_elements(., css="table") %>% html_table()

url <- "http://en.wikipedia.org/wiki/List_of_U.S._states_and_territories_by_population"
population <- url %>%
  read_html() %>%
  html_elements(., css="table") %>%
  html_table()
