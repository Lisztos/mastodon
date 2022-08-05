# frozen_string_literal: true
module Did::AccountFinderConcern
  extend ActiveSupport::Concern

  class_methods do
    def find_local!(did)
      find_local(did) || raise(ActiveRecord::RecordNotFound)
    end

    def find_remote!(did, domain)
      find_remote(did) || raise(ActiveRecord::RecordNotFound)
    end

    def representative
      Account.find(-99)
    rescue ActiveRecord::RecordNotFound
      Account.create!(id: -99, actor_type: 'Application', locked: true, username: Rails.configuration.x.local_domain)
    end

    def find_local(did)
      find_remote(did, nil)
    end

    def find_remote(did)
      AccountFinder.new(did).account
    end
  end

  class AccountFinder
    attr_reader :did

    def initialize(did)
      @did = did
    end

    def account
      scoped_accounts.order(id: :asc).take
    end

    private

    def scoped_accounts
      Account.unscoped.tap do |scope|
        scope.merge! with_usernames
        scope.merge! matching_username
      end
    end

    def with_usernames
      Account.where.not(Account.arel_table[:username].lower.eq '')
    end

    def matching_username
      Account.where(Account.arel_table[:username].lower.eq did.to_s.downcase)
    end

  end
end
