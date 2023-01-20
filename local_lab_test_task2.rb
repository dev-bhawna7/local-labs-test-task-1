# Need to install pdf-reader gem & set the diorectory file where pdf is present
require 'pathname'
require 'pdf-reader'

# The directory path you want to iterate through
directory_path = "/home/system11/Downloads/pdf_files/PDFs"

# Iterate through all the files in the directory
extracted_data = []
Dir.glob(File.join(directory_path, '*')).each do |file|
  # Open the PDF file
  reader = PDF::Reader.new(file)

  # Iterate over the pages of the PDF file
  full_pdf_text = ''
  reader.pages.each do |page|
    # Extract the text from each page
    full_pdf_text.concat(page.text)
  end
  next if full_pdf_text.empty?
  state_name_arr = full_pdf_text.split("State of").last
  state_name = state_name_arr.split(" ").first
  if full_pdf_text.include?("Petitioners")
    petitioner = full_pdf_text.split('Alaska')[1].split(', ').first.strip
  end
  pdf_data = {
    'petitioner': petitioner,
    'state': "State of " + state_name,
    'amount': full_pdf_text.scan(/\$\d{1,5}.\d{1,9}.\d{1,2}/).first,
    'date': full_pdf_text.scan(/\d{1,2}\/\d{1,2}\/\d{1,4}/).first
  }
  extracted_data << pdf_data
end

puts  extracted_data