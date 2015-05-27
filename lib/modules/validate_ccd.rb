require 'rubygems'
require 'nokogiri'
require 'logging'
require 'fileutils'

module PatientImport
	class ValidateCCD
		def self.validateFile(source_dir)
          files = Dir.glob(File.join(source_dir, '*.*'))
          files.each do |file|
          	self.validateMRN(file,File.new(file).read)
      	  end
		end

		def self.validateMRN(file,xmlData)
			logger = Logging.logger(STDOUT)
      doc = Nokogiri::XML(xmlData)
      root_element_name = doc.root.name
    	logger.debug file

        if root_element_name == 'ClinicalDocument'
          doc.root.add_namespace_definition('cda', 'urn:hl7-org:v3')
          doc.root.add_namespace_definition('sdtc', 'urn:hl7-org:sdtc')

        else
          return {status: 'error', message: 'Unknown XML Format', status_code: 400}          
				end
			if doc.xpath('//cda:patientRole/cda:id/@extension').text == ''
				logger.debug 'no medical record number found'
			else
				logger.debug doc.xpath('//cda:patientRole/cda:id/@extension').text
			end
		end
	end
end