class Did::DidDocumentService < BaseService

  def self.create_service(did:, service_name:)
    {
      id: "#{did}##{service_name}",
      type: "#{service_name}",
      serviceEndpoint: "https://lisztos.com/users/@#{did}"
    }
  end
end