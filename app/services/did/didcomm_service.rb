class Did::DidcommService < BaseService
  class NotDidError < StandardError; end
  class InvalidKeyForActionError < StandardError; end

  attr_accessor :account

  def initialize(payload, account)
    @payload = payload
    @account = account
  end

  def encrypted_payload
    raise NotDidError unless account.is_did?
    encrypted_data = encrypt!
    return encrypted_data
  end

  def decrypted_payload
    raise NotDidError unless account.is_did?

    decrypted_data = decrypt!
    return decrypted_data
  end

  def encrypt!
    Rails.logger.info "Encrypting payload: #{@payload}, with public_key: #{public_key}"
    JWE.encrypt(@payload, public_key)
  end

  def decrypt!
    raise InvalidKeyForActionError unless @private_key.private?
    JWE.decrypt(@payload, private_key)
  end
    

  # private

  def public_key
    @public_key ||= if account.keys.empty?
                      Did::FetchDidcommKeyService.new.call(account.username)
                    else
                      key = account.keys.keyAgreement.first.public_key
                      OpenSSL::PKey::RSA.new(key)
    end
  end

  def private_key
    key = account.keys.keyAgreement.first.private_key
    @private_key ||= OpenSSL::PKey::RSA.new(key)
  end

end
