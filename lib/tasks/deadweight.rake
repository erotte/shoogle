begin
  require 'deadweight'
rescue LoadError
end

desc "run Deadweight CSS check (requires script/server)"
task :deadweight do
  dw = Deadweight.new
  dw.stylesheets = ["/stylesheets/application.css"]
  dw.pages = ["/", "/feet"]
  puts dw.run
end