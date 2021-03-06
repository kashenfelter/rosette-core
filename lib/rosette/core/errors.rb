# encoding: UTF-8

module Rosette
  module Core

    # Represents a generic syntax error that probably occurred when attempting
    # to parse a bit of source code or other well-defined text format.
    #
    # @!attribute [r] message
    #   @return [String] the error message.
    # @!attribute [r] original_exception
    #   @return [Exception] the original exception, probably from a parser of
    #     some kind.
    # @!attribute [r] language
    #   @return [Symbol] the language that the text the parser attempted to
    #     parse was in when this error was generated.
    class SyntaxError < StandardError
      attr_reader :message, :original_exception, :language

      # Creates a new syntax error object.
      #
      # @param [String] msg The error message text.
      # @param [Exception] original_exception The original error from the
      #   parser or some such.
      # @param [Symbol] language The source code language.
      def initialize(msg, original_exception, language)
        super(msg)
        @message = msg
        @original_exception = original_exception
        @language = language
      end

      # A string representation of this error which combines both the original
      # message as well as the language.
      #
      # @return [String]
      def message
        "#{@message} (#{language})"
      end

      alias :to_s :message
    end

    # Represents a generic syntax error generated by one of Rosette's
    # extractors. Since extractors parse source code and other
    # well-defined text formats, there's always the possibility that these formats
    # will contain syntax errors.
    #
    # @!attribute [r] original_exception
    #   @return [Exception] the original error from the parser or some such.
    # @!attribute [r] language
    #   @return [Symbol] the source code language.
    # @!attribute [r] file
    #   @return [String] the file that was being parsed when the error was
    #     generated.
    # @!attribute [r] commit_id
    #   @return [String] the commit id that contained the file that was being
    #     parsed when the error was generated.
    class ExtractionSyntaxError < StandardError
      attr_reader :original_exception, :language, :file, :commit_id

      # Creates a new syntax error object.
      #
      # @param [String] msg The error message text.
      # @param [Exception] original_exception The original error from the
      #   parser or some such.
      # @param [Symbol] language The source code language.
      # @param [String] file The file that was being parsed when the error
      #   was generated.
      # @param [String] commit_id The commit id that contained the file that
      #   was being parsed when the error was generated.
      def initialize(msg, original_exception, language, file, commit_id)
        super(msg)
        @message = msg
        @original_exception = original_exception
        @language = language
        @file = file
        @commit_id = commit_id
      end

      # A string representation of this error which includes the original
      # message, the source language, the file, and the commit id.
      #
      # @return [String]
      def message
        "#{@message}: #{original_exception.message} (#{language}) in #{file} at #{commit_id}"
      end

      alias :to_s :message
    end

  end
end
