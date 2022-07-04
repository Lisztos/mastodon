# frozen_string_literal: true

class Did::DidDocumentParserService < BaseService

  def self.parse_did_document(json)
    DidDocument.new(json)
  end
end