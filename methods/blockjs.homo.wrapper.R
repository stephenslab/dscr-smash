# define your methods in .R files like this one in the methods subdirectory each method should take arguments input and
# args, like the example the output should be a list of the appropriate 'output' format (defined in the README)

# Make sure to add path to bin directory in matlab to R's path variable using add_path() 
# Make sure to add path to methods folder in matlab!


blockjs.homo.wrapper = function(input, args) {
  write(input$x, "input/ml_in.txt", ncolumns = length(input$x))
  system("matlab -nodisplay -nodesktop -r \"run('methods/blockjs_matlab.m')\"")
  if (Sys.info()["sysname"] == "Windows") {
    while (!file.exists("input/ml_out.csv")) {
      Sys.sleep(5)
    }
  }
  mu.est = as.vector(read.csv("input/ml_out.csv", header = FALSE))
  system("rm input/ml_in.txt input/ml_out.csv")
  return(mu.est)
} 