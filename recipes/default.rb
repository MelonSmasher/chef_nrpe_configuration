#
# Cookbook:: nrpe_configuration
# Recipe:: default
#

def create_template(source_template, path)
  template path do
    source source_template
  end
end

# Set the firefox installation base directory
install_path = File.join(node['nrpe_configuration']['install_directory'], "")

# Make sure that directory exists
if File.directory?(install_path)

  # Devise the config file path
  ini_file_path = File.join(install_path, 'nsclient.ini')

  # Create the file from the template
  create_template('nsclient.ini.erb', ini_file_path)

else
  # If it does not exists throw a fatal error
  log 'NRPE Install Not Found' do
    message "Could not locate the NRPE installation directory at: #{install_path} ... Aborting!"
    level :fatal
  end
end