# == Schema Information
#
# Table name: keys
#
#  id          :bigint(8)        not null, primary key
#  purpose     :integer
#  type        :string
#  public_key  :text
#  private_key :text
#  jwk         :json
#  account_id  :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null

class Key < ApplicationRecord
  self.inheritance_column = nil
  enum purpose: { publicKey: 0, authentication: 1, keyAgreement: 2, assertionMethod: 3, capabilityDelegation: 4, capabilityInvocation: 5 }

  belongs_to :account
  after_create :to_jwk

  def to_jwk
    rsa = OpenSSL::PKey::RSA.new(private_key)
    jwk = JWT::JWK.new(rsa)

    self.jwk = jwk.export
    self.save!
  end

  def to_keypair
    OpenSSL::PKey::RSA.new(private_key || public_key)
  end
end

