require 'active_support/concern'

module Pageable
  extend ActiveSupport::Concern

  STATES = {
    draft: 0,
    published: 1,
    archived: 2
  }

  included do
    has_one :seo_meta, as: :seo_meta

    scope :published, -> { where(state: STATES[:published]) }
    scope :draft, -> { where(state: STATES[:draft]) }
  end

  def draft?
    self.state == 0
  end

  def published?
    self.state == 1
  end

  module ClassMethods
    def by_slug(slug)
      self.find_by(slug: slug)
    end

    def by_template(template)
      self.where(template: template).first
    end
  end
end

