module I18n
  class << self
    alias_method :original_localize, :localize

    def localize(object, options = {})
      object.present? ? original_localize(object, options) : ''
      # i18nがnilを返したら空白を入れる
    end
  end
end