  require 'health-data-standards'
  require 'pry'
  require 'mongoid'
  require_relative 'lib/modules/validate_ccd.rb'

  desc 'validate CCDs'
  task :validate, [:source_dir] do |t,args|
    PatientImport::ValidateCCD.validateFile(args.source_dir)
  end
  
  desc 'import patient records'
  task :patients, [:source_dir, :providers_predefined] do |t, args|
  	Mongoid.load!('./config/mongoid.yml')
    if !args.source_dir || args.source_dir.size==0
      raise "please specify a value for source_dir"
    end
    HealthDataStandards::Import::BulkRecordImporter.import_directory(args.source_dir)
  end