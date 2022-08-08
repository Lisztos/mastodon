class Did::DidcommService < BaseService
  class NotDidError < StandardError; end
  class InvalidKeyForActionError < StandardError; end
  class PrivateKeyMissingError < StandardError; end

  attr_accessor :from_account, :to_account, :direction

  def initialize(payload:, from_account: nil, to_account:, direction:)
    @payload      = payload
    @from_account = from_account
    @to_account   = to_account
    @direction    = direction
  end

  def set_from_account
    #Decode JWT without verification to get DID of issuer
    unverified_jwt = JWT.decode decrypted_payload, nil, false, { algorithm: 'RS256' }

    sender_did = unverified_jwt[1].dig('issuer')
    
    @from_account ||= Mediators::ResolveAccountMediator.mediate_account_resolving(sender_did)
    Rails.logger.info "Found account for did: #{sender_did}, @from_account: #{@from_account.try(:display_name)}"
  end

  def encrypted_payload
    raise NotDidError unless to_account.is_did?
    encrypted_data = encrypt!
    return Oj.dump({'payload' => encrypted_data})
  end

  def decrypted_payload
    raise NotDidError unless to_account.is_did?
    decrypt!
  end

  def verified_payload_and_signer
    set_from_account if from_account.nil?

    [JWT.decode(decrypted_payload, public_key(from_account), true, { algorithm: 'RS256' })[0], from_account]
  end

  def encrypt!
    Rails.logger.info "Encrypting payload: #{@payload}, with public_key: #{public_key(to_account)}"

    if direction == :outgoing && from_account.present? && to_account.present?
      JWE.encrypt(signed_payload, public_key(to_account))
    end
  end

  def signed_payload
    private_key = private_key(from_account)
    JWT.encode(@payload, private_key, 'RS256', { issuer: from_account.username })
  end

  def decrypt!
    Rails.logger.info "Account for decryption: #{to_account.try(:display_name)}"
    private_key = private_key(to_account)
    
    raise InvalidKeyForActionError unless private_key.private?
    return unless direction == :incoming && to_account.present?

    Rails.logger.info "Decrypting Data: #{@payload} with private key of account: #{to_account.try(:display_name)}}"

    JWE.decrypt(@payload, private_key)
  end
    

  private

  def public_key(account)
    if account.local?
      key = account.keys.keyAgreement.first.public_key
      OpenSSL::PKey::RSA.new(key)
    else
      Rails.logger.info "Fetching Key from DID Document for account: #{account.try(:display_name)}"
      Did::FetchDidcommKeyService.new.call(account.username)
    end
  end

  def private_key(account)
    OpenSSL::PKey::RSA.new(key_from_account(account))
  end

  def key_from_account(account)
    raise PrivateKeyMissingError unless account.local?
    key = account.keys.keyAgreement.first.private_key
  end

end