require 'fileutils'

module ToolBelt
  class MashScriptsBuilder
    attr_accessor :path, :tags, :gpgkey

    def initialize(config)
      self.tags = config.options[:mash_scripts]
      self.gpgkey = config.options[:gpg_key]

      self.path = "./mash_scripts/#{config.options[:namespace]}"
      FileUtils.mkpath(self.path)
    end

    def create_mash_scripts
      self.tags.each do |tag|
        filename = File.join(self.path, "#{tag}.mash")
        script = MashScript.new(filename, :tag => tag, :gpgkey => self.gpgkey)
        script.write_file
      end
    end
  end
end
