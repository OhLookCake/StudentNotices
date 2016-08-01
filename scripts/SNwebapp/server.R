library(shiny)
load("emaildatacleaned.RData")

shinyServer(function(input, output) {
  
  tableData <- reactive({
    s <- input$sender
    y <- input$year
    filename <- normalizePath(file.path('./data/WordCount',
                                        paste0(input$sender,'_',substr(as.numeric(input$year),3,4),'-',substr(as.numeric(input$year)+1,3,4)," WordCount", '.txt')))
    t<-read.table(filename,header = TRUE,sep = " ")
    df=data.frame(word=t$word,frequency=t$freq)
    df
  })
  
  output$preImage <- renderImage({
    # When input$n is 3, filename is ./images/image3.jpeg
    filename <- normalizePath(file.path('./data/img',
                                        paste0(input$sender,'_cloud_',substr(as.numeric(input$year),3,4),'-',substr(as.numeric(input$year)+1,3,4), '.jpeg')))
    
    # Return a list containing the filename and alt text
    list(src = filename,
         alt = paste("Image number", input$sender))
    
  }, deleteFile = FALSE)  
    
#   output$ImgText  <- renderText({
#     paste("You have selected", 
#           paste0(as.character(input$year)," ",input$sender )
#     )
#   })
  
  output$wordlist <- renderTable({tableData()})

})
