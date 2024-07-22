require 'fileutils'
require 'time'

# Define the path to the include files directory and the data file
includes_dir = File.join(Dir.pwd, '_includes')
data_file = File.join(Dir.pwd, '_data', 'include_files.yml')

# Initialize a hash to store the file modification times
include_files_data = {}

# Iterate over each file in the _includes directory
Dir.foreach(includes_dir) do |file|
  next if file == '.' || file == '..'
  file_path = File.join(includes_dir, file)
  
  if File.file?(file_path)
    # Get the last modified time of the file
    last_modified = File.mtime(file_path).strftime("%Y-%m-%d %H:%M:%S")
    include_files_data[file] = { 'last_modified' => last_modified }
  end
end

# Write the data to the YAML file
File.open(data_file, 'w') do |f|
  require 'yaml'
  f.write(include_files_data.to_yaml)
end

puts "Updated #{data_file} with last modified dates."