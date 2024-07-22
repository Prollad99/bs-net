require 'rake'

desc 'Update include files metadata'
task :update_include_files do
  ruby 'update_include_files.rb'
end

desc 'Build the site and update include files metadata'
task :build do
  Rake::Task['update_include_files'].invoke
  sh 'jekyll build'
end
