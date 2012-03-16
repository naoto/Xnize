#!/usr/bin/env ruby

require 'yaml/store'
require 'open-uri'

class Xnize

  CONFIG_PATH = "#{File.dirname(__FILE__)}/data.yaml"
  API = "nRQUQ7Oxg64iz4kPP3vHnFlVeEAcDVx7d_F25U6Dcfpax9o9Xu6yB3VRdfPBZYD.vw--"

  def initialize
   data_load
  end

  def data_load
    @data = YAML::Store.new(CONFIG_PATH)
    @data.transaction do
      if @data[:data].nil?
        @data = {:prefix => [], :suffix => [], :data => []}
      end
    end
  end

  def generate(word)
    @data[:data].each do |key,val|
     eval("word.gsub!(/#{key}/,'#{val}')")
    end
    "#{prefix}#{word}#{suffix}"
  end

  def add(regex, replace)
    @data[:data] << [regex, replace]
    save
  end

  def delete(regex)
    @data[:data].map! do |m|
      m.first == regex ? nil : m
    end
    save
  end

  def add_suffix(replace)
    @data[:suffix] << replace
    save
  end

  def delete_suffix(replace)
    @data[:suffix].delete(replace)
    save
  end

  def add_prefix(replace)
    @data[:prefix] << replace
    save
  end

  def delete_prefix(replace)
    @data[:prefix].delete(replace)
    save
  end

  private
  def prefix
    @data[:prefix].shuffle.first
  end

  def suffix
    @data[:suffix].shuffle.first
  end

end


if $0 == __FILE__
  @nize = Xnize.new
end

