library(shiny)

shinyUI(bootstrapPage(

  # Application title
  titlePanel("Student Notices"),

  # Sidebar with a slider input for number of bins
      div(style="display:inline-block;vertical-align:top",radioButtons("sender", "Sender type:",
                   c("GSAA"="GSAA", "GSAA PG"="GSAA_PG","GS Cult"="GS_Cult","GSHA"="GSHA", "GS Sports"="GS_Sports"))),
      div(style="display:inline-block;vertical-align:top",selectInput(
        inputId =  "year", 
        label = "Select tenure:", 
        choices = c('2011-12'=2011,'2012-13'=2012,'2013-14'=2013,'2014-15'=2014,'2015-16'=2015)
      )),

    # Show a plot of the generated distribution
      #verbatimTextOutput("ImgText"),
      tabsetPanel(type = "tabs",
      tabPanel("Wordcloud",imageOutput("preImage")),
      tabPanel("Word list",tableOutput("wordlist")))
))
