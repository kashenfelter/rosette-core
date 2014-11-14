# encoding: UTF-8

module Rosette
  module Core

    class Phrase
      include PhraseIndexPolicy
      include PhraseToHash

      attr_reader :key, :meta_key
      attr_accessor :file, :commit_id, :author_name, :author_email, :commit_datetime

      def initialize(key, meta_key = nil, file = nil, commit_id = nil, author_name = nil, author_email = nil, commit_datetime = nil)
        @key = key
        @meta_key = meta_key
        @file = file
        @commit_id = commit_id
        @author_name = author_name
        @author_email = author_email
        @commit_datetime = commit_datetime
      end

      def self.from_h(hash)
        if hash
          new(
            hash[:key], hash[:meta_key],
            hash[:file], hash[:commit_id],
            hash[:author_name], hash[:author_email],
            hash[:commit_datetime]
          )
        end
      end
    end

  end
end
