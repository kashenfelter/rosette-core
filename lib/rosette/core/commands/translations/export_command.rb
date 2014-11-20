# encoding: UTF-8

require 'stringio'
require 'base64'

module Rosette
  module Core
    module Commands

      class ExportCommand < GitCommand
        attr_reader :locale, :serializer, :base_64_encode, :encoding, :include_snapshot

        include WithRepoName
        include WithRef
        include WithLocale

        include WithSnapshots

        validate :serializer, serializer: true
        validate :encoding, encoding: true

        def set_serializer(serializer)
          @serializer = serializer
          self
        end

        def set_base_64_encode(should_encode)
          @base_64_encode = should_encode
          self
        end

        # eg. UTF-8, UTF-16BE, etc
        def set_encoding(encoding)
          @encoding = encoding
          self
        end

        def set_include_snapshot(should_include_snapshot)
          @include_snapshot = should_include_snapshot
          self
        end

        def execute
          stream = StringIO.new
          repo_config = get_repo(repo_name)
          serializer_config = get_serializer_config(repo_config)
          serializer_instance = serializer_config.klass.new(stream, encoding)
          snapshot = take_snapshot(repo_config, commit_id)
          translation_count = 0

          each_translation(repo_config, snapshot) do |trans|
            trans = apply_preprocessors(trans, serializer_config)

            serializer_instance.write_key_value(
              trans.phrase.index_value, trans.translation
            )

            translation_count += 1
          end

          serializer_instance.flush

          params = {
            payload: encode(stream.string),
            encoding: serializer_instance.encoding.to_s,
            translation_count: translation_count,
            base_64_encoded: base_64_encode,
            locale: locale
          }

          if include_snapshot
            params.merge!(snapshot: snapshot)
          end

          params
        end

        private

        def apply_preprocessors(translation, serializer_config)
          serializer_config.preprocessors.inject(translation) do |trans, preprocessor|
            preprocessor.process(trans)
          end
        end

        def encode(string)
          if base_64_encode
            Base64.encode64(string)
          else
            string
          end
        end

        def get_serializer_config(repo_config)
          repo_config.get_serializer_config(serializer)
        end

        def each_translation(repo_config, snapshot)
          datastore.translations_by_commits(repo_name, locale, snapshot) do |trans|
            yield trans
          end
        end
      end

    end
  end
end
