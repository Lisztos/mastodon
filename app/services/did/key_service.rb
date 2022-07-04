class Did::KeyService < BaseService

  def self.parse_jwk(jwk)
    JWT::JWK.import(jwk)
  end

  def self.serialize_to_jwk(did:, key:)
    {
      id: "#{did}#main-key",
      controller: did,
      type: key.type,
      publicJwk: key.jwk
    }
  end

  def self.get_type(keypair)
    type = keypair.oid
    if type.include?("rsa")
      "RSA"
    elsif type.include?("ec")
      "EC"
    end
  end
end