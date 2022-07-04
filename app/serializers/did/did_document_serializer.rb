# frozen_string_literal: true

class Did::DidDocumentSerializer < ActiveModel::Serializer
  include RoutingHelper

  attributes :context, :id, :publicKey, :authentication, :assertionMethod, :capabilityDelegation, :capabilityInvocation, :keyAgreement, :service

  CONTEXT = 'https://www.w3.org/ns/did/v1'

  def context
    CONTEXT
  end

  def id
    did
  end

  def publicKey
    Did::KeyService.serialize_to_jwk(did: did, key: object.keys.publicKey.first) 
  end

  def authentication
    ["#{did}#main-key"]
  end

  def assertionMethod
    ["#{did}#main-key"]
  end

  def capabilityDelegation
    ["#{did}#main-key"]
  end

  def capabilityInvocation
    ["#{did}#main-key"]
  end

  def keyAgreement
    Did::KeyService.serialize_to_jwk(did: did, key: object.keys.keyAgreement.first) 
  end

  def service
    [Did::DidDocumentService.create_service(did: did, service_name: "ActivityPub")]
  end

  private

  def did
    object.username
  end
end
