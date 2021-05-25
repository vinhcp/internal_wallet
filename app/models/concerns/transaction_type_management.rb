module TransactionTypeManagement
  extend ActiveSupport::Concern

  def self.included(base)
    base.extend(ClassMethods)
  end

  # Class Methods
  module ClassMethods
    class MissingTransactionType < StandardError; end

    def class_for_type(type)
      type = type.to_s
      "TransactionType::#{type.camelize}".safe_constantize || raise_missing_type_error(type)
    end

    def raise_missing_type_error(type)
      message = "Cannot find TransactionType \"#{type}\". Be sure to define class " \
                "\"#{type.classify}\" at app/models/ transaction_type/#{type}.rb"
      raise MissingTransactionType.new(message)
    end

    def transaction_types
      Dir.children(Rails.root.join('app', 'models', 'transaction_type')).map do |file|
        file.sub('.rb', '')
      end
    end
  end

  def transaction_type
    type.sub('TransactionType::', '')
  end
end
