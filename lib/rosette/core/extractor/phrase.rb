# encoding: UTF-8

module Rosette
  module Core

    class Phrase
      attr_reader :key, :meta_key
      attr_accessor :file, :commit_id

      def initialize(key, meta_key = nil, file = nil, commit_id = nil)
        @key = key
        @meta_key = meta_key
        @file = file
        @commit_id = commit_id
      end

      def to_h
        { key: key, meta_key: meta_key, file: file, commit_id: commit_id }
      end
    end

  end
end