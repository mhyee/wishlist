# Initializes sensitive information from a YAML file
# Workaround to avoid storing passwords in repo
# http://stackoverflow.com/a/3208547

module Secrets
  def self.[](key)
    unless @config
      raw_config = File.read("#{Rails.root}/config/secrets.yml")
      @config = YAML.load(raw_config)[Rails.env].symbolize_keys
    end
    @config[key]
  end

  def self.[]=(key, value)
    @config[key.to_sym] = value
  end

end
